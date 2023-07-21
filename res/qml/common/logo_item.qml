import QtQuick 2.15
import effects.shine 1.0
import common 1.0

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

  MouseArea {
    id: logoItemMouseArea
    anchors.fill: parent
    onClicked: {
      root.timeToDie()
    }
  }
}
