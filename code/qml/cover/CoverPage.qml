import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel

CoverBackground {
    Image {
        id:img
        fillMode: Image.PreserveAspectCrop
        source: (JamModel.jamModel.playlist.tracks.count > 0 && JamModel.jamModel.playlist.currentTrack !== undefined) ? JamModel.jamModel.playlist.currentTrack._albumImage : "../images/icon.svg";
        width: parent.width*0.85
        height: parent.width*0.85
        y: 10
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
            visible: JamModel.jamModel.playlist.currentTrack !== undefined && JamModel.jamModel.playlist.tracks.count > 0
            text: (JamModel.jamModel.buffering != 100) ? "Buffering ("+JamModel.jamModel.buffering+"%)" : JamModel.timeToString(JamModel.jamModel.position)+"/"+JamModel.timeToString(JamModel.jamModel.playlist.currentTrack._trackDuration)
            anchors.horizontalCenter: rect.horizontalCenter
            anchors.verticalCenter: rect.verticalCenter
            font.pixelSize: 25
            color: "white"
        }
    }

    Label {
        id: artist
        visible: JamModel.jamModel.playlist.tracks.count > 0
        anchors.top: img.bottom
        text: (JamModel.jamModel.playlist.tracks.count > 0 && JamModel.jamModel.playlist.currentTrack !== undefined) ? JamModel.jamModel.playlist.currentTrack._trackName : ""
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
    }
    Label {
        id: album
        visible: JamModel.jamModel.playlist.tracks.count > 0
        anchors.top: artist.bottom
        text: (JamModel.jamModel.playlist.tracks.count > 0 && JamModel.jamModel.playlist.currentTrack !== undefined) ? JamModel.jamModel.playlist.currentTrack._artistName : ""
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 25
    }

    CoverActionList {
        id: coverAction1
        enabled: !JamModel.jamModel.playlist.hasNextTrack()

        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1)
            iconSource: (JamModel.jamModel.pause) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: JamModel.jamModel.pause = !JamModel.jamModel.pause;
        }
    }

    CoverActionList {
        id: coverAction2
        enabled: !coverAction1.enabled
        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1)
            iconSource: (JamModel.jamModel.pause) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: JamModel.jamModel.pause = !JamModel.jamModel.pause;
        }

        CoverAction {
            //visible: (JamModel.jamPlaying.playingId != -1 && JamModel.jamPlaying.playingId-1 != JamModel.jamPlaying.playlist.length)
            iconSource: "../images/icon-m-toolbar-mediacontrol-next.svg"
            onTriggered: JamModel.jamModel.playlist.nextTrack();
        }
    }
}


