import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Common 1.0
import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    property Component inlineContent: ContentItem {}

    component ContentItem: Item {}

    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: background
        anchors.fill: parent
        border {
            color: "darkgray"
            width: 2 * DevicePixelRatio
        }

        radius: 10 * DevicePixelRatio
        smooth: true
        color: "black"
        opacity: 0.7
    }

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: inlineContent
    }
}
