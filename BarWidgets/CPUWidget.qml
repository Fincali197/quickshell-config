import "../Singletons"
import "../Theme"
import QtQuick.Shapes
import QtQuick

Rectangle {
    id: root

    color: "transparent"

    implicitWidth: Theme.height
    implicitHeight: Theme.height

    CircularProgress {
        radius: Theme.height / 3
        centerX: root.width / 2
        centerY: root.height / 2
        startAngle: 270
        value: ResourceUsage.cpuUsage
        strokeWidth: 3
        color: Theme.textColor
        backgroundColor: Theme.secondaryBackgroundColor
    }

    // ThemedText {
    //     anchors.centerIn: parent
    //     text: "C"
    //     // 
    // }

    Shape {

        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: Theme.fontSize / 6
            strokeColor: Theme.textColor
            fillColor: "transparent"
            capStyle: ShapePath.FlatCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2

                radiusX: Theme.fontSize * 11 / 24
                radiusY: Theme.fontSize * 11 / 24

                startAngle: 40
                sweepAngle: 280
            }
        }
    }
}
