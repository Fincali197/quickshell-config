// KeyboardWidget.qml
import "../Theme"
import "../Singletons"
import QtQuick
import Quickshell.Hyprland

ThemedText {
    id: myText
    text: HyprlandXKB.currentLayoutName
    anchors.centerIn: parent
}
