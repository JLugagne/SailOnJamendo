import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

BackgroundItem {
    id: item
    property string imgSource
    property string primaryDesc
    property string secondaryDesc
    property int album_id

    width: list.width
    height: 90
    Image {
        id: img
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
    MouseArea {
        anchors.fill: parent
        onClicked: { JamModel.getAlbum(item.album_id); pageStack.push(Qt.resolvedUrl("JamAlbum.qml")) }
    }
}
