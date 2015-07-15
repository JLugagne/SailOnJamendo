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

        onCountChanged: {
            if(currentTrack !== undefined){
                var i = 0;
                for(i = 0; i < _tracks.count; i++){
                    if(currentTrack._trackUrl == _tracks.get(i)._trackUrl){
                        currentTrackId = i;
                        break;
                    }
                }
            }
        }
    }

    onCurrentTrackIdChanged: {
                                 if(currentTrackId >= 0){
                                     var id = currentTrackId;
                                     if(bShuffle)
                                         id = shuffle[id];
                                     if(currentTrack === undefined || currentTrack._trackUrl != _tracks.get(id)._trackUrl)
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
        var nextId = currentTrackId+1;
        if(nextId == _tracks.count)
            if(bRepeat)
                nextId = 0;
            else
                nextId = nextId - 1;
        currentTrackId = nextId;
    }

    function previousTrack()
    {
        var prevId = currentTrackId-1;
        if(prevId < 0)
            if(bRepeat)
                prevId = _tracks.count-1;
            else
                prevId = 0;
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
        console.log("-> "+arr.length)
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

    function removeUrl(url)
    {
        var i = 0;
        for(i = 0; i < _tracks.count; i++){
            if(_tracks.get(i)._trackUrl == url){
                _tracks.remove(i);
                break;
            }
        }
        bShuffle = !bShuffle;
        bShuffle = !bShuffle;
    }
}
