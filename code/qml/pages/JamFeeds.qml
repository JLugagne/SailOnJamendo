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
            MenuItem {
                text: qsTr("Refresh")
                onClicked: { JamModel.jamModel.feeds = []; JamModel.updateFeeds(); }

            }
        }
/*
        PushUpMenu {
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Switch {
                    iconSource: "image://theme/icon-l-shuffle"
                    onClicked: console.log("Switch 1 " + checked)
                }
                Switch {
                    iconSource: "image://theme/icon-l-repeat"
                    onClicked: console.log("Switch 2 " + checked)
                }
            }
        }
*/
        //width: page.width
        anchors.fill: parent
        spacing: Theme.paddingMedium
        header: PageHeader {
            title: qsTr("Last played")
        }
        model: JamDB.jamDB.lastAlbum
        delegate: JamDelegateAlbum {
            imgSource: modelData.albumImage
            primaryDesc: modelData.albumTitle
            secondaryDesc: modelData.albumArtist
            album_id: modelData.albumId
        }

        /*BackgroundItem {
            width: list.width
            height: img.height
            Image {
                id: img
                width: parent.width
                source: JamModel.jamModel.feeds[index].images.size315_111
                fillMode: Image.PreserveAspectFit
                onSourceSizeChanged: if(status == Image.Ready) { height = sourceSize.height*(width/sourceSize.width); }

                Rectangle {
                    id: rect
                    color: "black"
                    opacity: 0.7
                    anchors.bottom: parent.bottom
                    height: 45
                    width: parent.width
                }

                Label {
                    x: Theme.paddingLarge
                    text: JamModel.jamModel.feeds[index].subtitle.en
                    anchors.horizontalCenter: rect.horizontalCenter
                    anchors.verticalCenter: rect.verticalCenter
                    font.bold: true
                    font.pixelSize: 35
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { JamModel.getFeed(JamModel.jamModel.feeds[index].id);  pageStack.push(Qt.resolvedUrl("JamFeed.qml")); }
                }
            }
        }*/


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


