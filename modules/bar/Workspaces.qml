pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.config
import qs.utils
import qs.components

WrapperRectangle {
    id: root

    required property ShellScreen screen

    property HyprlandMonitor monitor: Hypr.screen2hmon(screen)

    property var monitorWs: Hypr.workspaces.values.filter(ws => ws.monitor == monitor && ws.id > 0)

    // style
    implicitWidth: 34
    radius: 25
    color: Colours.bg2
    topMargin: 10
    bottomMargin: 10
    rightMargin: 1

	Column {
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

        // move: Transition {
        //     // animations for existing items
        //     Anim {
        //         // smooth movement
        //         properties: "x,y"
        //     }
        // }

        Repeater {
			model: ScriptModel {
				values: root.monitorWs
			}
            Workspace {
                required property var modelData
                ws: modelData
                // Layout.alignment: Qt.AlignCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.topMargin: 5
                Layout.bottomMargin: 5
            }
        }
    }
}
