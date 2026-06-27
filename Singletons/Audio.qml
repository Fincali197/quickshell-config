pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    property real sinkVolume: sink?.audio.volume ?? 0
    property real sourceVolume: source?.audio.volume ?? 0

    function setSinkVolume(volume) {
        sink.audio.volume = volume;
    }
    function setSourceVolume(volume) {
        sink.audio.volume = volume;
    }

    PwObjectTracker {
        objects: [sink, source]
    }
}
