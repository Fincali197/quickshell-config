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

    function getArtUrl(player: MprisPlayer): string {
        if (!player)
            return "";

        if (player.trackArtUrl)
            return player.trackArtUrl;

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

    PersistentProperties {
        id: props

        property MprisPlayer manualPlayer
    }
}
