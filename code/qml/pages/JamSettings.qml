import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel
import "../js/jamdb.js" as JamDB

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            PageHeader {
                title: "Settings"
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Clear last played"
                onClicked: { remorse.execute("Clear last played", function() { JamDB.clearPlayedAlbums() }) }
            }
        }
    }
    RemorsePopup {
        id: remorse
    }
}
