import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

Page {
    id: page
    property int oldCount: 0;
    onStatusChanged: { if(oldCount != list.count) list.scrollToTop(); oldCount = list.count }
    onEntered: list.scrollToTop()

    Component {
        id: albumsDelegate
        JamDelegateAlbum {
            imgSource: modelData.image
            primaryDesc: modelData.name
            secondaryDesc: modelData.artist_name
            album_id: modelData.id
        }
    }
    Component {
        id: artistsDelegate
        JamDelegateArtist {
            name: modelData.name
            image: modelData.image
            artist_id: modelData.id
        }
    }
    Component {
        id: tracksDelegate
        JamDelegateTrack {
            trackName: modelData.name
            trackDuration: modelData.duration
            trackUrl: modelData.audio
            albumImage: modelData.album_image
            albumName: modelData.album_name
            artistName: modelData.artist_name
            albumId: modelData.album_id
        }
    }

    SilicaListView {
        id: list
        anchors.fill: parent
        model: JamModel.jamModel.search
        header: PageHeader {
            title: "Results : "+JamModel.jamModel.searchIn
        }

        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlistCount > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
        }
        spacing: Theme.paddingSmall
        PushUpMenu {
            MenuItem {
                enabled: false
                text: "Load more ..."
                onClicked: JamModel.getSearchFor(searchFor.text, searchIn.currentItem.text, list.count);
            }
        }

        delegate: (JamModel.jamModel.searchIn == "albums") ? albumsDelegate : (JamModel.jamModel.searchIn == "tracks") ? tracksDelegate :artistsDelegate
        VerticalScrollDecorator {}
        BusyIndicator {
            id: busy
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: parent.count == 0
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}
