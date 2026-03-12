# Neovim
function v(){
  if [[ "$#" -eq 0 ]]; then
    command nvim "."
    return 0
  fi
  command nvim "$@"
}

# Kubectl
function kexec() {
  # 1. Select Namespace
  local namespace
  # Added a prompt and reverse layout for better UX
  namespace=$(kubectl get namespace --no-headers | fzf --prompt="Select Namespace: " --layout=reverse --height=40% | awk '{print $1}')
  
  # Exit gracefully if the user cancels (presses Esc)
  [[ -z "$namespace" ]] && return 1

  # 2. Select Pod
  local pod
  # Suppress errors if a namespace has no pods, and removed the duplicate --no-headers
  pod=$(kubectl get pods -n "$namespace" --no-headers 2>/dev/null | fzf --prompt="Select Pod: " --layout=reverse --height=40% | awk '{print $1}')
  
  # Exit gracefully if the user cancels or if there are no pods
  [[ -z "$pod" ]] && return 1

  # 3. Determine the command
  # Defaults to "bash", but allows you to pass custom commands (like "sh")
  local cmd="${@:-bash}"

  # 4. Execute with visual feedback
  echo -e "\n🚀 Exec-ing into \033[1m$pod\033[0m (Namespace: \033[1m$namespace\033[0m)...\n"
  kubectl exec -it "$pod" -n "$namespace" -- $cmd
}
