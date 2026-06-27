import "../Theme"
import "../Singletons"
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 5
    ThemedText {
        id: soundIcon
        text: Audio.sinkVolume > 0 ? (Audio.sinkVolume > 0.5 ? "" : "") : ""
        Layout.alignment: Qt.AlignVCenter
    }
    ThemedSlider {
        Layout.alignment: Qt.AlignVCenter
        sliderWidth: 120
        value: Audio.sinkVolume
        onMoved: Audio.setSinkVolume(value)
    }
    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: Audio.setSinkVolume(0.5)
    }
}
