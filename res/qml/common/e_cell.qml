import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import QtQuick.Particles 2.15

import common 1.0

import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    // Value between 0 (0%) and 1 (100%)
    property real value: 0.1

    BaseObject {
        id: internal
        property real smoothedValue: value
        property bool capacityTen: root.value <= 0.1
        property bool capacityTwenty: root.value <= 0.2
        property bool capacityThirty: root.value <= 0.3

        Behavior on smoothedValue {
            SmoothedAnimation {
                velocity: 0.1
                duration: AppSingleton.timer1000
            }
        }
    }

    Image {
        id: batteryImage

        smooth: true
        source: "qrc:/res/images/battery2.png"
        fillMode: Image.PreserveAspectFit
        height: root.height
        width: root.width
        sourceSize {
            height: root.height
            width: root.width
        }
        Image {
            id: bgrNoiseImage
            anchors.fill: parent
            anchors.topMargin: 24 * DevicePixelRatio
            smooth: true
            fillMode: Image.Stretch
            z: -1
            visible: true
            source: "qrc:/res/images/noise/bgr_noise_image.png"
            sourceSize {
                height: root.height
                width: root.width
            }
        }
    }
    ParticleSystem {
        anchors.fill: parent
        anchors.margins: 24 * DevicePixelRatio
        // renders a tiny image
        ImageParticle {
            source: "qrc:/res/images/particle/p_item.png"
        }

        // emit particle object with a size of 20 pixels
        Emitter {
            anchors.fill: parent
            size: 20
        }
    }
}
