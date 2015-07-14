import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

ListItem {
    id: item
    property string artistName
    property string artistImage
    property int artistId
    width: list.width
    contentHeight: 90
    Row {
        anchors.fill: parent
        spacing: Theme.paddingSmall
        Image {
            id: img
            x: 5
            height: 90
            width: 90
            source: artistImage
            fillMode: Image.PreserveAspectFit
        }
        Label {
            anchors.verticalCenter: img.verticalCenter
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeMedium
            text: artistName
        }
    }
    onClicked: {
        pageStack.push(Qt.resolvedUrl("../JamArtist.qml"), {"artistId": artistId})
    }
}
