// WorkspaceWidget.qml
import "../Theme"
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
    id: row
    spacing: 0

    property var wsValues: Hyprland.workspaces.values

    function hasWs(id): HyprlandWorkspace {
        for (let i = 0; i < wsValues.length; i++) {
            if (wsValues[i].id === id)
                return wsValues[i];
        }
        return null;
    }

    Repeater {
        model: 6

        delegate: Rectangle {
            id: indicatorWrapper

            property int wsId: index + 1

            TapHandler {
                onTapped: Hyprland.dispatch("hl.dsp.focus({workspace = " + String(indicatorWrapper.wsId) + " })")
            }

            implicitWidth: childRect.implicitWidth + 3
            implicitHeight: 20
            radius: 8

            color: "transparent"

            Rectangle {
                id: childRect
                anchors.centerIn: parent
                property HyprlandWorkspace active: row.hasWs(indicatorWrapper.wsId)
				property bool hasSomething: active?.toplevels.values.length > 0 ?? false
                color: {
                    if (hasSomething) {
                        return Theme.secondaryColor;
                    } else {
                        return Theme.backgroundColor;
                    }
                }

                implicitWidth: indicatorWrapper.wsId == Hyprland.focusedWorkspace?.id ?? null ? implicitHeight * 2 : implicitHeight
                implicitHeight: 8 + Theme.borderWidth
                radius: 5
                border.width: hasSomething ? 0 : Theme.borderWidth
                border.color: Theme.secondaryBackgroundColor
            }
        }
    }
}
