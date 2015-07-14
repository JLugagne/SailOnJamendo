import QtQuick 2.0
import Sailfish.Silica 1.0

import "delegates"
import "models"

import "../js/jamlib.js" as JamModel

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
                title: "Queue"
            }

        model: JamModel.jamModel.playlist.tracks

        section.property: "_albumId"
        section.delegate: JamDelegateAlbum {
                id: header
                JamModelAlbum {
                    id: alb
                    albumId: parseInt(section)
                }
                Component.onCompleted: alb.getAlbum()

                imgSource: alb.albumImage
                primaryDesc: alb.albumName
                secondaryDesc: alb.artistName
                album_id: alb.albumId
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
