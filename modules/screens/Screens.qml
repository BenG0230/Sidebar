import Quickshell

import qs.modules.bar

import Quickshell.Wayland

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property var modelData

        PanelWindow { // sets exclusiveZone for the bar
            id: barExc

            anchors.left: true
            exclusiveZone: bar.width

            screen: scope.modelData

            implicitWidth: 1
            implicitHeight: 1
        }

        PanelWindow { // actual drawing screen
            id: win

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            color: "transparent"

            mask: Region {
                item: bar.children[0]
            }

            implicitWidth: bar.implicitWidth

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            screen: scope.modelData

            BarWrapper {
                id: bar
                screen: scope.modelData
            }
        }
    }
}
