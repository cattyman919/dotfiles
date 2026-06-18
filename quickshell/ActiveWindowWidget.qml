import QtQuick
import Quickshell.Io
import Quickshell.Wayland

Rectangle {
    width: textActiveWindow.implicitWidth + 20
    height: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    anchors.verticalCenter: parent.verticalCenter
    color: modelData.focused ? Color.primary : Color.surface1
    radius: Settings.panelBorderRadius

    Text {
        id: textActiveWindow

        anchors.centerIn: parent
        color: Color.primary
        font.bold: true
        text: ToplevelManager.activeToplevel ? ToplevelManager.activeToplevel.title : "Window"
    }

}
