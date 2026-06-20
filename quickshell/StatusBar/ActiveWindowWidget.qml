import QtQuick
import Quickshell.Io
import Quickshell.Wayland

Rectangle {
    implicitWidth: textActiveWindow.implicitWidth + 20
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
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
