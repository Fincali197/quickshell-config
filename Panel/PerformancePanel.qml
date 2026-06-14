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
            id: ramText
            anchors.centerIn: parent
            text: "RAM"
            font.pointSize: Theme.dockWidth/15
        }

        ThemedText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: ramText.top
            text: Math.floor((ResourceUsage.memoryTotal - ResourceUsage.memoryFree)/1000) + " MB"
            font.pointSize: Theme.dockWidth/45
        }

        ThemedText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ramText.bottom
            text: Math.round(ResourceUsage.memoryUsage*1000)/10 + "%"
            font.pointSize: Theme.dockWidth/45
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
            id: cpuText
            anchors.centerIn: parent
            text: "CPU"
            font.pointSize: Theme.dockWidth/15
        }

        ThemedText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: cpuText.top
            text: Math.round(ResourceUsage.cpuFreq/100000)/10 + "/" + Math.round(ResourceUsage.cpuMaxFreq/100000)/10 + " GHz"
            font.pointSize: Theme.dockWidth/45
        }

        ThemedText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: cpuText.bottom
            text: Math.round(ResourceUsage.cpuUsage*1000)/10 + "%"
            font.pointSize: Theme.dockWidth/45
        }
    }
}
