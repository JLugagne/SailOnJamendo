import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

ListItem {
    property string radioName
    property string radioStream
    property string radioImage

    width: img.width
    height: img.height
    Image {
        id: img
        width: page.width/2
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: radioImage
        onSourceSizeChanged: if(status == Image.Ready && (grid.cellHeight != height || grid.cellWidth != width)) { height = sourceSize.height*(width/sourceSize.width); grid.cellHeight = height; grid.cellWidth = width; }
        Rectangle {
            id: rect
            color: "black"
            opacity: 0.7
            anchors.bottom: parent.bottom
            height: 30
            width: parent.width
        }

        Label {
            x: Theme.paddingLarge
            text: radioName
            anchors.horizontalCenter: rect.horizontalCenter
            anchors.verticalCenter: rect.verticalCenter
            font.bold: true
            font.pixelSize: 25
            color: "white"
        }

        Image {
            visible: JamModel.jamModel.playlist.currentTrack !== undefined && JamModel.jamModel.playlist.currentTrack !== null && JamModel.jamModel.playlist.currentTrack._trackUrl == radioStream
            source: "image://theme/icon-cover-play"
            anchors.centerIn: parent
            width: parent.width/2
            height: parent.height/2
        }
    }

    onClicked: {
        JamModel.jamModel.playlist.setPlaylist([{
                                "_trackName": radioName,
                                "_trackUrl": radioStream,
                                "_trackDuration": 0,
                                "_albumId": -1,
                                "_albumImage": radioImage,
                                "_artistName": "Radio",
                                "_albumName": "Radio"
                            }]);
    }
}
