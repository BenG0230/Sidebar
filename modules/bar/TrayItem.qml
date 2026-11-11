import QtQuick
import Quickshell

import Quickshell.Services.SystemTray
import Quickshell.Widgets

import qs.config
import qs.utils

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 18
    implicitHeight: 18

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            modelData.activate();
        } else {
            modelData.secondaryActivate();
        }
    }

    IconImage {
        id: icon

        asynchronous: true
        anchors.fill: parent

        source: Icons.getTrayIcon(root.modelData.icon)
    }
}
