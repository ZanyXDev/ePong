import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.0

import common 1.0
import "qrc:/res/js/util.js" as Utils

QQC2.Page {
  id: root
  // ----- Property Declarations
  // Required properties should be at the top.
  property alias demoPaused: demoPong.paused
  readonly property bool pageActive: QQC2.SwipeView.isCurrentItem
  // ----- Signal declarations
  signal showPage(int pageId)
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  onPageActiveChanged: {
    AppSingleton.toLog(`MenuPage.onActivated`)
  }

  // ----- Visual children.
  background: AnimatedImage {
    id: demoPong
    paused: popup.visible
    anchors.fill: parent
    source: "qrc:/res/images/demo_pong.gif"
  }

  QQC2.Popup {
    id: popup
    property alias textMsg: txtLabel.text
    closePolicy: QQC2.Popup.CloseOnEscape | QQC2.Popup.CloseOnPressOutsideParent
    modal: true
    anchors.centerIn: QQC2.Overlay.overlay
    background: Rectangle {
      border.color: Qt.rgba(0, 0, 0, 0.2)
      color: "darkgrey"
      radius: 6 * DevicePixelRatio
      layer.enabled: true
      layer.effect: DropShadow {
        horizontalOffset: 3
        verticalOffset: 4
        radius: 5 * DevicePixelRatio
        samples: 11
        color: "grey"
        opacity: 0.75
      }
    }
    contentItem: QQC2.Label {
      id: txtLabel
      font {
        family: AppSingleton.baseFont.name
        pointSize: AppSingleton.middleFontSize
      }
      elide: Text.ElideRight
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter
      text: qsTr("<center>Don't work now.<br/> Sorry ...</center>")
    }
    enter: Transition {
      NumberAnimation {
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: AppSingleton.timer500
      }
    }
    exit: Transition {
      NumberAnimation {
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: AppSingleton.timer500
      }
    }
  }

  ColumnLayout {
    id: mainMenuLayout
    anchors.fill: parent
    spacing: 2 * DevicePixelRatio

    component CmdBtn: BaseButton {
      property int page_id
      property bool underDevelopment: false
      Layout.preferredWidth: 110 * DevicePixelRatio
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
      onClicked: {
        if (!underDevelopment) {
          root.showPage(page_id)
        } else {
          if (isDebugMode) {
            console.trace()
            AppSingleton.toLog(`Pages is now development. Show popup()`)
            popup.open()
          }
        }
      }
    }

    Item {
      Layout.fillWidth: true
      Layout.preferredHeight: 26 * DevicePixelRatio
    }
    CmdBtn {
      id: newGameBtn
      page_id: Utils.PagesId.NewGame
      text: qsTr("New game")
    }
    CmdBtn {
      id: newNetGameBtn
      enabled: true
      page_id: Utils.PagesId.NetworkGame
      underDevelopment: true
      text: qsTr("Network game")
    }
    CmdBtn {
      id: settingsBtn
      page_id: Utils.PagesId.Settings
      text: qsTr("Settings")
    }
    CmdBtn {
      id: leaderBoradsBtn
      page_id: Utils.PagesId.LeaderBoards
      text: qsTr("LeaderBoards")
    }
    CmdBtn {
      id: helpBtn
      page_id: Utils.PagesId.Rules
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
  // ----- Qt provided non-visual children
  Timer {
    id: autoHideTimer
    interval: AppSingleton.timer1000
    repeat: false
    running: popup.visible
    onTriggered: {
      AppSingleton.toLog(`autoHideTimer onTriggered`)
      autoHideTimer.stop()
      popup.close()
    }
  }
}
