import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2

import common 1.0
import "qrc:/res/js/util.js" as Utils

QQC2.Page {
  id: root
  // ----- Property Declarations
  // Required properties should be at the top.
  property alias demoPaused: demoPong.paused
  readonly property bool pageActive: QQC2.SwipeView.isCurrentItem
  // ----- Signal declarations
  signal menuCmd(int cmd)
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  onPageActiveChanged: {
    AppSingleton.toLog(`MenuPage.onActivated`)
  }

  // ----- Visual children.
  background: AnimatedImage {
    id: demoPong
    anchors.fill: parent
    source: "qrc:/res/images/demo_pong.gif"
  }

  ColumnLayout {

    id: mainMenuLayout
    anchors.fill: parent
    spacing: 2 * DevicePixelRatio

    component CmdBtn: BaseButton {
      property int cmd_id
      Layout.preferredWidth: 110 * DevicePixelRatio
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
      onClicked: {
        root.menuCmd(cmd_id)
      }
    }

    Item {
      Layout.fillWidth: true
      Layout.preferredHeight: 26 * DevicePixelRatio
    }
    CmdBtn {
      id: newGameBtn
      cmd_id: Utils.MenuCmd.NewGame
      text: qsTr("New game")
    }
    CmdBtn {
      id: newNetGameBtn
      enabled: true
      cmd_id: Utils.MenuCmd.NetworkGame
      text: qsTr("Network game")
    }
    CmdBtn {
      id: settingsBtn
      cmd_id: Utils.MenuCmd.Settings
      text: qsTr("Settings")
    }
    CmdBtn {
      id: leaderBoradsBtn
      cmd_id: Utils.MenuCmd.LeaderBoards
      text: qsTr("LeaderBoards")
    }
    CmdBtn {
      id: helpBtn
      cmd_id: Utils.MenuCmd.Rules
      text: qsTr("Rules")
    }
    Item {
      Layout.fillWidth: true
      Layout.preferredHeight: 2 * DevicePixelRatio
    }
    Component.onCompleted: {
      AppSingleton.toLog(`MenuPage mainMenuLayout completed`)
    }
  }
}
