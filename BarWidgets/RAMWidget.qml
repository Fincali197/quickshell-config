// RAMWidget.qml
import "../Singletons"
import "../Theme"
import QtQuick.Shapes
import QtQuick

Rectangle{

    color: "transparent"

    implicitWidth: Theme.height
    implicitHeight: Theme.height

    CircularProgress {
        radius: Theme.height/3
        centerX: parent.width/2
        centerY: parent.height/2
        startAngle: 270
        value: ResourceUsage.memoryUsage
        strokeWidth: 3
        color: Theme.textColor
        backgroundColor: Theme.secondaryBackgroundColor
    }

    ThemedText {
        anchors.centerIn: parent
        text: "R"
    }
}
