import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import Common 1.0
import Units 1.0

QQC2.Page {
  id: root

  // ----- Property Declarations
  // Required properties should be at the top.
  property bool firstRun: true
  // ----- Signal declarations
  signal showGameMenu
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  QQC2.StackView.onActivated: {
    AppSingleton.toLog(`InitPage.onActivated firstRun ${firstRun}`)
    if (firstRun) {
      showAnimation.start()
      firstRun = false
      autoStartTimer.start()
    } else {
      root.showGameMenu()
    }
  }

  // ----- Visual children.
  background: {
    null
  }

  LogoItem {
    id: logoItem
    width: parent.width * 0.8
    height: 126. / 346. * width
    imageLogo: "qrc:/res/images/epong_logo.svg"
    anchors {
      topMargin: 30 * DevicePixelRatio
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }
    opacity: 0
    z: 1
    visible: false
  }

  AppVersionTxt {
    id: appVerText
    text: "v. " + AppVersion
    color: "white"
    z: 1
    opacity: 0
    visible: false
    anchors {
      bottom: parent.bottom
      bottomMargin: 20 * DevicePixelRatio
      right: parent.right
      rightMargin: 20 * DevicePixelRatio
    }
  }

  // ----- Qt provided non-visual children
  Connections {
    target: logoItem
    function onTimeToDie() {
      if (autoStartTimer.running) {
        autoStartTimer.stop()
      }
      hideAnimation.start()
      AppSingleton.toLog(`InitPage.onTimeToDie`)
    }
  }

  Timer {
    id: autoStartTimer
    interval: AppSingleton.timer2000
    repeat: false
    running: false
    onTriggered: {
      AppSingleton.toLog(`autoStartTimer onTriggered`)
      autoStartTimer.stop()
      hideAnimation.start()
    }
  }
  SequentialAnimation {
    id: showAnimation
    PropertyAction {
      targets: [logoItem, appVerText]
      property: "visible"
      value: true
    }
    NumberAnimation {
      targets: [logoItem, appVerText]
      properties: "opacity"
      from: 0
      to: 1
      duration: AppSingleton.timer2000
      easing.type: Easing.Linear
    }
  }

  SequentialAnimation {
    id: hideAnimation
    NumberAnimation {
      targets: [logoItem, appVerText]
      properties: "opacity"
      from: 1
      to: 0
      duration: AppSingleton.timer2000
      easing.type: Easing.Linear
    }
    PropertyAction {
      targets: [logoItem, appVerText]
      property: "visible"
      value: false
    }
    ScriptAction {
      script: root.showGameMenu()
    }
  }
}
