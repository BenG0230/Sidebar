pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick.Layouts

import qs.config
import qs.components

Item {
    id: root

    implicitHeight: icons.height
    Column {
        id: icons

        spacing: 7

        anchors.horizontalCenter: parent.horizontalCenter

        add: Transition {
            // animations for new items
            Anim {
                // "pop" in
                property: "scale"
                from: 0
                to: 1
                easing.bezierCurve: Anims.curves.standardDecel
            }
        }

        move: Transition {
            // animations for existing items
            Anim {
                // smooth movement
                properties: "x,y"
            }
        }

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {
                Layout.alignment: Qt.AlignCenter
                Layout.rightMargin: 1
            }
        }
    }

    Behavior on implicitHeight {
        // smooth vertical movement
        Anim {}
    }
}
