pragma Singleton

import Quickshell
import QtQuick 

import Quickshell.Io

Singleton { 
  id: root

  readonly property list<AccessPoint> networks: []
  readonly property AccessPoint active: networks.find(n => n.active) ?? null

  property bool ethernet: false
  property string wifiStatus: "disconnected"

  function updateNetwork(): void{ // Update all network values
    getNetworks.running = true;
    getConnectionType.getType();
  }

  Process { // Run anytime a new network event happens
    id: test 

    running: true 
    command: ["nmcli", "monitor"]
    stdout: SplitParser {
      onRead: root.updateNetwork();
    }
  }

  Process{ // Get the current connection type (Ethernet/Wifi)
    id: getConnectionType

    running: true 
    command: ["nmcli", "-t", "-f", "TYPE,STATE", "d", "status"]
    property string buffer // Buffer used to go through all devices at once 

    function getType() {
      buffer = "";
      getConnectionType.running = true;
    }
    
    stdout: SplitParser {
      onRead: data => {
        getConnectionType.buffer += data + "\n"; // add device info to buffer
      }
    }

    onExited: (exitCode, exitStatus) => { 
      const data = getConnectionType.buffer.split('\n');

      let ethernet = false;
      let wifiStatus = "disconnected";

      data.forEach(line => {
        if( line.includes("ethernet") && line.includes(":connected"))
          ethernet = true 
        else if (line.includes("wifi:")){
          if (line.includes(":connected"))
            wifiStatus = "connected"
          else if (line.includes(":unavailable"))
            wifiStatus = "unavailable"
          }
      })
      
      root.ethernet = ethernet 
      root.wifiStatus = wifiStatus
    }
  }


  Process { // Get network info for all nearby networks
    id: getNetworks

    running: true
    command: ["nmcli", "-g", "ACTIVE,SIGNAL,FREQ,SSID,BSSID,SECURITY", "d", "w"]
    environment: ({
      LANG: "C.UTF-8",
      LC_ALL: "C.UTF-8"
    })
    stdout: StdioCollector {
      onStreamFinished: {
        const PLACEHOLDER = "STRINGWHICHHOPEFULLYWONTBEUSED";
        const rep = new RegExp("\\\\:", "g");
        const rep2 = new RegExp(PLACEHOLDER, "g");

        const allNetworks = text.trim().split("\n").map(n => {
          const net = n.replace(rep, PLACEHOLDER).split(":");
          return {
            active: net[0] === "yes",
            strength: parseInt(net[1]),
            frequency: parseInt(net[2]),
            ssid: net[3]?.replace(rep2, ":") ?? "",
            bssid: net[4]?.replace(rep2, ":") ?? "",
            security: net[5] ?? ""
          };
        }).filter(n => n.ssid && n.ssid.length > 0);

        // Group networks by SSID and prioritize connected ones
        const networkMap = new Map();
        for (const network of allNetworks) {
          const existing = networkMap.get(network.ssid);
          if (!existing) {
            networkMap.set(network.ssid, network);
          } else {
            // Prioritize active/connected networks
            if (network.active && !existing.active) {
              networkMap.set(network.ssid, network);
            } else if (!network.active && !existing.active) {
              // If both are inactive, keep the one with better signal
              if (network.strength > existing.strength) {
                networkMap.set(network.ssid, network);
              }
            }
            // If existing is active and new is not, keep existing
          }
        }

        const networks = Array.from(networkMap.values());

        const rNetworks = root.networks;

        const destroyed = rNetworks.filter(rn => !networks.find(n => n.frequency === rn.frequency && n.ssid === rn.ssid && n.bssid === rn.bssid));
        for (const network of destroyed)
        rNetworks.splice(rNetworks.indexOf(network), 1).forEach(n => n.destroy());

        for (const network of networks) {
          const match = rNetworks.find(n => n.frequency === network.frequency && n.ssid === network.ssid && n.bssid === network.bssid);
          if (match) {
            match.lastIpcObject = network;
          } else {
            rNetworks.push(apComp.createObject(root, {
              lastIpcObject: network
            }));
          }
        }
      }
    }
  }

  component AccessPoint: QtObject {
    required property var lastIpcObject
    readonly property string ssid: lastIpcObject.ssid
    readonly property string bssid: lastIpcObject.bssid
    readonly property int strength: lastIpcObject.strength
    readonly property int frequency: lastIpcObject.frequency
    readonly property bool active: lastIpcObject.active
    readonly property string security: lastIpcObject.security
    readonly property bool isSecure: security.length > 0
  }

  Component {
      id: apComp

      AccessPoint {}
  }
}
