import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
pragma Singleton

Singleton {
    id: root

    property string usageInMB: "Loading..."

    Process {
        id: memoryUsageProcess

        command: ["sh", "-c", "free -m | awk '/Mem:/ {print $2 - $7}'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const memoryUsage = this.text.trim();
                root.usageInMB = memoryUsage;
            }
        }

    }

    Timer {
        interval: Settings.memoryUsageInterval
        running: true
        repeat: true
        onTriggered: memoryUsageProcess.running = true
    }

}
