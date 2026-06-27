import QtQuick
import QtQuick.Layouts
import "../Theme"
import "../Singletons"

RowLayout {
    id: dockLayout
    spacing: 0
    width: Theme.dockWidth
    implicitHeight: Theme.height
    Item {
        Layout.preferredWidth: 30
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

            width: Math.min(parent.width, Theme.dockWidth * 10 / 12)

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    RAMWidget {}
    CPUWidget {}
}
