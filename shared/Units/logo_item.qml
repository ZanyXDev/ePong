import QtQuick 2.15
import AppEffects 1.0
import Common 1.0

Item {
    id: root
    property alias imageLogo: imgLogo.source

    Image {
        id: imgLogo
        sourceSize {
            width: root.width
            height: root.height
        }
        Shine {
            anchors {
                leftMargin: 10 * DevicePixelRatio
                topMargin: 10 * DevicePixelRatio
            }
        }
    }
    visible: opacity > 0

    Behavior on opacity {
        NumberAnimation {
            duration: AppSingleton.timer1000
            easing.type: Easing.InQuad
        }
    }
}
