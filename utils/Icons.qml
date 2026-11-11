pragma Singleton 

import Quickshell
import QtQuick

// Many bits taken from "https://github.com/caelestia-dots/shell" and "https://github.com/end-4/dots-hyprland"
// Thank you :3

Singleton{
  readonly property var appIcons: ({ // Special icons for special apps
    firefox: "󰈹",
    vesktop: "",
    steam: "",
    spotify: "󰓇",
  })

  readonly property var categoryIcons: ({ // generic icons for generic apps
    WebBrowser: "󰖟",
    Development: "",
    IDE: "",
    TextEditor: "",
    Audio: "",
    Music: "",
    Player: "",
    FileTools: "",
    FileManager: "",
    Filesystem: "",
    FileTransfer: "",
    Settings: "",
    DesktopSettings: "",
    HardwareSettings: "",
    TerminalEmulator: "",
    Chat: "",
    InstantMessaging: "",
    Game: "󰊴",
    Office: "󰎞"
  })

  function getAppIcon(name: string): string{ // Get app icons for special apps (see appIcons)
    const appName = DesktopEntries.heuristicLookup(name)?.name; 


    if (appName){
      for (const [key, value] of Object.entries(appIcons)){
        if( appName.toLowerCase() == key ){
          return value;
        }
      }
    }

    return getAppCategoryIcon(name);
  }

  function getAppCategoryIcon(name: string): string { // Get app icon based off desktop entry categories
    const categories = DesktopEntries.heuristicLookup(name)?.categories;

    if (categories){
      for (const [key, value] of Object.entries(categoryIcons)){
        if (categories.includes(key)){
          return value;
        }
      }
    }
    return "";
  }

  function getNetworkIcon(ethernet: bool, strength: int, wifiStatus: string): string{ // Get Network Icon 
    if (ethernet){
      return "󰌗"; 
    }

    if (wifiStatus == "connected"){
      if (strength >= 80){
        return "󰤨";
      }
      if (strength >= 60){
        return "󰤥";
      }
      if (strength >= 40){
        return "󰤢";
      }
      if (strength >= 20){
        return "󰤟";
      }
      return "󰤯";
    }
    else if (wifiStatus == "unavailable"){
      return "󰀝"; 
    }
    else{ 
      return "󰤮" 
    }
  }

  function getBatteryIcon(percentage: real, charging: bool): string {
    if(charging){
      return "󰂄"
    } else {
      if(percentage >= 0.9){
        return "󰁹"
      }
      if(percentage >= 0.8){
        return "󰂂"
      }
      if(percentage >= 0.7){
        return "󰂁"
      }
      if(percentage >= 0.6){
        return "󰂀"
      }
      if(percentage >= 0.5){
        return "󰁿"
      }
      if(percentage >= 0.4){
        return "󰁾"
      }
      if(percentage >= 0.3){
        return "󰁽"
      }
      if(percentage >= 0.2){
        return "󰁼"
      }
      if(percentage >= 0.1){
        return "󰁻"
      }
      return "󰂎"
    }

  }

  function getTrayIcon(icon: string): string { // Get correct system tray icon path
    if (icon.includes("?path=")) {
      const [name, path] = icon.split("?path=");
      icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
    }
    return icon;
  }
}
