// PanelContent.qml

import "../Singletons"
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

    PerformancePanel {
        Layout.fillWidth: true
    }
}
