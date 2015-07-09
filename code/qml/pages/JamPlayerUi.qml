import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel
Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Player")
                onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

            }
        }
        width: parent.width
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingSmall

            PageHeader {
                title: "Player"
            }

            Image {
                id:img
                fillMode: Image.PreserveAspectFit
                source: JamModel.jamModel.stream.image
                width: parent.width*0.8
                height: width
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: rect
                    visible: JamModel.jamModel.playlistCount > 0
                    color: "black"
                    opacity: 0.7
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    width: parent.width
                }

                Label {
                    text: (JamModel.jamPlaying.buffering != 100) ? "Buffering ("+JamModel.jamPlaying.buffering+"%)":  JamModel.timeToString(JamModel.jamPlaying.position)+"/"+JamModel.timeToString(JamModel.jamModel.stream.duration)
                    anchors.horizontalCenter: rect.horizontalCenter
                    anchors.verticalCenter: rect.verticalCenter
                    font.pixelSize: 25
                    color: "white"
                }
            }

            Label {
                id: track
                visible: JamModel.jamModel.playlistCount > 0
                text: JamModel.jamModel.stream.name
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeHuge
                color: Theme.primaryColor
            }
            Label {
                id: album
                visible: JamModel.jamModel.playlistCount > 0
                text: JamModel.jamModel.stream.album
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.secondaryColor
            }
            Label {
                id: artist
                visible: JamModel.jamModel.playlistCount > 0
                text: JamModel.jamModel.stream.artist
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.secondaryColor
            }
            Rectangle {
                width: parent.width
                height: column.width/8
                color: "transparent"
                Image {
                    //visible: (JamModel.jamPlaying.playingId != -1 && JamModel.jamPlaying.playingId-1 != JamModel.jamPlaying.playlist.length)
                    fillMode: Image.PreserveAspectFit
                    source: "../images/icon-m-toolbar-mediacontrol-previous.svg"
                    width: parent.height
                    height: width
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    MouseArea {
                        anchors.fill: parent
                        onClicked: JamModel.jamModel.previousTrack();
                    }
                }

                Image {
                    //visible: (JamModel.jamPlaying.playingId != -1)
                    source: (JamModel.jamModel.pause) ? "../images/icon-m-toolbar-mediacontrol-play.svg" : "../images/icon-m-toolbar-mediacontrol-pause.svg"
                    fillMode: Image.PreserveAspectFit
                    width: parent.height
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: JamModel.jamModel.pause = !JamModel.jamModel.pause;
                    }
                }

                Image {
                    //visible: (JamModel.jamPlaying.playingId != -1 && JamModel.jamPlaying.playingId-1 != JamModel.jamPlaying.playlist.length)
                    fillMode: Image.PreserveAspectFit
                    source: "../images/icon-m-toolbar-mediacontrol-next.svg"
                    width: parent.height
                    height: width
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    MouseArea {
                        anchors.fill: parent
                        onClicked: JamModel.jamModel.nextTrack();
                    }
                }
            }
        }
    }
}
