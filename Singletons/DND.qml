// DND.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

	property bool dnd_active: false

	function toggleDND() {
		root.dnd_active = !root.dnd_active
		toggleDNDprocess.running = true
	}

	function updateDND() {
		updateDNDprocess.running = true
	}

	Process {
		id: updateDNDprocess
		running: true
		command: [ "makoctl", "mode" ]
		stdout: StdioCollector {
			onStreamFinished: {
				root.dnd_active = text.split('\n').some(line => line.includes("do-not-disturb"))
			}
		}
	}

	Process {
		id: toggleDNDprocess
		running: false
		command: [ "makoctl", "mode", "-t", "do-not-disturb" ]
	}

	Component.onCompleted: {
		updateDND()
	}
}
