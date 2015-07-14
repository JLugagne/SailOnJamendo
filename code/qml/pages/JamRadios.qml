import QtQuick 2.0
import Sailfish.Silica 1.0

import "delegates"
import "models"

Page {
    id: page

    Component.onCompleted: radioModel.getRadios()

    JamModelRadio {
        id: radioModel
    }

    SilicaGridView {
        id: grid
        header: PageHeader {
            title: "Radios"
        }
        anchors.fill: parent
        model: radioModel.radios

        delegate: JamDelegateRadio {
            radioName: _radioName
            radioStream: _radioStream
            radioImage: _radioImage
        }

        BusyIndicator {
            id: busy
            anchors.centerIn: parent
            visible: !radioModel.loaded
            size: BusyIndicatorSize.Large
            running: visible
        }
    }
}
