import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15

import Common 1.0
import Units 1.0
import UsersListView 1.0

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
  ColumnLayout {
    id: mainPageLayout
    anchors.fill: parent
    spacing: 4 * DevicePixelRatio
    Item {
      Layout.fillWidth: true
      Layout.preferredHeight: 2 * DevicePixelRatio
    }
    Rectangle {
      id: titleRect

      Layout.leftMargin: 4 * DevicePixelRatio
      Layout.rightMargin: 4 * DevicePixelRatio
      Layout.preferredHeight: 72 * DevicePixelRatio
      Layout.preferredWidth: parent.width - (8 * DevicePixelRatio)

      radius: 4 * DevicePixelRatio
      color: "transparent"
      border.color: "darkgrey"
      RowLayout {
        id: rowTitleLayout
        anchors.fill: parent
        spacing: 8 * DevicePixelRatio
        Item {
          Layout.preferredWidth: 12 * DevicePixelRatio
        }
        Image {
          id: awardImage
          Layout.preferredWidth: 64 * DevicePixelRatio
          Layout.preferredHeight: 64 * DevicePixelRatio
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

          font {
            family: AppSingleton.gameFont.name
            pointSize: AppSingleton.largeFontSize
          }

          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
          text: qsTr("Most results players!")
        }
        Item {
          Layout.preferredWidth: 12 * DevicePixelRatio
        }
      }
    }
    QQC2.Frame {
      id: separatorItem
      Layout.fillWidth: true
      Layout.preferredHeight: 1 * DevicePixelRatio
    }
    UsersListVW {
      id: usersListview
      Layout.fillHeight: true
      Layout.leftMargin: 4 * DevicePixelRatio
      Layout.rightMargin: 4 * DevicePixelRatio
      Layout.preferredWidth: parent.width - (8 * DevicePixelRatio)
    }
    Item {
      Layout.fillWidth: true
      Layout.preferredHeight: 2 * DevicePixelRatio
    }
  }

  // ----- Qt provided non-visual children
}
