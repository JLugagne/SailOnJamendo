import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "pages"

import "js/jamdb.js" as JamDB

ApplicationWindow
{
    function openDB(){
        JamDB.JamDatabase = LocalStorage.openDatabaseSync("SailOnJamendo", "1.0", "SailOnJamendo database for settings and history", 5000000);
        JamDB.JamDatabase.transaction(
                function(tx) {
                    tx.executeSql("CREATE TABLE IF NOT EXISTS album(albumId INT, lastPlayed INT, albumImage TEXT, albumTitle TEXT, albumArtist TEXT)");
                    JamDB.updateAlbums();
                }
        );
    }

    initialPage: Component { JamFeeds { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    Component.onCompleted: openDB();
}


