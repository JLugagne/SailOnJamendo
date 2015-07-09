import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "About"
            }

            Text {
                width: parent.width-2*Theme.paddingLarge
                text: "This software is distributed under the BSD license. That means you can get sources and modify them as much as you want. They are available on github.com under the name \"SailOnJamendo\"."
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                horizontalAlignment: Text.AlignJustify
            }

            Text {
                width: parent.width-2*Theme.paddingLarge
                text: "The software is base on the Jamendo's API v3.0."
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                horizontalAlignment: Text.AlignJustify
            }
        }
    }
}
