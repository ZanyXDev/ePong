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

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "white"
        }
        GradientStop {
            position: 1.0
            color: "gainsboro"
        }
    }
}
