import QtQuick
import Quickshell

Rectangle {
    id: networkPanel

    implicitWidth: networkStatusText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: Color.bgPanel

    MouseArea {
        id: hoverArea

        anchors.fill: parent
        hoverEnabled: true
    }

    Text {
        id: networkStatusText

        anchors.centerIn: parent
        font.bold: true
        color: Color.primary
        font.pixelSize: Settings.panelFontSize
        font.family: Settings.panelFontFamily
        text: `${NetworkState.icon} ${NetworkState.status}`
    }

    // Popup
    Rectangle {
        id: popup

        property real offsetScale: hoverArea.containsMouse ? 0 : 1

        implicitWidth: 500
        implicitHeight: 500
        radius: 12
        color: "#2a2a2a"
        visible: offsetScale < 1
        opacity: 1 - offsetScale

        anchors {
            // hidden(1): margin = -(heigth + 10) -> above panel, invisible
            // visible(0): margin = 0 -> below panel

            top: networkPanel.bottom
            left: networkPanel.left
            topMargin: (-implicitHeight - 10) * offsetScale
        }

        Text {
            anchors.centerIn: parent
            color: "white"
            text: "Network Details"
        }

        Behavior on offsetScale {
            NumberAnimation {
                duration: 350
                easing.type: Easing.OutCubic
            }

        }

    }

}
