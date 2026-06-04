// Bar.qml

import "Theme"
import "BarWidgets"
import "Panel"
import Quickshell
import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts

PanelWindow {

    id: root

    implicitHeight: Theme.height + Theme.bottomMargin
    implicitWidth: rowLayout.implicitWidth
    color: "transparent"

    anchors {
        bottom: true
        left: true
        right: true
        top: false
    }
    RowLayout {
        
        id: rowLayout

        anchors {
            fill: parent
            bottomMargin: Theme.bottomMargin
            leftMargin: Theme.leftMargin
            rightMargin: Theme.rightMargin
            topMargin: 0
        }
        spacing: 10

        ThemedRectangle {

            Layout.preferredWidth: clock.implicitWidth + calendar.implicitWidth + Theme.textPadding * 2 + Theme.borderWidth
            Layout.fillHeight: true

            ClockWidget {
                id: clock
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: Theme.textPadding/2
            }

            Rectangle {
                id: timeBorder
                color: Theme.borderColor
                width: Theme.borderWidth
                implicitHeight: Theme.height
                anchors.left: clock.right
                anchors.leftMargin: Theme.textPadding/2
                anchors.verticalCenter: parent.verticalCenter
            }


            CalendarWidget {
                id: calendar
                anchors.left: timeBorder.right
                anchors.leftMargin: Theme.textPadding/2
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        ThemedRectangle {

            Layout.preferredWidth: workspaceWidget.implicitWidth + Theme.textPadding/3*4
            Layout.fillHeight: true

            WorkspaceWidget {
                id: workspaceWidget

                anchors {
                    fill: parent
                    leftMargin: Theme.textPadding/3
                    rightMargin: Theme.textPadding/3
                }
            }
        }

        ThemedRectangle {

            Layout.preferredWidth: keyboardWidget.implicitWidth + Theme.textPadding
            Layout.fillHeight: true

            KeyboardWidget {
                id: keyboardWidget
            }
        }

        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ThemedRectangle {

            Layout.preferredWidth: volumeWidget.implicitWidth + Theme.textPadding
            Layout.fillHeight: true

            VolumeWidget {
                id: volumeWidget
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: dockContainer

            color: "transparent"
            Layout.preferredWidth: Theme.dockWidth
            Layout.fillHeight: true
        }
        SidePanel{
            margins.left: dockContainer.x + Theme.leftMargin
        }
    }
}
