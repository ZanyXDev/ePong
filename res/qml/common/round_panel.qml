import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import common 1.0
import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    property Component inlineContent: ContentItem {}
    property bool rounded: true
    property bool adapt: true

    component ContentItem: Item {}

    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }

    smooth: true

    opacity: 0.8

    layer.enabled: root.rounded
    layer.effect: OpacityMask {
        maskSource: Item {
            width: background.width
            height: background.height
            Rectangle {

                width: root.adapt ? background.width : Math.min(
                                        background.width, background.height)
                height: root.adapt ? background.height : width
                radius: 10 * DevicePixelRatio
            }
        }
    }
    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: inlineContent
    }
}
