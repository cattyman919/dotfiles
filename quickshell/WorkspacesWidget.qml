import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

RowLayout {
    spacing: 8

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            id: workspaceItem

            required property var modelData
            // Reactive: re-evaluates whenever this workspace's toplevel list changes
            readonly property var firstToplevel: modelData.toplevels.values.length > 0 ? modelData.toplevels.values[0] : null
            readonly property string appId: firstToplevel && firstToplevel.wayland ? firstToplevel.wayland.appId : ""
            readonly property string iconPath: {
                if (appId === "")
                    return "";

                const entry = DesktopEntries.heuristicLookup(appId);
                if (!entry || !entry.icon)
                    return "";

                return Quickshell.iconPath(entry.icon, true);
            }

            width: 45
            height: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
            color: modelData.focused ? Color.primary : Color.surface1
            radius: 3

            MouseArea {
                anchors.fill: parent
                onClicked: modelData.activate()
            }

            IconImage {
                id: iconImage

                implicitWidth: 24
                implicitHeight: 24
                anchors.centerIn: parent
                source: workspaceItem.iconPath
                visible: workspaceItem.iconPath !== ""
            }

            Text {
                id: iconText

                font.bold: true
                anchors.centerIn: parent
                text: modelData.name
                visible: workspaceItem.iconPath === ""
            }

        }

    }

}
