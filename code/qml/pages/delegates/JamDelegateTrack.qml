import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel
import "../../js/jamdb.js" as JamDB

ListItem {
    id: item
    property int trackDuration: 0;
    property string trackName;
    property string trackUrl;
    property string albumId;
    property string albumImage;
    property string albumName;
    property string artistName;

    property bool isCurrentTrack: JamModel.jamModel.playlist.currentTrack !== undefined && JamModel.jamModel.playlist.currentTrack._trackUrl == item.trackUrl

    Row {
        spacing: Theme.paddingSmall
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: img
            source: (item.isCurrentTrack && !JamModel.jamModel.pause) ? "image://theme/icon-cover-pause" : "image://theme/icon-cover-play"
            height: 45
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            visible: item.trackDuration > 0
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!item.isCurrentTrack){
                        JamModel.jamModel.playlist.setPlaylist([{
                                                          "_trackUrl":item.trackUrl,
                                                          "_albumId":parseInt(item.albumId),
                                                          "_albumImage":item.albumImage,
                                                          "_artistName":item.artistName,
                                                          "_trackName":item.trackName,
                                                          "_albumName":item.albumName,
                                                          "_trackDuration":item.trackDuration.toString()
                                                      }]);
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
