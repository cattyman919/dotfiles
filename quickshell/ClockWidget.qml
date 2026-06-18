// ClockWidget.qml
import QtQuick

Rectangle {
    width: clockText.implicitWidth + 20
    height: 20
    radius: 4
    color: Color.bgPanel

    Text {
        id: clockText

        font.bold: true
        color: Color.primary
        anchors.centerIn: parent
        text: ClockState.time
    }

}
