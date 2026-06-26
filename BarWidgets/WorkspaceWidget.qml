// WorkspaceWidget.qml
import "../Theme"
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
    id: row
    spacing: 0

    property var wsValues: Hyprland.workspaces.values

    function hasWs(id) {
        for (var i = 0; i < wsValues.length; i++) {
            if (wsValues[i].id === id)
                return true
        }
        return false
    }

    // Repeater {
    //     model: 6
    //
    //     delegate: Rectangle {
    //
    //         property int wsId: index + 1
    //
    //         TapHandler {
    //             onTapped: Hyprland.dispatch("hl.dsp.focus({workspace = " + String(wsId) + " })")
    //         }
    //
    //         implicitWidth: 20
    //         implicitHeight: 20
    //         radius: 8
    //
    //         color: (wsId == Hyprland.focusedWorkspace?.id ?? null)
    //                ? Theme.secondaryColor
    //                : "#00000000"
    //
    //
    //         Rectangle {
    //             anchors.centerIn: parent
    //             color: {
    //                 if (wsId == Hyprland.focusedWorkspace?.id ?? null) {
    //                     return Theme.backgroundColor
    //                 } else if (hasWs(wsId)) {
    //                     return Theme.secondaryColor
    //                 } else {
    //                     return Theme.backgroundColor
    //                 }
    //             }
    //
    //             implicitWidth: 10
    //             implicitHeight: 10
    //             radius: 4
    //             border.width: Theme.borderWidth
    //             border.color: Theme.borderColor
    //         }
    //     }
    // }
    Repeater {
        model: 6

        delegate: Rectangle {

            property int wsId: index + 1

            TapHandler {
                onTapped: Hyprland.dispatch("hl.dsp.focus({workspace = " + String(wsId) + " })")
            }

            implicitWidth: childRect.implicitWidth + 3
            implicitHeight: 20
            radius: 8

			color: "transparent"

            Rectangle {
				id: childRect
                anchors.centerIn: parent
                color: {
                    if (hasWs(wsId)) {
                        return Theme.secondaryColor
                    } else {
                        return Theme.backgroundColor
                    }
                }

				implicitWidth: wsId == Hyprland.focusedWorkspace?.id ?? null ? implicitHeight * 2 : implicitHeight
                implicitHeight: 8 + Theme.borderWidth
                radius: 5
                border.width: hasWs(wsId) ? 0 : Theme.borderWidth
                border.color: Theme.secondaryBackgroundColor
            }
        }
    }
}
