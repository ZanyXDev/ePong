import QtQuick 2.15

Item {
    id: root
    property int animationDuration: 9000
    width: 30 * DevicePixelRatio
    height: 30 * DevicePixelRatio
    z: 5

    component ShineImage: Image {
        anchors.fill: parent
        source: "qrc:/shine.svg"
        smooth: true
        sourceSize {
            width: parent.width
            height: parent.height
        }
    }

    ShineImage {
        id: firstShine
        opacity: 0.8
    }

    ShineImage {
        id: secondShine
    }

    ParallelAnimation {
        running: root.visible
        RotationAnimator {
            target: firstShine
            to: 360
            duration: animationDuration
            loops: Animation.Infinite
        }
        RotationAnimator {
            target: secondShine
            to: -360
            duration: animationDuration / 2
            loops: Animation.Infinite
        }
        SequentialAnimation {
            loops: Animation.Infinite
            NumberAnimation {
                target: secondShine
                property: "opacity"
                to: 0.0
                duration: animationDuration / 8
            }
            NumberAnimation {
                target: secondShine
                property: "opacity"
                to: 1.0
                duration: animationDuration / 8
            }
        }
    }
}
