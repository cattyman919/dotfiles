//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DefaultEnv QS_DROP_EXPENSIVE_FONTS=1
//@ pragma DefaultEnv QSG_RENDER_LOOP=threaded
//@ pragma DefaultEnv QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "StatusBar"

Scope {
    Variants {
        id: root

        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Top
            anchors.top: true
            anchors.left: true
            anchors.right: true
            anchors.bottom: true

            StatusBar {
                id: statusBar
            }

            // Give window empty click mask so all clicks pass through it
            mask: Region {
                Region {
                    item: statusBar
                }

            }

        }

    }

}
