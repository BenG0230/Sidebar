import Quickshell
import QtQuick

import Quickshell.Widgets
import QtQuick.Layouts

import qs.utils
import qs.components
import qs.config

ColumnLayout {
    spacing: -3

    StatusIcon {
        id: networkIcon
        text: Icons.getNetworkIcon(Network.ethernet, Network.active ? Network.active.strength : 0, Network.wifiStatus)
        Layout.rightMargin: -1 // WHY ARE THESE NEVER CENTERED D:<
    }

    // StatusIcon {
    //     id: batteryIcon
    //     text: Icons.getBatteryIcon(Battery.percentage, Battery.charging)
    //     font.pointSize: 14
    //     Layout.leftMargin: -1
    //     Layout.topMargin: 8
    //     Layout.bottomMargin: 0
    // }
    //
    // Text {
    //     text: Math.round(Battery.percentage * 100)
    //     Layout.alignment: Qt.AlignHCenter
    //     font.pointSize: 10
    //     font.bold: true
    //     font.family: "FiraCode Nerd Font Mono"
    //     color: Colours.text
    //     Layout.bottomMargin: 8
    // }

    component StatusIcon: Icon {
        font.pointSize: 20
        Layout.alignment: Qt.AlignHCenter
    }
}
