import Quickshell
import QtQuick

import qs.components

import Quickshell.Widgets

MouseArea {
    id: root

    implicitWidth: 40
    implicitHeight: powerIcon.height
    Icon {
        id: powerIcon
        anchors.horizontalCenter: parent.horizontalCenter
        text: "⏻"
        font.pointSize: 25
    }
}
