.pragma library

var JamDatabase;

function updateAlbums(){
    JamDatabase.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM album ORDER BY lastPlayed DESC");
                var albums = new Array();
                var i = 0;
                for(i = 0; i < rs.rows.length; i++) {
                    albums.push(rs.rows.item(i));
                }
                jamDB.lastAlbum = albums;
            }
    );
}

function addAlbumToDB(albumId, albumTitle, albumArtist, albumImage){
    if(albumTitle == "") return;
    console.log("addAlbumToDB = "+albumTitle)
    JamDatabase.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM album WHERE albumId = ?", [albumId]);
                if(rs.rows.length == 0){
                    var res = tx.executeSql("INSERT INTO album(albumId, lastPlayed, albumImage, albumTitle, albumArtist) VALUES(?, ?, ?, ?, ?)", [albumId, (new Date()).getTime(), albumImage, albumTitle, albumArtist]);
                    console.log(res)
                }
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
