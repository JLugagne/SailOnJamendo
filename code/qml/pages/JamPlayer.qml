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
    source: (JamModel.jamModel.playlist.tracks.count > 0 && JamModel.jamModel.playlist.currentTrack !== undefined) ? JamModel.jamModel.playlist.currentTrack._trackUrl : ""

//    onSourceChanged: if(JamModel.jamModel.playlist.currentTrack !== undefined)
//                         JamDB.addAlbumToDB(JamModel.jamModel.playlist.currentTrack._albumId, JamModel.jamModel.playlist.currentTrack._albumName, JamModel.jamModel.playlist.currentTrack._artistName, JamModel.jamModel.playlist.currentTrack._albumImage);

    onStatusChanged: {
        if((status == Audio.EndOfMedia || status == Audio.InvalidMedia) && JamModel.jamModel.playlist.hasNextTrack()){
            JamModel.jamModel.playlist.nextTrack();
        }
    }

    onPositionChanged: JamModel.jamModel.position = position/1000
    onBufferProgressChanged: {
        JamModel.jamModel.buffering = parseInt(bufferProgress*100)
    }
    onPaused: { isPlayingState = false; JamModel.jamModel.pause = true; }
    onPlaying: { isPlayingState = true; JamModel.jamModel.pause = false; }
}
