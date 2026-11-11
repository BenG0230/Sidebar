pragma Singleton

import Quickshell
import QtQuick

import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property real percentage: UPower.displayDevice?.percentage ?? 1
    readonly property var state: UPower.displayDevice.state
    readonly property bool charging: state == UPowerDeviceState.Charging

    property bool isFull: percentage >= 0.99
    property bool isLow: percentage < 0.2 && percentage != 0
    property bool isCritical: percentage < 0.1 && percentage != 0

    onIsFullChanged: {
        if (!isFull)
            return;
        Quickshell.execDetached(["notify-send", "Battery Full", String(percentage * 100) + "%"]);
    }

    onIsLowChanged: {
        if (!isLow)
            return;
        Quickshell.execDetached(["notify-send", "Battery Low", String(percentage * 100) + "%", "-u", "critical"]);
    }

    onIsCriticalChanged: {
        if (!isCritical)
            return;
        Quickshell.execDetached(["notify-send", "Battery Critical", String(percentage * 100) + "%", "-u", "critical"]);
    }

    onChargingChanged: {
        if (!charging)
            Quickshell.execDetached(["notify-send", "Charging Disconnected", String(percentage * 100) + "%"]);
        else
            Quickshell.execDetached(["notify-send", "Charging Connected", String(percentage * 100) + "%"]);
    }
}
