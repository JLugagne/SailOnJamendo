import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

Page {
    id: page
    SilicaListView {
        id: list
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
        clip: true
        header: PageHeader {
                title: JamModel.jamModel.artist.name
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
                //property int album_id: JamModel.jamModel.artist.tracks[index].album_id
            }
        }
    }
}
