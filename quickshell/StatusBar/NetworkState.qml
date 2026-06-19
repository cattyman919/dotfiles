import QtQuick
import Quickshell
import Quickshell.Networking
pragma Singleton

Singleton {
    id: root

    property string status: "Loading..."
    property string icon: "\udb81\udda9" // Default Wi-Fi icon

    function updateNetworkState() {
        let activeWifi = null;
        let activeWired = null;
        // Iterate through devices to find active connections
        for (let i = 0; i < Networking.devices.values.length; i++) {
            const device = Networking.devices.values[i];
            switch (device.state) {
            case ConnectionState.Connected:
                switch (device.type) {
                case DeviceType.Wifi:
                    activeWifi = device;
                    break;
                case DeviceType.Wired:
                    activeWired = device;
                    break;
                }
                break;
            }
        }
        // Update properties based on priority (Wired > Wi-Fi > Disconnected)
        if (activeWired) {
            root.status = "Wired";
            root.icon = "󰈀"; // Nerd Font Ethernet icon
        } else if (activeWifi) {
            // NetworkDevice has no "activeConnection" - find the connected
            // entry inside device.networks and read its name (SSID).
            let ssid = "Wi-Fi";
            for (let i = 0; i < activeWifi.networks.values.length; i++) {
                const net = activeWifi.networks.values[i];
                if (net.connected) {
                    ssid = net.name;
                    break;
                }
            }
            root.status = ssid;
            console.log(root.icon);
            root.icon = "\udb81\udda9"; // Nerd Font Wi-Fi icon
        } else {
            root.status = "Disconnected";
            root.icon = "󰤮"; // Nerd Font Wi-Fi disconnected icon
        }
    }

    // Run once immediately on startup
    Component.onCompleted: updateNetworkState()

    // A lightweight QML Timer replaces the heavy Process
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: root.updateNetworkState()
    }

}
