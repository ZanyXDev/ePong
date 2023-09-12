import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15

import common 1.0
import datamodels 1.0
import "qrc:/res/js/util.js" as Utils

Item {
  id: root
  property int pongTypes
  property int pongWidth: 0
  property int pongHeight: 0
  property int pongYpos: 0

  BaseObject {
    id: internal
    property int padYPosition: 0
    property bool isMovedEnable: false
  }

  Image {
    id: pongImg
    fillMode: Image.PreserveAspectFit
    source: root.pongTypes ? "qrc:/res/images/right_pong.png" : "qrc:/res/images/left_pong.png"
    sourceSize {
      width: pongWidth
      height: pongHeight
    }
    y: internal.padYPosition

    MouseArea {
      id: mouseArea
      anchors.fill: parent

      //hoverEnabled: true
      onPressAndHold: {
        internal.isMovedEnable = true
      }
      onReleased: {
        internal.isMovedEnable = false
      }
      onMouseYChanged: {
        var newPosY = mouseY - (pongImg.height / 2)
        newPosY = Math.min(newPosY, root.height - pongImg.height)
        if (internal.isMovedEnable) {
          internal.padYPosition = Math.max(0, newPosY)
        }
      }
    }
  }
}
