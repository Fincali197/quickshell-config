// PanelContent.qml

import "../Singletons"
import "../Theme"
import QtQuick
import QtQuick.Layouts

ColumnLayout {

    id: root

    spacing: 0

    Loader {
        id: musicPanelLoader
        source: Music.playerExists ? "MusicPanel.qml" : ""
        Layout.fillWidth: true

        visible: status === Loader.Ready
        Layout.preferredHeight: visible ? -1 : 0
    }

	Item {
		visible: Music.playerExists
		Layout.preferredHeight: 15
	}

	Rectangle {
		visible: Music.playerExists
		color: Theme.borderColor
		Layout.fillWidth: true
		implicitHeight: Theme.panelBorderWidth
	}

    PerformancePanel {
        Layout.fillWidth: true
    }
}
