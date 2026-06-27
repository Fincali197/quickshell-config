pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string text
    Process {
        running: true
        command: ["hyprctl", "splash"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.text = this.text;
            }
        }
    }
}
