import Quickshell
import QtQuick

import Quickshell.Widgets
import QtQuick.Layouts

import qs.config

WrapperRectangle {
    id: root

    implicitWidth: 34
    radius: 25
    color: Colours.bg2

    topMargin: 10
    rightMargin: 1

    ColumnLayout {
        id: layout

        spacing: 10

        Tray {
            id: systray

            Layout.alignment: Qt.AlignHCenter
        }

        WrapperRectangle {
            implicitWidth: root.width
            radius: root.radius
            color: Colours.bg3

            Status {
                id: statusicons
            }
        }
    }
}
