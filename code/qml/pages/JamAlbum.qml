import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

Page {
    id: page
    onStatusChanged: column.scrollToTop();

    SilicaListView {
        id: column
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlistCount > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: "Play the album"
                onClicked: {
                    var pl = new Array();
                    var i = 0;
                    for(i = 0; i < JamModel.jamModel.album.tracks.length; i++){
                        pl.push({
                                    "url":JamModel.jamModel.album.tracks[i].audio,
                                    "albumId":JamModel.jamModel.album.id,
                                    "image":JamModel.jamModel.album.image,
                                    "artist":JamModel.jamModel.album.artist_name,
                                    "name":JamModel.jamModel.album.tracks[i].name,
                                    "album":JamModel.jamModel.album.name,
                                    "duration":JamModel.jamModel.album.tracks[i].duration
                                });
                    }
                    JamModel.jamPlaying.image = JamModel.jamModel.album.image
                    JamModel.jamPlaying.artist = JamModel.jamModel.album.artist_name
                    JamModel.jamPlaying.album = JamModel.jamModel.album.name
                    JamModel.jamModel.playlist = pl;
                }
            }
        }
        header: Column {
                width: page.width
                PageHeader {
                    title: "Album"
                }
                Label {
                    text: JamModel.jamModel.album.artist_name
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                }
                Label {
                    text: JamModel.jamModel.album.name
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                }
                Image {
                    width: parent.width*0.75
                    asynchronous: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: JamModel.jamModel.album.image
                    onSourceSizeChanged: if(status == Image.Ready) { height = sourceSize.height*(width/sourceSize.width); }
                }
            }

        model: JamModel.jamModel.album.tracks
        delegate: JamDelegateTrack {
            anchors.margins: Theme.paddingMedium
            trackDuration: modelData.duration
            trackName: modelData.name
            trackUrl: modelData.audio
            albumImage: JamModel.jamModel.album.image
            albumName: JamModel.jamModel.album.name
            albumId: JamModel.jamModel.album.id
            artistName: JamModel.jamModel.album.artist_name
        }

        BusyIndicator {
            id: busy
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: parent.count == 0
            size: BusyIndicatorSize.Large
            running: visible
        }

        /*ListItem {
            Label {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                text: "("+JamModel.timeToString(JamModel.jamModel.album.tracks[index].duration)+") "+JamModel.jamModel.album.tracks[index].name
            }

        }*/
    }
}
