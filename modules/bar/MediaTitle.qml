pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets

import qs.config
import qs.utils
import qs.components

Item {
    id: root

    required property var bar

    readonly property var players: Media.playingPlayers

    property Title current: text1

    // clip: true
    implicitWidth: Math.max(icon.implicitWidth, current.implicitHeight)
    implicitHeight: icon.implicitHeight + current.implicitWidth

    readonly property var maxHeight: {
        const modules = bar.children.filter(c => c.item !== this);
        const moduleHeights = modules.reduce((acc, curr) => acc + curr.height, 0);

        return bar.height - moduleHeights - (17 * modules.length);
    }

    Icon {
        id: icon

        // anchors.centerIn:parent
        anchors.bottom: root.current.top
        anchors.horizontalCenter: root.current.horizontalCenter

        text: Icons.getAppIcon(root.players[0].desktopEntry)
    }

    TextMetrics {
        id: textM

        text: root.players[0].trackTitle

        font.bold: true
        font.pointSize: 10.5
        font.family: "FiraCode Nerd Font Mono"

        elide: Qt.ElideRight
        elideWidth: root.maxHeight - icon.height - 10

        onTextChanged: {
            const next = root.current === text1 ? text2 : text1;
            next.text = elidedText;
            root.current = next;
        }

        onElideWidthChanged: root.current.text = elidedText
    }

    Title {
        id: text1
    }

    Title {
        id: text2
    }

    component Title: Text {
        id: text

        anchors.centerIn: parent

        font.bold: textM.font.bold
        font.pointSize: textM.font.pointSize
        font.family: textM.font.family
        color: Colours.text

        renderType: Text.NativeRendering

        opacity: root.current === this ? 1 : 0

        transform: Rotation {
            angle: -90
            origin.x: text.implicitWidth / 2
            origin.y: text.implicitWidth / 2
        }

        width: implicitHeight
        height: implicitWidth

        Behavior on opacity {
            Anim {}
        }
    }

    Behavior on implicitHeight {
        Anim {
            duration: 500
            easing.bezierCurve: Anims.curves.expressiveDefaultSpatial
        }
    }
}
