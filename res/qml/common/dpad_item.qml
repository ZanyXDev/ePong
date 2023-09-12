import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import common 1.0

import "qrc:/res/js/util.js" as Utils

Item {
    id: root

    signal clicked(int btnId)
    signal pressed(int btnId)

    component IButton: ImageButton {
        height: 36 * DevicePixelRatio
        width: 36 * DevicePixelRatio
        onClicked: {
            root.clicked(buttonId)
        }
        onPressed: {
            root.clicked(buttonId)
        }
    }
    IButton {
        id: btnUp
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        buttonId: Utils.DPadButton.Up
    }
    IButton {
        id: btnRight
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        buttonId: Utils.DPadButton.Right
    }
    IButton {
        id: btnLeft
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        buttonId: Utils.DPadButton.Left
    }
    IButton {
        id: btnDown
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        buttonId: Utils.DPadButton.Down
    }
}
