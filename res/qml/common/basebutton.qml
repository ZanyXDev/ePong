import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import common 1.0

QQC2.Button {
  id: root

  property color shadowColor: "black"

  font {
    family: AppSingleton.gameFont.name
    pointSize: AppSingleton.averageFontSize
  }

  layer.enabled: true
  layer.effect: DropShadow {

    horizontalOffset: 3
    verticalOffset: 4
    radius: 5 * DevicePixelRatio
    samples: 11
    color: root.shadowColor
    opacity: 0.75
  }

  state: pressed ? "buttonDown" : "buttonUp"

  states: [
    State {
      name: "buttonDown"
      PropertyChanges {
        target: root
        scale: 0.7
      }
    },
    State {
      name: "buttonUp"
      PropertyChanges {
        target: root
        scale: 1.0
      }
    }
  ]

  transitions: Transition {
    NumberAnimation {
      properties: scale
      easing.type: Easing.InOutQuad
      duration: AppSingleton.timer200
    }
  }
}
