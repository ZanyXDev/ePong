import QtQuick 2.15
import Common 1.0

Rectangle {
    id: root

    anchors {
        topMargin: 20 * DevicePixelRatio
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    border {
        color: "darkgray"
        width: 2 * DevicePixelRatio
    }
    radius: 10 * DevicePixelRatio
    smooth: true

    AnimatedImage {
        id: demoPong
        anchors.fill: parent
        source: "qrc:/res/images/demo_pong.gif"
    }    
        
}
