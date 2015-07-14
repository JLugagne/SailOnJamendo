import QtQuick 2.0
import Sailfish.Silica 1.0

import "delegates"
import "models"

import "../js/jamlib.js" as JamModel

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
            JamModelAlbum {
                id: albumModel
                albumId: _albumId
            }

            imgSource: _albumImage
            primaryDesc: _albumName
            secondaryDesc: _artistName
            album_id: _albumId
            menu: ContextMenu {
                MenuItem {
                    text: "Play the album"
                    onClicked: { albumModel.callback = albumModel.playAlbum; albumModel.getAlbum(); }
                }
                MenuItem {
                    text: "Add album to queue"
                    onClicked: { albumModel.callback = albumModel.addAlbumToQueue; albumModel.getAlbum(); }
                }
                MenuItem {
                    text: "Go to the artist"
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("JamArtist.qml"), {"artistId": _artistId});
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
            id: item
            trackName: _trackName
            trackDuration: _trackDuration
            trackUrl: _trackUrl
            albumImage: _albumImage
            albumName: _albumName
            artistName: _artistName
            albumId: _albumId
            property int artistId: _artistId
            menu: ContextMenu {
                MenuItem {
                    text: "Go to the album"
                    enabled: item.albumId != 0
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("JamAlbum.qml"), {"albumId": item.albumId});
                    }
                }
                MenuItem {
                    text: "Go to the artist"
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("JamArtist.qml"), {"artistId": item.artistId});
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
                onClicked: model.doSearch()
            }
        }

        BusyIndicator {
            id: busy
            anchors.centerIn: parent
            visible: !model.searchDone
            size: BusyIndicatorSize.Large
            running: visible
        }

        Text {
            visible: model.searchDone && list.count == 0
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor
            anchors.centerIn: parent
            text: "No results found"
        }
    }
}
