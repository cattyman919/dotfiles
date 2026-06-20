import QtQuick

Rectangle {
    property string memoryIcon: "\uefc5"

    function formatMemory(usageInMB) : string {
        if (usageInMB >= 1000)
            return `${Math.round(usageInMB / 1000)} GB`;
        else
            return `${usageInMB} MB`;
    }

    implicitWidth: memoryUsageText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: Color.bgPanel

    Text {
        id: memoryUsageText

        anchors.centerIn: parent
        font.bold: true
        font.family: Settings.panelFontFamily
        color: Color.primary
        font.pixelSize: Settings.panelFontSize
        text: {
            return `${memoryIcon}  ${formatMemory(MemoryState.usageInMB)}`;
        }
    }

}
