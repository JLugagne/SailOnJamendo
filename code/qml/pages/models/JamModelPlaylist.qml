import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property bool bShuffle: false
    property bool bRepeat: false
    property alias tracks: _tracks
    property variant shuffle: []
    property int currentTrackId: -1

    property variant currentTrack


    ListModel {
        id: _tracks
    }

    onCurrentTrackIdChanged: {
                                 if(currentTrackId >= 0){
                                     var id = currentTrackId;
                                     if(bShuffle)
                                         id = shuffle[id]
                                     currentTrack = _tracks.get(id);
                                 }
                             }

    onBShuffleChanged: {
                            var o = [];
                            var i;
                            if(bShuffle){
                                for(i = 0; i < _tracks.count; i++) o.push(i);
                                for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
                            }
                            shuffle = o;
                       }

    onCurrentTrackChanged: if(currentTrack == null) currentTrack = undefined;

    function hasNextTrack()
    {
        return bRepeat || currentTrackId < _tracks.count-1;
    }

    function hasPreviousTrack()
    {
        return bRepeat || currentTrackId > 0;
    }

    function nextTrack()
    {
        var nextId = Math.min(currentTrackId+1,_tracks.count-1);
        if(bRepeat && nextId == _tracks.count-1)
            nextId = 0;
        currentTrackId = nextId;
    }

    function previousTrack()
    {
        var prevId = Math.max(currentTrackId-1, 0);
        if(bRepeat && prevId == 0)
            prevId = _tracks.count-1;
        currentTrackId = prevId;
    }

    function setPlaylist(arr)
    {
        var i = 0;
        _tracks.clear();
        addToPlaylist(arr);
        currentTrackId = -1;
        nextTrack();
    }

    function addToPlaylist(arr)
    {
        var i = 0;
        for(i=0; i < arr.length; i++){
            if(!checkContainsUrl(arr[i]._trackUrl))
                _tracks.append(arr[i]);
        }
        bShuffle = !bShuffle;
        bShuffle = !bShuffle;
    }

    function checkContainsUrl(url)
    {
        var i = 0;
        for(i = 0; i < _tracks.count; i++){
            if(_tracks.get(i)._trackUrl == url) return true;
        }
        return false;
    }
}
