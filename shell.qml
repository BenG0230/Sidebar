//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell // for PanelWindow
import QtQuick // for Texta

import "modules/bar"
import "modules/screens"

ShellRoot {
    id: root

    Screens {}
}
