pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Hyprland


Singleton{
  id: root

  readonly property var workspaces: Hyprland.workspaces
  readonly property var monitors: Hyprland.monitors
  
  // Calls a hyprland dispatch
  function dispatch(request: string): void{ 
    Hyprland.dispatch(request);
  }

  // converts ShellScreen to equivilent HyprlandMonitor
  function screen2hmon(screen: ShellScreen): HyprlandMonitor { 
    return Hyprland.monitorFor(screen);
  }

  Connections {
    target: Hyprland 

    // Runs for every event through hyprland
    function onRawEvent(event: HyprlandEvent): void {
      const name = event.name;

      if(name.endsWith("v2")) return; // both v2 and v1 sent at same time :P

      if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(name)) {
        Hyprland.refreshWorkspaces();
        Hyprland.refreshMonitors();
      } else if (["openwindow", "closewindow", "movewindow"].includes(name)) {
        Hyprland.refreshToplevels();
        Hyprland.refreshWorkspaces();
      } else if (name.includes("mon")) {
        Hyprland.refreshMonitors();
      } else if (name.includes("workspace")) {
        Hyprland.refreshWorkspaces();
      } else if (name.includes("window") || name.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(name)) {
        Hyprland.refreshToplevels();
      }    
    }
  }
}
