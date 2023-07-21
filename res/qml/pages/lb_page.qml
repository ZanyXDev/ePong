import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import common 1.0

QQC2.Page {
  id: root

  // ----- Property Declarations
  // Required properties should be at the top.

  // ----- Signal declarations
  signal stepBack
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  QQC2.StackView.onActivated: {
    AppSingleton.toLog(`LeaderBoardPage.onActivated`)
  }

  // ----- Visual children.
  background: {
    null
  }

  // ----- Qt provided non-visual children
}
