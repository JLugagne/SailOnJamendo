import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

import "delegates"
import "models"

Page {
    id: page
    property alias albumId: albModel.albumId

    onStatusChanged: column.scrollToTop();

    Component.onCompleted: albModel.getAlbum();

    JamModelAlbum {
        id: albModel
    }

    SilicaListView {
        id: column
        anchors.fill: parent

        model: albModel.tracks

        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlist.tracks.count > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: qsTr("Go to artist")
                enabled: albModel.loaded
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("JamArtist.qml"),{"artistId": albModel.artistId});
                }
            }
            MenuItem {
                text: qsTr("Add the album to queue")
                enabled: albModel.loaded
                onClicked: albModel.addAlbumToQueue()
            }
            MenuItem {
                text: qsTr("Play the album")
                enabled: albModel.loaded
                onClicked: albModel.playAlbum()
            }
        }
        header: Column {
                width: page.width
                PageHeader {
                    title: albModel.albumName
                }
                Label {
                    text: albModel.artistName
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                }
                Label {
                    text: albModel.albumName
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                }
                Image {
                    width: parent.width*0.75
                    asynchronous: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: albModel.albumImage
                    onSourceSizeChanged: if(status == Image.Ready) { height = sourceSize.height*(width/sourceSize.width); }
                }
            }

        delegate: JamDelegateTrack {
            anchors.margins: Theme.paddingMedium
            trackDuration: _trackDuration
            trackName: _trackName
            trackUrl: _trackUrl
            albumImage: albModel.albumImage
            albumName: albModel.albumName
            albumId: albModel.albumId
            artistName: albModel.artistName
        }

        BusyIndicator {
            id: busy
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !albModel.loaded
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}
