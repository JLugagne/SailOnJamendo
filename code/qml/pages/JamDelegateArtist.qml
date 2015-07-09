import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

ListItem {
    id: item
    property string name
    property string image
    property int artist_id
    width: list.width
    contentHeight: 90
    Row {
        anchors.fill: parent
        spacing: Theme.paddingSmall
        Image {
            id: img
            height: 90
            width: 90
            source: item.image
            fillMode: Image.PreserveAspectFit
        }
        Label {
            anchors.verticalCenter: img.verticalCenter
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: item.name
        }
    }
    onClicked: {
        JamModel.getArtist(item.artist_id)
        pageStack.push(Qt.resolvedUrl("JamArtist.qml"))
    }
    /*menu: ContextMenu {
        MenuItem {
            text: "Play all"
            onClicked: JamModel.playAllArtist(item.artist_id)
        }
    }*/
}
