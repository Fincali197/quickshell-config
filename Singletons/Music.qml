// Music.qml
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    property var players: Mpris.players

    property MprisPlayer selectedPlayer: props.manualPlayer ?? players?.values[0] ?? null

    property alias manualPlayer: props.manualPlayer

    property bool playerExists: players?.values.length == 0 ? false : true

	function key(playerName: string, trackTitle: string): string {
		const playerNameConst = playerName
		const trackTitleConst = trackTitle
		return playerNameConst + "|" + trackTitleConst
	}
	
    PersistentProperties {
        id: props
		reloadableId: "musicCache"

        property MprisPlayer manualPlayer
		property var trackArtUrlList
		property var lengthList

		onLoaded: {
			if (trackArtUrlList == null) {
				trackArtUrlList = ({})
			}
			if (lengthList == null) {
				lengthList = ({})
			}
			// console.log(JSON.stringify(trackArtUrlList))
		}

    }
	property alias trackArtUrlList: props.trackArtUrlList
	property alias lengthList: props.lengthList

    function getArtUrl(player: MprisPlayer): string {
        if (!player)
            return "";

		if (root.trackArtUrlList) {
			if (root.trackArtUrlList[root.key(player.dbusName, player.trackTitle)]) {
				return root.trackArtUrlList[root.key(player.dbusName, player.trackTitle)]
			}
		}

        const url = player.metadata["xesam:url"] ?? "";
        if (
            url.startsWith("https://www.youtube.com/watch") ||
            url.startsWith("https://music.youtube.com/watch")
        ) {
            const id = url.match(/[?&]v=([\w-]{11})/)?.[1];
            return id ? `https://img.youtube.com/vi/${id}/hqdefault.jpg` : "";
        }

        return "";
    }

	function setPosition(player: MprisPlayer, position: real) {
		if (player.positionSupported) {
			player.position = position
		}
	}

	function playPause(player: MprisPlayer) {
		player.togglePlaying()
	}

	function next(player: MprisPlayer) {
		player.next()
	}

	function previous(player: MprisPlayer) {
		player.previous()
	}
	Instantiator {
		model: root.players

		delegateModelAccess: DelegateModel.ReadOnly

		delegate: Connections {
			target: modelData

			function onTrackArtUrlChanged() {

				const trackArtUrl = modelData.trackArtUrl

				if (!trackArtUrl) {
					return;
				}

				const key = root.key(modelData.dbusName, modelData.trackTitle)
				root.trackArtUrlList[key] = trackArtUrl
				// console.log(JSON.stringify(root.trackArtUrlList))
			}
		}
	}
}
