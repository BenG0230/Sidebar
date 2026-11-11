pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs.utils

import QtQuick.Layouts

ColumnLayout {
    id: root

    required property ShellScreen screen

    anchors.fill: parent.children[0]
    spacing: 7

    Clock {
        id: clock
        Layout.topMargin: 15
        Layout.alignment: Qt.AlignHCenter
    }



    Workspaces {
        id: workspaces
        screen: root.screen
        Layout.alignment: Qt.AlignHCenter
        Layout.rightMargin: 1
    }

    Loader {
        id: mediaLoader
        active: Media.playingPlayers.length > 0

        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: true

        sourceComponent: MediaTitle {
            id: media
            bar: root
        }
    }

    LowerIcons {
        id: lowericons

        Layout.alignment: Qt.AlignHCenter
        Layout.rightMargin: 1
        Layout.bottomMargin: 3
    }

    // Powermenu {
    //     id: powermenu
    //
    //     Layout.alignment: Qt.AlignHCenter
    //     Layout.leftMargin: 1
    //     Layout.bottomMargin: 10
    // }

    component BarItem: Loader {
        required property string id

        Layout.alignment: Qt.AlignHCenter

        active: true
    }
}
