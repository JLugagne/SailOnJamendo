import QtQuick 2.0
import Sailfish.Silica 1.0

import "delegates"
import "models"

Page {
    property alias searchFor: model.searchFor
    property alias searchIn: model.searchIn
    property alias searchDone: model.searchDone

    onSearchInChanged: {
        var sIn = searchIn.toLowerCase();
        if(sIn == "artists"){
            list.delegate = artistsDelegate
        }else if(sIn == "albums"){
            list.delegate = albumsDelegate
        }else if(sIn == "tracks"){
            list.delegate = tracksDelegate
        }
    }

    Component.onCompleted: { model.searchResults.clear(); model.doSearch(); }

    JamModelSearch {
        id: model
    }

    Component {
        id: albumsDelegate
        JamDelegateAlbum {
            imgSource: _albumImage
            primaryDesc: _albumName
            secondaryDesc: _artistName
            album_id: _albumId
            menu: ContextMenu {
                MenuItem {
                    text: "Go to the artist"
                    onClicked: {
                        JamModel.getArtist(_artistId);
                        pageStack.push(Qt.resolvedUrl("JamArtist.qml"));
                    }
                }
            }
        }
    }
    Component {
        id: artistsDelegate
        JamDelegateArtist {
            artistName: _artistName
            artistImage: _artistImage
            artistId: _artistId
        }
    }
    Component {
        id: tracksDelegate
        JamDelegateTrack {
            trackName: _trackName
            trackDuration: _trackDuration
            trackUrl: _trackUrl
            albumImage: _albumImage
            albumName: _albumName
            artistName: _artistName
            albumId: _albumId
            menu: ContextMenu {
                MenuItem {
                    text: "Go to the album"
                    onClicked: {
                        JamModel.getAlbum(albumId);
                        pageStack.push(Qt.resolvedUrl("JamAlbum.qml"));
                    }
                }
                MenuItem {
                    text: "Go to the artist"
                    onClicked: {
                        JamModel.getArtist(artistId);
                        pageStack.push(Qt.resolvedUrl("JamArtist.qml"));
                    }
                }
            }
        }
    }

    SilicaListView {
        id: list
        anchors.fill: parent
        spacing: Theme.paddingSmall
        header: PageHeader {
            title: searchIn
        }
        model: model.searchResults

        PushUpMenu {
            MenuItem {
                text: "See more ..."
                onClicked: doSearch()
            }
        }

        BusyIndicator {
            id: busy
            anchors.centerIn: parent
            visible: !searchDone
            size: BusyIndicatorSize.Large
            running: visible
        }

        Text {
            visible: searchDone && list.count == 0
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor
            anchors.centerIn: parent
            text: "No results found"
        }
    }
}
