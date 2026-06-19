import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    // Widgets Settings
    property bool showActiveWindowWidget: true
    property int cpuPercentageInterval: 1000
    // Widget Panel Style
    property int panelFontSize: 14
    property int panelWidgetHeight: 20
    property int panelWidgetTopBottomPadding: 4
    property int panelWidgetRightLeftPadding: 20
    property int panelBorderRadius: 4
}
