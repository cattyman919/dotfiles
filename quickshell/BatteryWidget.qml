import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    width: 60
    height: 20

    Rectangle {
        anchors.fill: parent
        radius: 4
        color: BatteryState.percentage < 20 ? Color.danger : Color.bgPanel

        Text {
            anchors.centerIn: parent
            font.bold: true
            color: Color.primary
            text: `${BatteryState.percentage}%`
        }

    }

}
