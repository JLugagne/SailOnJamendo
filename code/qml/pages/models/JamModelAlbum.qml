import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

Item {
    id: item
    property int albumId
    property string albumName
    property string albumImage
    property string artistName
    property int artistId
    property alias tracks: _tracks
    property bool loaded: false;
    property var callback

    ListModel {
        id: _tracks
    }

    function getAlbum(){
        JamModel.getData("albums", "tracks", "order=track_position&id="+albumId, parseResults)
    }

    function parseResults(data){
        var res = JSON.parse(data);
        var results = res["results"];

        if(results.length > 0){
            albumName = results[0].name;
            albumImage = results[0].image;
            artistName = results[0].artist_name;
            artistId = results[0].artist_id

            var tracks = results[0].tracks;
            var i = 0;
            for(i = 0; i < tracks.length; i++){
                var it = tracks[i];
                _tracks.append({"_trackName": it.name, "_trackUrl": it.audio, "_trackDuration": it.duration});
            }
        }

        if(callback !== undefined)
            callback();

        loaded = true;
    }

    function toArray()
    {
        var pl = new Array();
        var i = 0;
        var tracks = _tracks;
        for(i = 0; i < tracks.count; i++){
            var tr = tracks.get(i);
            pl.push({
                        "_trackUrl": tr._trackUrl,
                        "_albumImage": item.albumImage,
                        "_artistName": item.artistName,
                        "_trackName": tr._trackName,
                        "_albumName": item.albumName,
                        "_albumId": item.albumId,
                        "_trackDuration": tr._trackDuration
                    });
        }

        return pl;
    }

    function addAlbumToQueue()
    {
        var pl = toArray();
        JamModel.jamModel.playlist.addToPlaylist(pl);
    }

    function playAlbum()
    {
        var pl = toArray();
        JamModel.jamModel.playlist.setPlaylist(pl);
    }
}
