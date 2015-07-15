import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

Item {
    property int artistId
    property string artistName
    property bool artistLoaded: false
    property bool tracksLoaded: false
    property alias tracks: _tracks

    ListModel {
        id: _tracks
    }

    function getArtist()
    {
        JamModel.getData("artists", "", "id="+artistId, parseArtist);
        JamModel.getData("tracks", "", "type=single albumtrack&limit=200&order=releasedate&artist_id="+artistId, parseTracks);
    }

    function parseArtist(data)
    {
        var res = JSON.parse(data)
        var results = res["results"];
        if(results.length > 0)
            artistName = results[0].name;
        else
            artistName = "Not found";

        artistLoaded = true;
    }

    function parseTracks(data)
    {
        var res = JSON.parse(data)
        var results = res["results"];
        var i = 0;

        for(i = 0; i < results.length; i++){
            var it = results[i];
            tracks.append({"_trackName": it.name, "_trackUrl": it.audio, "_trackDuration": parseInt(it.duration), "_albumId": parseInt(it.album_id), "_albumReleaseDate": it.releasedate, "_albumImage": it.image, "_albumName": it.album_name, "_artistName": it.artist_name, "_artistId": it.artist_id});
        }

        tracksLoaded = true;
    }

    function getAlbumById(albumId)
    {
        var i = 0;
        for(i = 0; tracks.count; i++){
            var it = tracks.get(i);
            if(it._albumId == albumId)
                return it;
        }
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
                        "_albumImage": tr._albumImage,
                        "_artistName": tr._artistName,
                        "_trackName": tr._trackName,
                        "_albumName": tr._albumName,
                        "_albumId": tr._albumId,
                        "_trackDuration": tr._trackDuration.toString()
                    });
        }

        return pl;
    }

    function addAllToQueue()
    {
        var pl = toArray();
        JamModel.jamModel.playlist.addToPlaylist(pl);
    }

    function playAll()
    {
        var pl = toArray();
        JamModel.jamModel.playlist.setPlaylist(pl);
    }
}
