import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
pragma Singleton

Singleton {
    id: root

    property string percentage: "Loading..."
    property string status: "Loading..."

    Process {
        id: batteryProcess

        command: ["cat", "/sys/class/power_supply/BAT0/capacity", ";", "cat", "/sys/class/power_supply/BAT0/status"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => {
                const words = this.text.trim().split(/\s+/);
                root.percentage = words[0];
                root.status = words[1];
            }
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: batteryProcess.running = true
    }

}
