import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/jamlib.js" as JamModel

Page {
    id: page
    onStatusChanged: if(status == PageStatus.Active) JamModel.jamModel.search = []

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            PullDownMenu {
                MenuItem {
                    enabled: JamModel.jamModel.playlistCount > 0
                    text: qsTr("Player")
                    onClicked: pageStack.push(Qt.resolvedUrl("JamPlayerUi.qml"))

                }
            }

            PageHeader {
                title: "Search"
            }

            TextField {
                id: searchFor
                width: parent.width
                placeholderText: "Looking for"
                label: "Looking for"
            }

            ComboBox {
                id: searchIn
                width: parent.width
                label: "Looking in"
                menu: ContextMenu {
                    MenuItem { text: "Albums" }
                    MenuItem { text: "Artists" }
                    MenuItem { text: "Tracks" }
                }
            }
            Button {
                text: "Search"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    JamModel.getSearchFor(searchFor.text, searchIn.currentItem.text.toLowerCase(), 0);
                    pageStack.push(Qt.resolvedUrl("JamSearchResults.qml"))
                }
            }
        }
    }
}
