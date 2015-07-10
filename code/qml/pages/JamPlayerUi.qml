import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel
Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
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
                width: parent.width-2*Theme.paddingMedium
            }
            Label {
                id: album
                visible: JamModel.jamModel.playlistCount > 0
                text: JamModel.jamModel.stream.album
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.secondaryColor
                width: parent.width-2*Theme.paddingMedium
            }
            Label {
                id: artist
                visible: JamModel.jamModel.playlistCount > 0
                text: JamModel.jamModel.stream.artist
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.secondaryColor
                width: parent.width-2*Theme.paddingMedium
            }
            Rectangle {
                width: parent.width/1.5
                anchors.horizontalCenter: parent.horizontalCenter
                height: column.width/8
                color: "transparent"
                Image {
                    visible: (JamModel.jamModel.playingId > 0 || JamModel.jamModel.repeat) && JamModel.jamModel.playlistCount > 1
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
                    visible: (JamModel.jamModel.playingId < JamModel.jamModel.playlistCount-1 || JamModel.jamModel.repeat)  && JamModel.jamModel.playlistCount > 1
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
            Rectangle {
                width: parent.width/1.5
                anchors.horizontalCenter: parent.horizontalCenter
                height: column.width/8
                color: "transparent"
                IconTextSwitch {
                    icon.source: "image://theme/icon-l-shuffle"
                    width: parent.height
                    height: width
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: Theme.paddingLarge
                    onCheckedChanged: if(checked){
                                          JamModel.jamModel.setShuffle();
                                      }else{
                                          JamModel.jamModel.shuffle = [];
                                      }
                }

                IconTextSwitch {
                    //visible: (JamModel.jamPlaying.playingId != -1 && JamModel.jamPlaying.playingId-1 != JamModel.jamPlaying.playlist.length)
                    icon.source: "image://theme/icon-l-repeat"
                    width: parent.height
                    height: width
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: Theme.paddingLarge
                    onCheckedChanged: JamModel.jamModel.repeat = checked;
                }
            }
        }
    }
}
