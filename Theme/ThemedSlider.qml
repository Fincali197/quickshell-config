// ThemedSlider.qml
import QtQuick
import QtQuick.Controls.Basic

Slider {
    id: control

    leftPadding: 0
    rightPadding: 0

    property int sliderWidth

	property bool roundedHandle: false

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: sliderWidth
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: Theme.secondaryBackgroundColor

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: Theme.secondaryColor
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: roundedHandle ? 15 : 5
        implicitHeight: roundedHandle ? 15 : 20
        radius: roundedHandle ? 15 : 2
        color: roundedHandle ? Theme.backgroundColor : Theme.secondaryColor
		border {
			width: roundedHandle ? 1 : 0
			color: Theme.borderColor
		}
    }
}
