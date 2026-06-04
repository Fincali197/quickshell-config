pragma Singleton
pragma ComponentBehavior: Bound
// import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

/**
 * A nice wrapper for default Pipewire audio sink and source.
 */
Singleton {
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    property real sinkVolume: sink?.audio.volume ?? 0
    property real sourceVolume: source?.audio.volume ?? 0

    function setSinkVolume(volume) {
        sink.audio.volume = volume
    }
    function setSourceVolume(volume) {
        sink.audio.volume = volume
    }

    PwObjectTracker {
        objects: [sink, source]
    }
}
