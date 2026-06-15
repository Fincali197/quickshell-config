// SidePanel.qml
import "../Theme"
import "../Singletons"
import QtQuick
import Quickshell

PanelWindow {
    id: root

    anchors {
        bottom: true
        left: true
        top: true
    }

    exclusionMode: ExclusionMode.Ignore
    implicitWidth: Theme.dockWidth
    color: "transparent"          // Invisible where mainContainer isn't active

    // This property tells the compositor to only capture clicks inside mainContainer
    mask: Region {
        x: mainContainer.x
        y: mainContainer.y
        width: mainContainer.width
        height: mainContainer.height
    }


    ThemedRectangle {
        id: mainContainer

        implicitHeight: panelLoader.item.implicitHeight

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: Theme.bottomMargin
        }
        
        Loader {
            id: panelLoader
            source: SideHandler.panelOpen ? "PanelContent.qml" : "../BarWidgets/Dock.qml"
        }
    }

    Rectangle {
        color: "transparent"
        TapHandler {
            onTapped: {
                SideHandler.panelOpen = !SideHandler.panelOpen
            }
        }
        implicitHeight: Theme.height
        implicitWidth: Theme.height
		anchors.left: mainContainer.left
		anchors.bottom: mainContainer.bottom

        ThemedText {
            anchors.centerIn: parent
            text: SideHandler.panelOpen ? "" : ""
        }
    }
}
