import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

ListItem {
    id: item
    property string imgSource
    property string primaryDesc
    property string secondaryDesc
    property int album_id

    width: parent.width
    contentHeight: 90
    Image {
        id: img
        x: 5
        width: 90
        height: 90
        source: item.imgSource
        fillMode: Image.PreserveAspectFit
    }
    Label {
        anchors.left: img.right
        anchors.leftMargin: Theme.paddingSmall
        anchors.bottom: img.verticalCenter
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeMedium
        text: item.primaryDesc
    }
    Label {
        anchors.left: img.right
        anchors.leftMargin: Theme.paddingSmall
        anchors.top: img.verticalCenter
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        text: item.secondaryDesc
    }
    onClicked: { pageStack.push(Qt.resolvedUrl("../JamAlbum.qml"), {"albumId": item.album_id}) }
}
