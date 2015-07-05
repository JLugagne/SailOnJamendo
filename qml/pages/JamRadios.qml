import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../js/jamlib.js" as JamModel

Page {
    id: page
    SilicaFlickable {
        onVisibleChanged: if(visible) JamModel.updateListRadios()
        anchors.fill: parent

        SilicaGridView {
            id: grid
            header: PageHeader {
                title: "Radios"
            }
            VerticalScrollDecorator {}
            anchors.fill: parent
            VerticalScrollDecorator {}
            model: JamModel.jamModel.radios

            delegate: BackgroundItem {
                width: img.width
                height: img.height
                Image {
                    id: img
                    width: page.width/3
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    source: modelData.image
                    onSourceSizeChanged: if(status == Image.Ready && (grid.cellHeight != height || grid.cellWidth != width)) { height = sourceSize.height*(width/sourceSize.width); grid.cellHeight = height; grid.cellWidth = width; }
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
                        text: modelData.dispname
                        anchors.horizontalCenter: rect.horizontalCenter
                        anchors.verticalCenter: rect.verticalCenter
                        font.bold: true
                        font.pixelSize: 20
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            JamModel.jamPlaying.image = modelData.image
                            JamModel.jamPlaying.album = modelData.dispname
                            JamModel.jamPlaying.artist = "Radio"
                            JamModel.updatePlayRadio(modelData.name)
                        }
                    }
                }
            }
        }
    }
}
