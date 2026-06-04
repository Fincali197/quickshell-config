import QtQuick
import QtQuick.Shapes

Shape {
    id: shape

    property int radius
    property int centerX
    property int centerY
    property int startAngle
    property real value
    property int strokeWidth
    property string color
    property string backgroundColor

    // anchors.fill: parent
    preferredRendererType: Shape.CurveRenderer
    ShapePath {
        strokeWidth: shape.strokeWidth
        strokeColor: shape.backgroundColor
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap

        PathAngleArc {
            centerX: shape.centerX
            centerY: shape.centerY

            radiusX: shape.radius
            radiusY: shape.radius

            startAngle: 0
            sweepAngle: 360
        }
    }
    ShapePath {
        strokeWidth: shape.strokeWidth
        strokeColor: shape.color
        fillColor: "transparent"
        capStyle: ShapePath.FlatCap

        PathAngleArc {
            centerX: shape.centerX
            centerY: shape.centerY

            radiusX: shape.radius
            radiusY: shape.radius

            startAngle: shape.startAngle
            sweepAngle: 360*shape.value
        }
    }
}
