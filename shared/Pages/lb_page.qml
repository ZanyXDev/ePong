import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15

import Common 1.0
import Units 1.0

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

  RowLayout {
    id: rowTitleLayout

    anchors.top: parent.top
    visible: true
    spacing: 8 * DevicePixelRatio
    height: 72 * DevicePixelRatio
    Item {
      Layout.fillWidth: true
    }

    Image {
      id: awardImage
      Layout.preferredWidth: 64 * DevicePixelRatio
      Layout.preferredHeight: 64 * DevicePixelRatio
      Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft

      smooth: true
      fillMode: Image.PreserveAspectFit
      source: "qrc:/award.png"
      sourceSize: Qt.size(64 * DevicePixelRatio, 64 * DevicePixelRatio)
    }
    Item {
      Layout.fillWidth: true
    }
    QQC2.Label {
      id: awardLabel
      Layout.alignment: Qt.AlignCenter
      Layout.preferredHeight: 24
      Layout.fillWidth: true
      font {
        family: AppSingleton.gameFont.name
        pointSize: AppSingleton.largeFontSize
      }

      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      elide: Text.ElideRight
      text: qsTr("Most results players!")
    }
  }
  Rectangle {
    id: spacerFrame
    anchors {
      top: rowTitleLayout.bottom
      margins: 10 * DevicePixelRatio
    }

    border.color: "grey"

    visible: true
    height: 1 * DevicePixelRatio
    width: parent.width * 0.96
  }
  // ----- Qt provided non-visual children
}
