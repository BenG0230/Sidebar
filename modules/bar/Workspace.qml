pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.config
import qs.utils
import qs.components

Rectangle {
    id: root

    required property HyprlandWorkspace ws // workspace information
    property var windows: ws.toplevels.values // windows in workspace
    property bool occupied: windows.length != 0

    // style
    radius: 25

    implicitWidth: occupied || ws.focused ? 23 : 10
    implicitHeight: occupied ? layout.height : 10
    color: ws.focused ? Colours.hl3 : occupied ? Colours.hl1 : Colours.text

    MouseArea {
        anchors.fill: parent
        onPressed: Hypr.dispatch('workspace %1'.arg(root.ws.id))
    }

    Column {
        id: layout

        // center in pill
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

        spacing: -10  // text item is really tall D:

        rightPadding: 1 // moves icons into the center

        Repeater {
            model: ScriptModel {
                values: root.windows
            }

            Icon // window icons
             {
                required property var modelData
                color: root.ws.focused ? Colours.dtext : Colours.text // darken text when focused

                text: Icons.getAppIcon(modelData.lastIpcObject.class)

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Anims.curves.standardAccel
                    }
                }
            }
        }
    }

    Behavior on implicitHeight {
        // smooth vertical movement
        Anim {}
    }

    Behavior on implicitWidth {
        // smooth horizontal movement
        Anim {}
    }

    Behavior on color {
        ColorAnimation {
            duration: 250
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Anims.curves.standardAccel
        }
    }
}
