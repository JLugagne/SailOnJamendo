import QtQuick 2.0
import QtMultimedia 5.0
import "../js/jamlib.js" as JamModel

Audio {
    id: audio
    property bool pauseState: JamModel.jamModel.pause
    onPauseStateChanged: {
        if(!pauseState)
            play();
        else
            pause();
    }
    autoPlay: true
    autoLoad: true
    source: JamModel.jamModel.stream.url
    onStatusChanged: {
        if(status == Audio.EndOfMedia)
            JamModel.jamModel.nextTrack();
    }
    onDurationChanged: JamModel.jamPlaying.duration = duration/1000
    onPositionChanged: JamModel.jamPlaying.position = position/1000
    onBufferProgressChanged: {
        JamModel.jamPlaying.buffering = parseInt(bufferProgress*100)
    }
}
