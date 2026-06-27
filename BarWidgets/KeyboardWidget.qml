import "../Theme"
import "../Singletons"
import QtQuick

ThemedText {
    id: myText
    text: HyprlandXKB.currentLayoutName
    anchors.centerIn: parent
}
