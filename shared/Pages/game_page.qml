import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import Common 1.0
import Units 1.0

QQC2.Page {
  id: root

  // ----- Property Declarations
  // Required properties should be at the top.
  property bool running: false
  // ----- Signal declarations
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  QQC2.StackView.onActivated: {
    AppSingleton.toLog(`GamePage.onActivated. state running ${running}`)
    if (running) {
    } else {
    }
  }

  // ----- Visual children.
  background: {
    null
  }

  // ----- Qt provided non-visual children

  Timer {
    id: gameTicTimer
    interval: AppSingleton.timer2000
    repeat: false
    running: false
    onTriggered: {

    }
  }

}
