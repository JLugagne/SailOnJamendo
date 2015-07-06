import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

BackgroundItem {
    id: item
    property int trackDuration;
    property string trackName;
    property string trackUrl;
    property string albumImage;
    property string albumName;
    property string artistName;

    Row {
        spacing: Theme.paddingSmall
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: img
            source: (JamModel.jamModel.stream == item.trackUrl && !JamModel.jamModel.pause) ? "image://theme/icon-cover-pause" : "image://theme/icon-cover-play"
            height: 45
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(JamModel.jamModel.stream != item.trackUrl){
                        JamModel.jamModel.playlist = [item.trackUrl]
                        JamModel.jamPlaying.image = item.albumImage
                        JamModel.jamPlaying.album = item.albumName
                        JamModel.jamPlaying.artist = item.artistName
                    }else{
                        JamModel.jamModel.pause = !JamModel.jamModel.pause;
                    }
                }
            }
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: "("+JamModel.timeToString(item.trackDuration)+")"
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: item.trackName
        }
    }
}
