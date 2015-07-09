.pragma library

var JamDatabase;

function updateAlbums(){
    JamDatabase.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM album ORDER BY lastPlayed DESC");
                if(rs.rows.length > 0){
                    var albums = new Array();
                    var i = 0;
                    for(i = 0; i < rs.rows.length; i++) {
                        albums.push(rs.rows.item(i));
                    }
                    jamDB.lastAlbum = albums;
                }else{
                    jamDB.lastAlbum = [{"albumTitle": "You never played anything"}];
                }
            }
    );
}

function addAlbumToDB(albumId, albumTitle, albumArtist, albumImage){
    if(albumTitle == "" || (albumTitle == "radios" && albumArtist == "radios")) return;
    JamDatabase.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM album WHERE albumId = ?", [albumId]);
                if(rs.rows.length == 0){
                    var res = tx.executeSql("INSERT INTO album(albumId, lastPlayed, albumImage, albumTitle, albumArtist) VALUES(?, ?, ?, ?, ?)", [albumId, (new Date()).getTime(), albumImage, albumTitle, albumArtist]);
                }else{
                    var res = tx.executeSql("UPDATE album SET lastPlayed = ?", [(new Date()).getTime()]);
                }
            }
    );
}


function clearPlayedAlbums(){
    JamDatabase.transaction(
            function(tx) {
                tx.executeSql("DELETE FROM album");
            }
    );
}

var jamDB = Qt.createQmlObject('import QtQuick 2.0; \
import QtQuick.LocalStorage 2.0;\
QtObject { \
    id: component;\
    property variant lastAlbum: [];\
    property variant database; \
}', Qt.application, 'JamDB');
