import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel

CoverBackground {
    Image {
        id:img
        fillMode: Image.PreserveAspectCrop
        source: JamModel.jamPlaying.image
        width: parent.width*0.8
        height: parent.width*0.8
        y: 15
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
            visible: JamModel.jamModel.playlistCount > 0
            text: (JamModel.jamPlaying.buffering != 100) ? "Buffering ("+JamModel.jamPlaying.buffering+"%)":  JamModel.timeToString(JamModel.jamPlaying.position)+"/"+JamModel.timeToString(JamModel.jamPlaying.duration)
            anchors.horizontalCenter: rect.horizontalCenter
            anchors.verticalCenter: rect.verticalCenter
            font.pixelSize: 25
            color: "white"
        }
    }
    Label {
        id: artist
        visible: JamModel.jamModel.playlistCount > 0
        anchors.top: img.bottom
        text: JamModel.jamPlaying.artist
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
    }
    Label {
        id: album
        visible: JamModel.jamModel.playlistCount > 0
        anchors.top: artist.bottom
        text: JamModel.jamPlaying.album
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 25
    }

    CoverActionList {
        id: coverAction1
        enabled: JamModel.jamModel.playlistCount == 1

        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1)
            iconSource: (JamModel.jamModel.pause) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: JamModel.jamModel.pause = !JamModel.jamModel.pause;
        }
    }

    CoverActionList {
        id: coverAction2
        enabled: JamModel.jamModel.playlistCount > 1
        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1)
            iconSource: (JamModel.jamModel.pause) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: JamModel.jamModel.pause = !JamModel.jamModel.pause;
        }

        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1 && JamModel.jamPlaying.playingId-1 != JamModel.jamPlaying.playlist.length)
            iconSource: "../images/icon-m-toolbar-mediacontrol-next.svg"
            onTriggered: JamModel.jamModel.nextTrack();
        }
    }
}


