import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel
import "delegates"
import "models"

Page {
    id: page

    property alias artistId: artistModel.artistId
    Component.onCompleted: artistModel.getArtist()

    JamModelArtist {
        id: artistModel
    }

    SilicaListView {
        id: list
        anchors.fill: parent
        clip: true
        header: PageHeader {
                title: artistModel.artistName
            }
        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlist.tracks.count > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: qsTr("Add all tracks to queue")
                enabled: artistModel.tracksLoaded
                onClicked: artistModel.addAllToQueue()
            }
            MenuItem {
                text: qsTr("Play all tracks")
                enabled: artistModel.tracksLoaded
                onClicked: artistModel.playAll()
            }
        }

        model: artistModel.tracks

        section.property: "_albumId"
        section.delegate: JamDelegateAlbum {
                id: header
                property variant it: artistModel.getAlbumById(section)
                imgSource: it._albumImage
                primaryDesc: it._albumName
                secondaryDesc: it._albumReleaseDate
                album_id: it._albumId
            }

        delegate: JamDelegateTrack {
                    id: track
                    trackName: _trackName
                    trackDuration: _trackDuration
                    trackUrl: _trackUrl
                    albumImage: _albumImage
                    albumName: _albumName
                    artistName: _artistName
                    albumId: _albumId
                }

        BusyIndicator {
            id: busy
            anchors.centerIn: parent
            visible: !artistModel.tracksLoaded
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}
