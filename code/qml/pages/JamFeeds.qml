import QtQuick 2.0
import Sailfish.Silica 1.0

import "delegates"
import "models"

import "../js/jamlib.js" as JamModel
import "../js/jamdb.js" as JamDB

Page {
    id: page
    JamPlayer {
        id: player
        onSourceChanged: lastPlayedAlbums.trackChanged()
    }

    Binding {
        target: player
        property: "pauseState"
        value: JamModel.jamModel.pause
        when: player.isPlayingState == JamModel.jamModel.pause
    }

    Component.onCompleted: lastPlayedAlbums.update()
    JamModelLastPlayed {
        id: lastPlayedAlbums
    }

    SilicaListView {
        id: list

        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlist.tracks.count > 0
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
            MenuItem {
                text: qsTr("Radios")
                onClicked: pageStack.push(Qt.resolvedUrl("JamRadios.qml"))
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("JamSearch.qml"))
            }
        }
        PushUpMenu {
            MenuItem {
                text: qsTr("Clear all")
                enabled: lastPlayedAlbums.albums.count
                onClicked: lastPlayedAlbums.clearAll();

            }
            /*MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("JamSettings.qml"))

            }*/
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("JamAbout.qml"))

            }
        }

        anchors.fill: parent
        spacing: Theme.paddingMedium
        header: PageHeader {
            title: qsTr("Last played")
        }

        model: lastPlayedAlbums.albums

        delegate: JamDelegateAlbum {
                id: thisItem
                ListView.onRemove: animateRemoval(thisItem)
                imgSource: albumImage
                primaryDesc: albumTitle
                secondaryDesc: albumArtist
                album_id: albumId

                JamModelAlbum {
                    id: itemAlbum
                    albumId: thisItem.album_id
                }

                menu: ContextMenu {
                    id: ctxMenu
                    property int albumId
                    MenuItem {
                        text: "Play the album"
                        onClicked: { itemAlbum.callback = itemAlbum.playAlbum; itemAlbum.getAlbum(); }
                    }
                    MenuItem {
                        text: "Add album to queue"
                        onClicked: { itemAlbum.callback = itemAlbum.addAlbumToQueue; itemAlbum.getAlbum(); }
                    }
                    MenuItem {
                        text: "Forget it"
                        onClicked: { thisItem.remorseAction("Forget "+albumTitle, function() { lastPlayedAlbums.forgetAlbum(albumId); }) }
                    }
                }
            }


        BusyIndicator {
            id: busy
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !lastPlayedAlbums.albumsUpdated
            size: BusyIndicatorSize.Large
            running: visible
        }
        Text {
            visible: lastPlayedAlbums.albumsUpdated && list.count == 0
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor
            anchors.centerIn: parent
            text: "Nothing to show"
        }
    }
}


