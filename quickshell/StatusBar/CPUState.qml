import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
pragma Singleton

Singleton {
    id: root

    property string percentage: "Loading..."

    Process {
        id: cpuPercentageProcess

        command: ["sh", "-c", `top -bn1 | grep "Cpu(s)" | awk '{ printf "%0.f", 100 - $8}'`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const cpuPercentage = this.text.trim();
                root.percentage = cpuPercentage;
            }
        }

    }

    Timer {
        interval: Settings.cpuPercentageInterval
        running: true
        repeat: true
        onTriggered: cpuPercentageProcess.running = true
    }

}
