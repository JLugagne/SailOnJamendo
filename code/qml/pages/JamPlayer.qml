import QtQuick 2.0
import QtMultimedia 5.0
import "../js/jamlib.js" as JamModel
import "../js/jamdb.js" as JamDB

Audio {
    id: audio
    property bool isPlayingState: false
    property bool pauseState: false
    onPauseStateChanged: {
        if(!pauseState)
            play();
        else
            pause();
    }
    autoPlay: true
    autoLoad: true
    source: JamModel.jamModel.stream.url

    onSourceChanged: JamDB.addAlbumToDB(JamModel.jamModel.stream.albumId, JamModel.jamModel.stream.album, JamModel.jamModel.stream.artist, JamModel.jamModel.stream.image);

    onStatusChanged: {
        if(status == Audio.EndOfMedia)
            JamModel.jamModel.nextTrack();
    }

    onDurationChanged: JamModel.jamPlaying.duration = duration/1000
    onPositionChanged: JamModel.jamPlaying.position = position/1000
    onBufferProgressChanged: {
        JamModel.jamPlaying.buffering = parseInt(bufferProgress*100)
    }
    onPaused: { isPlayingState = false; JamModel.jamModel.pause = true; }
    onPlaying: { isPlayingState = true; JamModel.jamModel.pause = false; }

}
