import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 8

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            width: 60
            height: 20
            color: modelData.focused ? Color.primary : Color.surface1
            radius: 3

            MouseArea {
                anchors.fill: parent
                onClicked: () => {
                    Hyprland.dispatch(`workspace ${modelData.id}`);
                }
            }

            Text {
                anchors.centerIn: parent
                text: modelData.name
            }

        }

    }

}
