import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Scope {
    Variants {
        id: root

        property int padding: 30
        property int spacing: 8

        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            // color: "transparent"
            screen: modelData
            implicitHeight: 30

            anchors {
                top: true
                left: true
                right: true
            }

            // Left Side Widgets
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: root.padding
                spacing: root.spacing

                WorkspacesWidget {
                }

                ActiveWindowWidget {
                    visible: Settings.showActiveWindowWidget
                }

            }

            // Right Side Widgets
            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: root.padding
                spacing: root.spacing

                CPUWidget {
                }

                BatteryWidget {
                }

                ClockWidget {
                }

            }

        }

    }

}
