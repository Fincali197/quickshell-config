// DNDWidget.qml

import "../Theme"
import "../Singletons"
import QtQuick

Rectangle{

    id: root

    color: "transparent"


    implicitWidth: Theme.height
    implicitHeight: Theme.height

    ThemedText {
        anchors.centerIn: parent
        text: DND.dnd_active ? "" : ""
    }

    TapHandler {
		onTapped: DND.toggleDND()
    }

    TapHandler {
        acceptedButtons: Qt.RightButton
		onTapped: DND.updateDND()
    }
}
