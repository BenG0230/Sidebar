import Quickshell
import QtQuick

import qs.config

Item {
    id: root

    required property ShellScreen screen

    height: screen.height

    implicitWidth: background.width + 10

    Rectangle {
        id: background

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        width: 40

        anchors.leftMargin: 5
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        color: Colours.bg1
        radius: 17
        border.width: 3
        border.pixelAligned: true
        border.color: Colours.hl2
    }

    Bar {
        id: bar

        screen: root.screen
    }
}
