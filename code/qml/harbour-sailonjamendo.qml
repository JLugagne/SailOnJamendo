import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour.sailonjamendo 1.0

import "pages"

import "js/jamdb.js" as JamDB
import "js/jamlib.js" as JamModel

ApplicationWindow
{
    JamNetwork {
        id: network
    }

    initialPage: Component { JamFeeds { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Rectangle {
        id: connectionRect
        anchors.fill: parent
        visible: !network.isOnline
        color: "black"
        opacity: 0.6
        MouseArea {
            anchors.fill: parent
        }
    }
    Text {
        anchors.fill: connectionRect
        visible: !network.isOnline
        text: "You are not connected to internet.\nThis application can't work."
        wrapMode: Text.WordWrap
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.primaryColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}


