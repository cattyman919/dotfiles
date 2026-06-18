import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

RowLayout {
    spacing: 8

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            width: 60
            height: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
            color: modelData.focused ? Color.primary : Color.surface1
            radius: 3

            Process {
                // console.log(modelData.toplevels.values);

                id: topLevelProcess

                command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: () => {
                    }
                }

            }

            MouseArea {
                anchors.fill: parent
                onClicked: () => {
                    modelData.activate();
                }
            }

            Text {
                font.bold: true
                anchors.centerIn: parent
                text: modelData.name
            }

        }

    }

}
