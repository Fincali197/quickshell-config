// PerformancePanel.qml

import "../Theme"
import "../Singletons"
import QtQuick.Layouts
import QtQuick

RowLayout {

    spacing: 0

    Rectangle{
        color: "transparent"

        implicitWidth: Theme.dockWidth/2
        implicitHeight: Theme.dockWidth/2

        CircularProgress {
            radius: Theme.dockWidth / 6
            centerX: parent.width/2
            centerY: parent.height/2
            startAngle: 270
            value: ResourceUsage.memoryUsage
            strokeWidth: Theme.dockWidth/16
            color: Theme.textColor
            backgroundColor: Theme.secondaryBackgroundColor
        }

        ThemedText {
            anchors.centerIn: parent
            text: "RAM"
            font.pointSize: Theme.dockWidth/12
        }
    }

    Rectangle{
        color: "transparent"

        implicitWidth: Theme.dockWidth/2
        implicitHeight: Theme.dockWidth/2

        CircularProgress {
            radius: Theme.dockWidth / 6
            centerX: parent.width/2
            centerY: parent.height/2
            startAngle: 270
            value: ResourceUsage.cpuUsage
            strokeWidth: Theme.dockWidth/16
            color: Theme.textColor
            backgroundColor: Theme.secondaryBackgroundColor
        }

        ThemedText {
            anchors.centerIn: parent
            text: "CPU"
            font.pointSize: Theme.dockWidth/12
        }
    }
}
