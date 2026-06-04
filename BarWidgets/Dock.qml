// Dock.qml
import QtQuick
import QtQuick.Layouts
import "../Theme"
import "../Singletons"

RowLayout {
    id: dockLayout
    spacing: 0
    width: Theme.dockWidth
    implicitHeight: Theme.height
    Rectangle {
        color: "transparent"
        TapHandler {
            onTapped: {
                SideHandler.panelOpen = !SideHandler.panelOpen
            }
        }
        implicitHeight: Theme.height
        Layout.preferredWidth: 30
        Layout.fillHeight: true

        ThemedText {
            anchors.centerIn: parent
            text: SideHandler.panelOpen ? "" : ""
        }
    }

    Rectangle {
        color: "transparent"
        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 100

        ThemedText {
            id: trackName
            anchors.centerIn: parent
            text: Music.selectedPlayer?.trackTitle ? Music.selectedPlayer.trackTitle : Splash.text

            elide: Text.ElideRight

            width: Math.min(parent.width, Theme.dockWidth*10/12)

            horizontalAlignment: Text.AlignHCenter
        }
    }

    RAMWidget {}
    CPUWidget {}
}
