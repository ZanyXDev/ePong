import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import common 1.0

import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    // Value between 0 (0%) and 1 (100%)
    property real value: 0.1
    property bool __batteryLow: root.value <= 0.2

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
        id: bgrNoiseImage
        smooth: true
        fillMode: Image.PreserveAspectFit
        z: -1
        visible: false
        source: "qrc:/res/images/noise/bgr_noise_image.png"
        sourceSize {
            height: root.height
            width: root.width
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
    }
}
