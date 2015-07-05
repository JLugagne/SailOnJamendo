import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel

Page {
    id: page
    SilicaFlickable {
        width: parent.width
        contentHeight: column.height
        Column {
            id: column
            width: parent.width
            PageHeader {
                title: JamModel.jamModel.selectedFeed.title.en
            }
            Text {
                id: text
                text: JamModel.jamModel.selectedFeed.text.en
                wrapMode: Text.WordWrap
                color: Theme.primaryColor
                width: parent.width - 2*Theme.paddingLarge
                horizontalAlignment: Text.AlignJustify
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
