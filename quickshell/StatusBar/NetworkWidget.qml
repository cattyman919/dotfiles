import QtQuick

Rectangle {
    implicitWidth: networkStatusText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: Color.bgPanel

    Text {
        id: networkStatusText

        anchors.centerIn: parent
        font.bold: true
        color: Color.primary
        font.pixelSize: Settings.panelFontSize
        font.family: Settings.panelFontFamily
        text: `${NetworkState.icon} ${NetworkState.status}`
    }

}
