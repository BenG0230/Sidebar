pragma ComponentBehavior: Bound

import QtQuick

import qs.utils
import qs.config

Text {
    id: text

    renderType: Text.NativeRendering

    font.pointSize: 14
    font.family: "FiraCode Nerd Font Mono"
    font.bold: true
    color: Colours.text

    text: Time.format("hh\nmm")
}
