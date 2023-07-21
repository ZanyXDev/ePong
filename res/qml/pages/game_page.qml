import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import common 1.0

QQC2.Page {
  id: root

  // ----- Property Declarations
  // Required properties should be at the top.
  property bool running: false
  // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#a-note-about-accessing-attached-properties-and-signal-handlers
  property QQC2.StackView stack: QQC2.StackView.view
  // ----- Signal declarations
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  QQC2.StackView.onActivated: {
    AppSingleton.toLog(
          `GamePage.onActivated. state running ${running}, stack ${stack}`)

    if (running) {

    } else {

    }
  }

  // ----- Visual children.
  background: {
    null
  }
  QQC2.Button {
    id: test
    text: "Back"
    onClicked: {
      AppSingleton.toLog(`GamePage.depth ${stack.depth}`)
      stack.pop()
      AppSingleton.toLog(`GamePage.depth after pop ${stack.depth}`)
    }
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
