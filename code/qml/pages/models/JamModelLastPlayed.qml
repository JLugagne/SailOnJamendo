import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../../js/jamdb.js" as JamDB
import "../../js/jamlib.js" as JamModel

Item {
    id: item
    property alias albums: _albums
    property bool albumsUpdated: false
    property bool dbOpened: false

    onDbOpenedChanged: {
        update();
    }

    ListModel {
        id: _albums
    }

    function openDB(){
        JamDB.JamDatabase = LocalStorage.openDatabaseSync("SailOnJamendo", "1.0", "SailOnJamendo database for settings and history", 5000000);
        JamDB.JamDatabase.transaction(
                function(tx) {
                    tx.executeSql("CREATE TABLE IF NOT EXISTS album(albumId INT, lastPlayed INT, albumImage TEXT, albumTitle TEXT, albumArtist TEXT)");
                }
        );
        dbOpened = true;
    }

    function update() {
        if(JamDB.JamDatabase !== undefined){
            JamDB.JamDatabase.transaction(
                    function(tx) {
                        var rs = tx.executeSql("SELECT * FROM album ORDER BY lastPlayed DESC");
                        if(tx !== undefined){
                            if(rs.rows.length > 0){
                                var albums = new Array();
                                var i = 0;
                                for(i = 0; i < rs.rows.length; i++) {
                                    _albums.append(rs.rows.item(i));
                                    console.log(rs.rows.item(i).albumId);
                                }
                            }
                            item.albumsUpdated = true;
                        }
                    }
            );
        }else{
            openDB();
        }
    }

    function forgetAlbum(albumName, albumArtist)
    {
        JamDB.JamDatabase.transaction(
            function(tx) {
                var i = 0;
                for(i = 0; i < _albums.count; i++){
                    if(_albums.get(i).albumTitle == albumName && _albums.get(i).albumArtist == albumArtist){
                        _albums.remove(i);
                        break;
                    }
                }
                var rs = tx.executeSql("DELETE FROM album WHERE albumTitle = ? and albumArtist = ?", [albumName, albumArtist]);
            }
        );
    }

    function addAlbumToDB(albumId, albumTitle, albumArtist, albumImage)
    {
        if(albumId <= 0 || albumId == "" || albumId === undefined) return;
        JamDB.JamDatabase.transaction(
                function(tx) {
                    var rs = tx.executeSql("SELECT * FROM album WHERE albumTitle = ? and albumArtist = ?", [albumTitle, albumArtist]);
                    if(rs.rows.length == 0){
                        var res = tx.executeSql("INSERT INTO album(albumId, lastPlayed, albumImage, albumTitle, albumArtist) VALUES(?, ?, ?, ?, ?)", [albumId, (new Date()).getTime(), albumImage, albumTitle, albumArtist]);
                    }else{
                        var res = tx.executeSql("UPDATE album SET lastPlayed = ? WHERE albumTitle = ? and albumArtist = ?", [(new Date()).getTime(), albumTitle, albumArtist]);
                    }
                }
        );
    }

    function trackChanged()
    {
        if(JamModel.jamModel.playlist.currentTrack !== undefined){
            var tr = JamModel.jamModel.playlist.currentTrack;
            var albumName = (tr._albumName == "") ? tr._trackName : tr._albumName;
            if(tr._albumId <= 0 || tr._albumId == "" || tr._albumId === undefined) return;
            addAlbumToDB(tr._albumId, albumName, tr._artistName, tr._albumImage)
            var i = 0;
            var found = 0;
            for(i = 0; i < _albums.count; i++){
                if(_albums.get(i).albumId == tr._albumId){
                    _albums.move(i, 0, 1);
                    found = 1
                    break;
                }
            }
            if(found == 0){
                _albums.insert(0, {"albumId": tr._albumId, "lastPlayed": (new Date()).getTime(), "albumImage": tr._albumImage, "albumTitle": albumName, "albumArtist": tr._artistName})
            }
        }
    }

    function clearAll(){
        remorse.execute("Clear all", function() {
            JamDB.JamDatabase.transaction(
                function(tx) {
                    tx.executeSql("DELETE FROM album");
                    _albums.clear();
                }
            );
        });
    }
    RemorsePopup {
        id: remorse
    }
}
