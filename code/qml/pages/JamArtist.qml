import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel
import "delegates"
import "models"

Page {
    id: page

    property alias artistId: model.artistId
    Component.onCompleted: model.getArtist()

    JamModelArtist {
        id: model
    }

    SilicaListView {
        id: list
        anchors.fill: parent
        clip: true
        header: PageHeader {
                title: model.artistName
            }
        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlist.tracks.count > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: "Add all tracks to queue"
                enabled: model.tracksLoaded
                onClicked: model.addAllToQueue()
            }
            MenuItem {
                text: "Play all tracks"
                enabled: model.tracksLoaded
                onClicked: model.playAll()
            }
        }

        model: model.tracks

        section.property: "_albumId"
        section.delegate: JamDelegateAlbum {
                id: header
                property variant it: model.getAlbumById(section)
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
            visible: !model.tracksLoaded
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}
