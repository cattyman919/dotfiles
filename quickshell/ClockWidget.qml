// ClockWidget.qml
import QtQuick

Rectangle {
    implicitWidth: clockText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: Color.bgPanel

    Text {
        id: clockText

        font.bold: true
        color: Color.primary
        anchors.centerIn: parent
        font.pixelSize: Settings.panelFontSize
        text: `\uf073  ${ClockState.time}`
    }

}
