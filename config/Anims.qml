pragma Singleton 

import Quickshell
import Quickshell.Io

Singleton {
  id: root 

  readonly property Curves curves: Curves{}

  component Curves: JsonObject {
    property list<real> standard: [0.2,0,0,1,1,1] 
    property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
    property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
  }
}
