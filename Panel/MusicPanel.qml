// MusicPanel.qml

import "../Theme"
import "../Singletons"
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
// import Quickshell.Services.Mpris

ColumnLayout {
    id: root

    spacing: 0

    RowLayout {
        spacing: 0

        Rectangle {
            id: musicIconContainer

            implicitHeight: Theme.dockWidth/2
            implicitWidth: Theme.dockWidth/2

            visible: Music.getArtUrl(Music.selectedPlayer)

            color: "transparent"

            property int imagePadding: Theme.dockWidth/12

            Image {
                id: trackIcon
                mipmap: true
                fillMode: Image.PreserveAspectFit
                width: Math.round(Theme.dockWidth/2 - 2 * musicIconContainer.imagePadding)
                height: Math.round(Theme.dockWidth/2 - 2 * musicIconContainer.imagePadding)
                anchors.centerIn: parent
                source: (Music.getArtUrl(Music.selectedPlayer) != "") ? Music.selectedPlayer.trackArtUrl : "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%2Fid%2FOIP.7lun1vSa8eQq62seye6SaQHaIZ%3Fpid%3DApi&f=1&ipt=050842dd82a42c3defd1db8f4e63214b56f4c91ee32a70129ac267c08bef0fc9&ipo=images"
            }
        }

        ColumnLayout {
            spacing: 0
            Layout.minimumHeight: Theme.dockWidth/4

            // Player selector
            Rectangle {
                Layout.preferredHeight: playerPicker.implicitHeight
                Layout.fillWidth: true
                ComboBox {
                    id: playerPicker
                    model: Music.players.values
                    textRole: "desktopEntry"
                }
            }

            // Player volume slider
            Rectangle {
                Layout.preferredHeight: playerVolume.implicitHeight
                Layout.fillWidth: true
                color: "transparent"


                ThemedSlider {
                    id: playerVolume
                    anchors.centerIn: parent

                    value: Music.selectedPlayer.volume

                    sliderWidth: Theme.dockWidth/3

                    onMoved: {Music.selectedPlayer.volume = value}
                }
            }

            // Player controls
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Rectangle {
                    id: playerPause

                    anchors.centerIn: parent

                    implicitWidth: playerPauseIcon.implicitWidth
                    implicitHeight: playerPauseIcon.implicitHeight

                    color: "transparent"

                    ThemedText {
                        id: playerPauseIcon
                        // text: !(Music.selectedPlayer?.isPlaying) ? "" : ""
                        text: Music.selectedPlayer?.isPlaying ? "" : ""
                        font.pointSize: Theme.dockWidth/10
                    }
                }
                Rectangle {
                    id: playerNext

                    anchors.left: playerPause.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.dockWidth/50

                    implicitWidth: playerNextIcon.implicitWidth
                    implicitHeight: playerNextIcon.implicitHeight

                    color: "transparent"

                    ThemedText {
                        id: playerNextIcon
                        text: "󰒭"
                        font.pointSize: Theme.dockWidth/10
                    }
                }
                Rectangle {
                    id: playerPrevious

                    anchors.right: playerPause.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Theme.dockWidth/50

                    implicitWidth: playerPreviousIcon.implicitWidth
                    implicitHeight: playerPreviousIcon.implicitHeight

                    color: "transparent"

                    ThemedText {
                        id: playerPreviousIcon
                        text: "󰒮"
                        font.pointSize: Theme.dockWidth/10
                    }
                }
            }
        }
    }

    Rectangle {
        ThemedText {
            id: trackName
            anchors.centerIn: parent
            font.pointSize: Theme.dockWidth/30
            text: Music.selectedPlayer?.trackTitle ? Music.selectedPlayer.trackTitle : "bruh"

            elide: Text.ElideRight

            width: Math.min(parent.width, Theme.dockWidth*10/12)

            horizontalAlignment: Text.AlignHCenter
        }
        color: "transparent"
        Layout.preferredHeight: trackName.implicitHeight
        Layout.fillWidth: true
    }
    Rectangle {
        ThemedSlider {
            anchors.centerIn: parent
            from: 0
            to: Music.selectedPlayer.length
            value: Music.selectedPlayer.position
            sliderWidth: Theme.dockWidth - 40
        }
        color: "transparent"
        Layout.preferredHeight: Theme.height
        Layout.fillWidth: true
    }
}
