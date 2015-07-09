import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel
import "../js/jamdb.js" as JamDB

ListItem {
    id: item
    property int trackDuration: 0;
    property string trackName;
    property string trackUrl;
    property string albumId;
    property string albumImage;
    property string albumName;
    property string artistName;

    Row {
        spacing: Theme.paddingSmall
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: img
            source: (JamModel.jamModel.stream.url == item.trackUrl && !JamModel.jamModel.pause) ? "image://theme/icon-cover-pause" : "image://theme/icon-cover-play"
            height: 45
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            visible: item.trackDuration > 0
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(JamModel.jamModel.stream.url != item.trackUrl){
                        JamModel.jamModel.playlist = [{
                                                          "url":item.trackUrl,
                                                          "albumId":item.albumId,
                                                          "image":item.albumImage,
                                                          "artist":item.artistName,
                                                          "name":item.trackName,
                                                          "album":item.albumName,
                                                          "duration":item.trackDuration
                                                      }]
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
            visible: item.trackDuration > 0
            text: "("+JamModel.timeToString(item.trackDuration)+")"
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: item.trackName
        }
    }
}
