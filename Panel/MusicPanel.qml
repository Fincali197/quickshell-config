// MusicPanel.qml

import "../Theme"
import "../Singletons"
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Quickshell.Widgets
import Quickshell.Services.Mpris

ColumnLayout {
    id: root

    spacing: 0

	function formatTime(seconds) {
		var mins = Math.floor(seconds / 60);
		var secs = seconds % 60;

		return Math.floor(mins).toString().padStart(2, '0') + ":" +
			   Math.floor(secs).toString().padStart(2, '0');
	}

    RowLayout {
        spacing: 0

        Rectangle {
            id: musicIconContainer

            property int imagePadding: Theme.dockWidth/12

            implicitHeight: trackIcon.paintedHeight + imagePadding
            implicitWidth: Theme.dockWidth/2

            visible: Music.getArtUrl(Music.selectedPlayer)

            color: "transparent"

			ClippingRectangle {
				id: iconTrimmer
				width: trackIcon.paintedWidth
				height: trackIcon.paintedHeight
				radius: Theme.borderRadius
				clip: true
				color: "transparent"
				anchors.centerIn: parent
				Image {
					id: trackIcon
					fillMode: Image.PreserveAspectFit
					anchors.centerIn: parent
					width: Math.round(Theme.dockWidth/2 - 2 * musicIconContainer.imagePadding)
					height: Math.round(Theme.dockWidth/2 - 2 * musicIconContainer.imagePadding)
					source: Music.getArtUrl(Music.selectedPlayer)
				}
			}
        }

        ColumnLayout {
            spacing: 0
            Layout.minimumHeight: Theme.dockWidth/4

            // Player selector
            Rectangle {
                Layout.preferredHeight: playerPicker.implicitHeight + Theme.dockWidth/20
                Layout.fillWidth: true
				color: "transparent"
				ComboBox {
					id: playerPicker
					anchors.centerIn: parent
					model: Music.players.values
					textRole: "identity"
					delegate: ItemDelegate {
						contentItem: ThemedText {
							text: modelData.identity
						}
					}
					background: ThemedRectangle {
						color: Theme.secondaryBackgroundColor
						implicitWidth: Theme.dockWidth*2/5
						implicitHeight: Theme.fontSize*2.5
						border.width: 0
					}
					contentItem: ThemedText {
						text: playerPicker.displayText
						elide: Text.ElideRight
						leftPadding: Theme.textPadding/2
						rightPadding: Theme.textPadding/2
						verticalAlignment: Text.AlignVCenter
					}
					indicator: ThemedText {
						text: ""
						anchors {
							right: parent.right
							rightMargin: Theme.textPadding/2
							verticalCenter: parent.verticalCenter
						}
						verticalAlignment: Text.AlignVCenter
					}
			   	}
            }

            // Player volume slider
            Rectangle {
                Layout.preferredHeight: playerVolume.implicitHeight
                Layout.fillWidth: true
                color: "transparent"


				ThemedText {
					text: playerVolume.value > 0 ? (playerVolume.value > 0.5 ? "" : "") : ""
					anchors.right: playerVolume.left
					anchors.rightMargin: Theme.textPadding/2
					anchors.verticalCenter: parent.verticalCenter
				}
                ThemedSlider {
                    id: playerVolume
                    anchors.centerIn: parent

                    value: Math.cbrt(Music.selectedPlayer.volume)
					from: 0.0
					to: 1.0

                    sliderWidth: Theme.dockWidth/4

                    onMoved: {Music.selectedPlayer.volume = value*value*value}
                }
				ThemedText {
					text: Math.floor(playerVolume.value*100) + "%"
					anchors.left: playerVolume.right
					anchors.leftMargin: Theme.textPadding/2
					anchors.verticalCenter: parent.verticalCenter
				}
            }

            // Player controls
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
				implicitHeight: playerPause.implicitHeight

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
					TapHandler {
						onTapped: Music.playPause(Music.selectedPlayer)
					}
                }
                Rectangle {
                    id: playerNext

                    anchors.left: playerPause.right
                    anchors.verticalCenter: parent.verticalCenter

                    implicitWidth: playerNextIcon.implicitWidth
                    implicitHeight: playerNextIcon.implicitHeight

                    color: "transparent"

                    ThemedText {
                        id: playerNextIcon
                        text: "󰒭"
                        font.pointSize: Theme.dockWidth/10
                    }

					TapHandler {
						onTapped: Music.next(Music.selectedPlayer)
					}
                }
                Rectangle {
                    id: playerPrevious

                    anchors.right: playerPause.left
                    anchors.verticalCenter: parent.verticalCenter

                    implicitWidth: playerPreviousIcon.implicitWidth
                    implicitHeight: playerPreviousIcon.implicitHeight

                    color: "transparent"

                    ThemedText {
                        id: playerPreviousIcon
                        text: "󰒮"
                        font.pointSize: Theme.dockWidth/10
                    }

					TapHandler {
						onTapped: Music.previous(Music.selectedPlayer)
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

    RowLayout {
        Layout.preferredHeight: Theme.dockWidth/50 * 3
        Layout.preferredWidth: Theme.dockWidth

		Item { Layout.preferredWidth: Theme.textPadding }

		ThemedText {
			id: positionText
			text: root.formatTime(Music.selectedPlayer.position)
			Layout.preferredWidth: font.pointSize * 3.5
		}

        ThemedSlider {
			Layout.fillWidth: true
			Layout.fillHeight: true
            from: 0
            to: Music.selectedPlayer.length
            value: Music.selectedPlayer.position
            sliderWidth: Theme.dockWidth - 40
			onMoved: Music.setPosition(Music.selectedPlayer, value)
			roundedHandle: true
        }
		Timer {
		  running: Music.selectedPlayer.playbackState == MprisPlaybackState.Playing
		  interval: 1000
		  repeat: true
		  onTriggered: Music.selectedPlayer.positionChanged()
		}

		ThemedText {
			text: root.formatTime(Music.selectedPlayer.length)
		}

		Item { Layout.preferredWidth: Theme.textPadding }
    }
}
