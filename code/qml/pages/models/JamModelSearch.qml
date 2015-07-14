import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

Item {
    property string searchFor
    property string searchIn
    property bool searchDone: false
    property alias searchResults: _searchResults

    ListModel  {
        id: _searchResults
    }

    function doSearch()
    {
        searchDone = false;

        var module = searchIn.toLowerCase();
        var action = "";
        var args = "limit=30&offset="+searchResults.count+"&namesearch="+searchFor;

        if(module == "tracks"){
            args = args+"&type=single albumtrack";
        }

        JamModel.getData(module, action, args, parseResults);
    }

    function artistToModel(it)
    {
        return {"_artistName": it.name, "_artistImage": it.image, "_artistId": it.id};
    }

    function albumToModel(it)
    {
        return {"_albumId": it.id, "_albumImage": it.image, "_albumName": it.name, "_artistName": it.artist_name, "_artistId": it.artist_id};
    }

    function trackToModel(it)
    {
        return {"_trackName": it.name, "_trackUrl": it.audio, "_trackDuration": it.duration, "_albumId": it.album_id, "_albumImage": it.image, "_albumName": it.album_name, "_artistName": it.artist_name, "_artistId": it.artist_id};
    }

    function parseResults(data)
    {
        var res = JSON.parse(data);
        var results = res["results"];
        var sIn = searchIn.toLowerCase();
        var i = 0;
        var fct;
        if(sIn == "artists"){
            fct = artistToModel;
        }else if(sIn == "albums"){
            fct = albumToModel;
        }else if(sIn == "tracks"){
            fct = trackToModel;
        }

        for(i = 0; i < results.length; i++){
            searchResults.append(fct(results[i]));
        }
        searchDone = true;
    }
}
