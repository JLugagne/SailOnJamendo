import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

Page {
    id: page
    SilicaListView {
        id: list
        anchors.fill: parent
        clip: true
        header: PageHeader {
                title: JamModel.jamModel.artist.name
            }
        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlistCount > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: "Play all tracks"
                onClicked: {
                    var pl = new Array();
                    var i = 0;
                    for(i = 0; i < JamModel.jamModel.artist.tracks.length; i++){
                        var tr = JamModel.jamModel.artist.tracks[i];
                        pl.push({
                                    "url":tr.audio,
                                    "image":tr.image,
                                    "artist":JamModel.jamModel.artist.name,
                                    "name":tr.name,
                                    "album":tr.album_name,
                                    "albumId":tr.album_id,
                                    "duration":tr.duration
                                });
                    }
                    JamModel.jamModel.playlist = pl;
                    JamModel.jamPlaying.image = JamModel.jamModel.artist.image
                    JamModel.jamPlaying.artist = JamModel.jamModel.artist.name
                    JamModel.jamPlaying.album = JamModel.jamModel.artist.name
                }
            }
        }

        model: JamModel.jamModel.artist.tracks
        VerticalScrollDecorator {}
        delegate: BackgroundItem {
            height:track.height+((header.visible) ? header.height : 0)
            JamDelegateAlbum {
                id: header
                visible: index == 0 || (index > 0 && JamModel.jamModel.artist.tracks[index-1].album_id != modelData.album_id)

                imgSource: modelData.image
                primaryDesc: modelData.album_name
                secondaryDesc: modelData.releasedate
                album_id: modelData.album_id
            }
            JamDelegateTrack {
                id: track
                anchors.bottom: parent.bottom
                trackName: modelData.name
                trackDuration: modelData.duration
                trackUrl: modelData.audio
                albumImage: modelData.image
                albumName: modelData.album_name
                artistName: JamModel.jamModel.artist.name
                albumId: modelData.album_id
                //property int album_id: JamModel.jamModel.artist.tracks[index].album_id
            }
        }
    }
}
