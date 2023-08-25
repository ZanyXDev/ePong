import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2

import common 1.0
import datamodels 1.0

QQC2.Page {
  id: root

  // ----- Property Declarations
  // Required properties should be at the top.

  // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#a-note-about-accessing-attached-properties-and-signal-handlers
  property bool pageActive: false

  // ----- Signal declarations
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  onPageActiveChanged: {
    AppSingleton.toLog(`GamePage.onActivated pageActive ${pageActive}`)
    //gameTicTimer.restart()
  }

  // ----- Visual children.
  background: Rectangle {
    id:bgrRect
    anchors.fill: parent
    color: "transparent"
    border.color: "darkorange"
    border.width: 4 * DevicePixelRatio
  }

  Image {
    id: testImg

    x: BallData.m_x
    y: BallData.m_y

    fillMode: Image.PreserveAspectFit
    source: "qrc:/res/images/ball.png"
    sourceSize {
      width: 42 * DevicePixelRatio
      height: 42 * DevicePixelRatio
    }

    MouseArea {
      anchors.fill: parent
      onClicked: {
        gameTicTimer.restart()
      }
    }
  }

  // ----- Qt provided non-visual children
  Timer {
    id: gameTicTimer
    interval: AppSingleton.timer16
    repeat: true
    running: false
    onTriggered: {
      BallData.m_x+=200
      BallData.m_y +=2
    }
  }
}
