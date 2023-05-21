import QtQuick 2.15
import AppEffects 1.0
import Common 1.0

Item {
  id: root
  property alias imageLogo: imgLogo.source

  signal timeToDie

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
  Timer {
    id: autoStartTimer
    interval: AppSingleton.timer2000
    repeat: false
    running: root.opacity > 0
    onTriggered: {
      root.timeToDie()
      autoStartTimer.stop()
    }
  }
  MouseArea {
    id: logoItemMouseArea
    anchors.fill: parent
    onClicked: {
      root.timeToDie()
      autoStartTimer.stop()
    }
  }
}
