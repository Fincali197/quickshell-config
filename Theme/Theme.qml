// Theme.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string backgroundColor: "#FF202020"
    readonly property string textColor: "#FFa0a0a0"
    readonly property string secondaryBackgroundColor: "#FF404040"
    readonly property string secondaryColor: "#FFa0a0a0"
    readonly property string borderColor: "#FF353535"

    readonly property string font: "Google Sans"
    readonly property real fontSize: 12

    readonly property int height: 30

    readonly property int textPadding: 15

    readonly property int bottomMargin: 10
    readonly property int topMargin: 10
    readonly property int rightMargin: 10
    readonly property int leftMargin: 10

    readonly property int borderWidth: 1
    readonly property int borderRadius: 10

	readonly property int panelBorderWidth: 3

    property int dockWidth: 500
}
