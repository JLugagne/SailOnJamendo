import QtQuick 2.0
import Sailfish.Silica 1.0


import "../js/jamlib.js" as JamModel
import "../js/jamdb.js" as JamDB

Page {
    id: page
    JamPlayer {
        id: player
    }

    Binding {
        target: player
        property: "pauseState"
        value: JamModel.jamModel.pause
        when: player.isPlayingState == JamModel.jamModel.pause
    }
    onStatusChanged: if(status == PageStatus.Active) JamDB.updateAlbums();
    onVisibleChanged: if(visible && list.count == 0) { JamModel.updateFeeds(); }

    SilicaListView {
        id: list

        PullDownMenu {
            MenuItem {
                enabled: JamModel.jamModel.playlistCount > 0
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
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("JamSettings.qml"))

            }
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

        model: JamDB.jamDB.lastAlbum

        delegate: JamDelegateAlbum {
                id: thisItem
                ListView.onRemove: animateRemoval(thisItem)
                imgSource: modelData.albumImage
                primaryDesc: modelData.albumTitle
                secondaryDesc: modelData.albumArtist
                album_id: modelData.albumId
                menu: ContextMenu {
                    id: ctxMenu
                    property int albumId
                    MenuItem {
                        text: "Forget it"
                        onClicked: { thisItem.remorseAction("Forget "+modelData.albumTitle, function() { JamDB.forgetAlbum(modelData.albumId); }) }
                    }
                }
            }


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


