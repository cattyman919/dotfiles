import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string percentage: "Loading..."

    Process {
        id: batteryProcess

        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => {
                root.percentage = this.text.trim();
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
