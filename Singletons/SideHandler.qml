// SideHandler.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    
    property alias panelOpen: persist.panelOpen

    PersistentProperties {
        id: persist
        property bool panelOpen: false
    }

    IpcHandler {
        target: "sidePanel"

        function togglePanel(): void {
            root.panelOpen = !root.panelOpen
        }
    }
}
