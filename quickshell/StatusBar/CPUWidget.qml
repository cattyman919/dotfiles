import QtQuick

Rectangle {
    property string cpuIcon: "\uf4bc"

    implicitWidth: cpuPercentageText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: CPUState.percentage >= 80 ? Color.danger : Color.bgPanel

    Text {
        id: cpuPercentageText

        anchors.centerIn: parent
        font.bold: true
        color: Color.primary
        font.pixelSize: Settings.panelFontSize
        text: {
            return `${cpuIcon}  ${CPUState.percentage}%`;
        }
    }

}
