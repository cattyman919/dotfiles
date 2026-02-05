# Double-fzf function to login to AWS SSO and then select an EKS cluster
eks-login() {
  local profile_name cluster_list selected_cluster_info cluster_name region

  # 1. Use your fzf command to select the profile
  profile_name=$(cat ~/.aws/config | grep "\[profile" | sed 's/\[profile \?//g; s/\]//g' | fzf)

  # 2. Exit if user pressed Esc (no profile selected)
  if [[ -z "$profile_name" ]]; then
    echo "No profile selected. Aborting."
    return 1
  fi

  echo "Selected profile: $profile_name"
  echo "Attempting AWS SSO login..."

  # 3. Log in using AWS SSO
  if ! aws sso login --profile "$profile_name"; then
    echo "AWS SSO login failed. Aborting."
    return 1
  fi

  echo "SSO login successful."
  echo "Fetching EKS clusters from ap-southeast-1 and ap-southeast-3..."

  # 4. Helper function to find clusters in specific regions
  _get_all_clusters() {
    local target_regions="ap-southeast-1 ap-southeast-3"

    # Header line for fzf
    echo "Cluster Name,Region"

    for r in $target_regions; do
      echo "Checking region: $r..." >&2
      local clusters_in_region=$(aws eks list-clusters --profile "$profile_name" --region "$r" --query "clusters[]" --output text 2>/dev/null)

      for c in $clusters_in_region; do
        echo "$c,$r"
      done
    done
  }

  # 5. Run the helper and pipe the list into fzf
  cluster_list=$(_get_all_clusters)

  if [[ $(echo "$cluster_list" | wc -l) -le 1 ]]; then
    echo "No EKS clusters found for profile '$profile_name' in ap-southeast-1 or ap-southeast-3."
    return 1
  fi

  # 6. Run fzf to select the cluster
  # --- MODIFIED PREVIEW COMMAND ---
  selected_cluster_info=$(echo "$cluster_list" | \
    fzf --header-lines=1 \
        --preview="
          # Get vars from fzf's input line
          cluster_info={}
          cluster_name=\$(echo \$cluster_info | cut -d',' -f1)
          region_name=\$(echo \$cluster_info | cut -d',' -f2)

          # 1. Show status (this part is fast)
          aws eks describe-cluster --profile $profile_name --name \$cluster_name --region \$region_name --query cluster.status 2>/dev/null

          echo '---'
          echo 'Namespaces (loading...):'

          # 2. Get namespaces (this part is slow)
          # Create a unique, temporary kubeconfig file
          TMP_KUBECONFIG=\$(mktemp)

          # Ensure the temp file is cleaned up when the preview command exits
          trap \"rm -f \$TMP_KUBECONFIG\" EXIT

          # Generate the temp config, hiding all 'Updated context...' messages
          if aws eks update-kubeconfig --profile $profile_name --name \$cluster_name --region \$region_name --kubeconfig \$TMP_KUBECONFIG &>/dev/null; then
            # If successful, list namespaces
            kubectl --kubeconfig \$TMP_KUBECONFIG get ns --no-headers -o custom-columns=NAME:.metadata.name
          else
            echo 'Failed to generate temp kubeconfig.'
          fi
        ")

  # 7. Exit if user pressed Esc (no cluster selected)
  if [[ -z "$selected_cluster_info" ]]; then
    echo "No cluster selected. Aborting."
    return 1
  fi

  # 8. Parse the "Cluster,Region" string
  cluster_name=$(echo "$selected_cluster_info" | cut -d',' -f1)
  region=$(echo "$selected_cluster_info" | cut -d',' -f2)

  echo "Updating kubeconfig for cluster '$cluster_name' in region '$region'..."

  # 9. Update kubeconfig
  if aws eks update-kubeconfig --name "$cluster_name" --region "$region" --profile "$profile_name"; then
    echo "Kubeconfig updated successfully!"
    echo "You can now use: kubectl get nodes"
  else
    echo "Failed to update kubeconfig."
    return 1
  fi
}
function ec2_metrics() {
    # --- 0. Dependencies Check ---
    if ! command -v fzf &> /dev/null; then echo "Error: fzf is not installed."; return 1; fi
    if ! command -v aws &> /dev/null; then echo "Error: AWS CLI is not installed."; return 1; fi
    if ! command -v jq &> /dev/null; then echo "Error: jq is not installed."; return 1; fi

    # --- 1. Select Profile ---
    local profile="$1"
    if [[ -z "$profile" ]]; then
        profile=$(aws configure list-profiles | fzf --height=20% --layout=reverse --border --prompt="Select AWS Profile > ")
    fi
    [[ -z "$profile" ]] && { echo "No profile selected."; return 1; }

    # --- 2. Select Region ---
    local region="$2"
    if [[ -z "$region" ]]; then
        local config_region
        config_region=$(aws configure get region --profile "$profile")

        if [[ -n "$config_region" ]]; then
            read -p "Use region $config_region from config? (Y/n): " confirm
            if [[ "$confirm" =~ ^[Nn] ]]; then
                region=$(printf "us-east-1\nus-east-2\nus-west-1\nus-west-2\neu-west-1\nap-southeast-1\nap-southeast-2\nap-southeast-3" | fzf --height=20% --layout=reverse --border --prompt="Select Region > ")
            else
                region="$config_region"
            fi
        else
            region=$(printf "us-east-1\nus-east-2\nus-west-1\nus-west-2\neu-west-1\nap-southeast-1\nap-southeast-2\nap-southeast-3" | fzf --height=20% --layout=reverse --border --prompt="Select Region > ")
        fi
    fi
    [[ -z "$region" ]] && { echo "No region selected."; return 1; }

    # --- 3. Select Instance ---
    local instance_id="$3"
    if [[ -z "$instance_id" ]]; then
        echo "Fetching instances in $region ($profile)..."
        local selection
        selection=$(aws ec2 describe-instances \
            --profile "$profile" \
            --region "$region" \
            --query 'Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,Name:Tags[?Key==`Name`]|[0].Value,State:State.Name}' \
            --output text | \
            column -t | \
            fzf --height=40% --layout=reverse --border --header="Instance ID | Type | Name | State" --prompt="Select Instance > ")

        instance_id=$(echo "$selection" | awk '{print $1}')
    fi
    [[ -z "$instance_id" ]] && { echo "No instance selected."; return 1; }

    echo "Querying details for $instance_id..."

    # --- 4. Fetch Instance Details (Type & Tags) ---
    local instance_data
    instance_data=$(aws ec2 describe-instances \
        --profile "$profile" \
        --region "$region" \
        --instance-ids "$instance_id" \
        --query 'Reservations[0].Instances[0]' \
        --output json)

    local instance_type
    instance_type=$(echo "$instance_data" | jq -r '.InstanceType')

    # --- JQ LOGIC: COMBINE NODEGROUP + CLUSTER NAME ---
    local manager_info
    manager_info=$(echo "$instance_data" | jq -r '
        .Tags |
        if . == null then
            "Standard EC2 (No Tags)"
        else
            (map({ (.Key): .Value }) | add) as $tags |

            # Priority 1: EKS Managed Node Group
            if ($tags | has("eks:nodegroup-name")) then
                "EKS Managed Node Group: " + $tags["eks:nodegroup-name"] +
                # Append Cluster Name if it exists (checking both standard AWS key and generic key)
                if ($tags | has("aws:eks:cluster-name")) then
                    " [Cluster: " + $tags["aws:eks:cluster-name"] + "]"
                elif ($tags | has("eks:cluster-name")) then
                    " [Cluster: " + $tags["eks:cluster-name"] + "]"
                else
                    ""
                end

            # Priority 2: Karpenter (New)
            elif ($tags | has("karpenter.sh/nodepool")) then
                "Karpenter NodePool: " + $tags["karpenter.sh/nodepool"] +
                if ($tags | has("aws:eks:cluster-name")) then
                    " [Cluster: " + $tags["aws:eks:cluster-name"] + "]"
                elif ($tags | has("eks:cluster-name")) then
                    " [Cluster: " + $tags["eks:cluster-name"] + "]"
                else
                    ""
                end

            # Priority 3: Karpenter (Old)
            elif ($tags | has("karpenter.sh/provisioner-name")) then
                "Karpenter Provisioner: " + $tags["karpenter.sh/provisioner-name"]

            else
                "Standard EC2 / Self-Managed"
            end
        end
    ')

    # --- 5. Fetch CloudWatch Metrics (2 Weeks) ---
    local duration_seconds=1209600
    local end_time start_time

    end_time=$(python3 -c 'from datetime import datetime, timezone; print(datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"))')
    start_time=$(python3 -c 'from datetime import datetime, timedelta, timezone; print((datetime.now(timezone.utc) - timedelta(weeks=2)).strftime("%Y-%m-%dT%H:%M:%SZ"))')

    get_metric() {
        local name=$1
        local unit=$2
        local stat=$3

        aws cloudwatch get-metric-statistics \
            --profile "$profile" \
            --region "$region" \
            --namespace AWS/EC2 \
            --metric-name "$name" \
            --dimensions Name=InstanceId,Value="$instance_id" \
            --start-time "$start_time" \
            --end-time "$end_time" \
            --period "$duration_seconds" \
            --statistics "$stat" \
            --unit "$unit" \
            --output text \
            --query "Datapoints[0].$stat"
    }

    local cpu_avg=$(get_metric "CPUUtilization" "Percent" "Average")
    local net_in_sum=$(get_metric "NetworkIn" "Bytes" "Sum")
    local net_out_sum=$(get_metric "NetworkOut" "Bytes" "Sum")

    # --- 6. Display Results ---
    echo ""
    echo "=========================================="
    echo " Target:     $instance_id"
    echo " Type:       $instance_type"
    echo " Profile:    $profile"
    echo " Region:     $region"
    echo " Managed By: $manager_info"
    echo " Window:     Last 14 Days (2 Weeks)"
    echo "=========================================="

    if [[ "$cpu_avg" == "None" ]] || [[ -z "$cpu_avg" ]]; then
        echo " CPU Avg:      No Data"
    else
        printf " CPU Avg:      %.2f %%\n" "$cpu_avg"
    fi
    echo "------------------------------------------"

    if [[ "$net_in_sum" != "None" ]] && [[ -n "$net_in_sum" ]]; then
        local net_in_gb=$(echo "$net_in_sum / 1073741824" | bc -l)
        local net_in_rate=$(echo "$net_in_sum / $duration_seconds / 1024" | bc -l)
        printf " Network In:   %.2f GB (Total)\n" "$net_in_gb"
        printf "               %.2f KB/s (Avg Rate)\n" "$net_in_rate"
    else
         echo " Network In:   No Data"
    fi

    if [[ "$net_out_sum" != "None" ]] && [[ -n "$net_out_sum" ]]; then
        local net_out_gb=$(echo "$net_out_sum / 1073741824" | bc -l)
        local net_out_rate=$(echo "$net_out_sum / $duration_seconds / 1024" | bc -l)
        printf " Network Out:  %.2f GB (Total)\n" "$net_out_gb"
        printf "               %.2f KB/s (Avg Rate)\n" "$net_out_rate"
    else
         echo " Network Out:  No Data"
    fi
    echo "=========================================="
}
