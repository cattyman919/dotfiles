import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: root

    property int padding: 30
    property int spacing: 8

    // color: "transparent"
    implicitHeight: 30
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    // Left Side Widgets
    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.padding
        spacing: root.spacing

        WorkspacesWidget {
        }

        ActiveWindowWidget {
            Layout.alignment: Qt.AlignVCenter
            visible: Settings.showActiveWindowWidget
        }

    }

    // Right Side Widgets
    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.padding
        spacing: root.spacing

        NetworkWidget {
        }

        CPUWidget {
        }

        MemoryWidget {
        }

        BatteryWidget {
            visible: Settings.showBatteryWidget
        }

        ClockWidget {
        }

    }

}
