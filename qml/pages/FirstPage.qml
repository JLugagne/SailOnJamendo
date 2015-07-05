import QtQuick 2.0
import Sailfish.Silica 1.0

import "../js/jamlib.js" as JamModel

Page {
    id: page
    JamPlayer {
        id: player
    }

    onVisibleChanged: if(visible && list.count == 0) { JamModel.updateFeeds(); }

    anchors.fill: parent

    SilicaListView {
        id: list

        PullDownMenu {
            MenuItem {
                text: qsTr("Radios")
                onClicked: pageStack.push(Qt.resolvedUrl("JamRadios.qml"))
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("JamSearch.qml"))
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: { JamModel.jamModel.feeds = []; JamModel.updateFeeds(); }

            }
        }

        PushUpMenu {
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Switch {
                    iconSource: "image://theme/icon-l-shuffle"
                    onClicked: console.log("Switch 1 " + checked)
                }
                Switch {
                    iconSource: "image://theme/icon-l-repeat"
                    onClicked: console.log("Switch 2 " + checked)
                }
            }
        }

        //width: page.width
        anchors.fill: parent
        //spacing: Theme.paddingLarge
        header: PageHeader {
            title: qsTr("Feeds")
        }
        model: JamModel.jamModel.feeds
        delegate: BackgroundItem {
            width: list.width
            height: img.height
            Image {
                id: img
                width: parent.width
                source: JamModel.jamModel.feeds[index].images.size315_111

                Rectangle {
                    id: rect
                    color: "black"
                    opacity: 0.7
                    anchors.bottom: parent.bottom
                    height: 25
                    width: parent.width
                }

                Label {
                    x: Theme.paddingLarge
                    text: JamModel.jamModel.feeds[index].subtitle.en
                    anchors.horizontalCenter: rect.horizontalCenter
                    anchors.verticalCenter: rect.verticalCenter
                    font.bold: true
                    font.pixelSize: 20
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { JamModel.getFeed(JamModel.jamModel.feeds[index].id);  pageStack.push(Qt.resolvedUrl("JamFeed.qml")); }
                }
            }
        }


        BusyIndicator {
            id: busy
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: parent.count == 0
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}


