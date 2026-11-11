pragma Singleton 

import QtQuick
import Quickshell

import Quickshell.Services.Mpris

Singleton{
  readonly property var players: Mpris.players.values
  readonly property var playingPlayers: players.filter(p => p.isPlaying)
}
