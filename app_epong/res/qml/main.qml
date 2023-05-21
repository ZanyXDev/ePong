import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15
import Qt.labs.settings 1.0

import Common 1.0
import Units 1.0
import Pages 1.0

import "qrc:/res/js/util.js" as Utils

QQC2.ApplicationWindow {
  id: appWnd
  // ----- Property Declarations

  // Required properties should be at the top.
  readonly property int screenOrientation: Screen.orientation
  readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
  readonly property real winScale: Math.min(width / 1280.0, height / 720.0)
  property bool appInitialized: false

  // ----- Signal declarations
  signal screenOrientationUpdated(int screenOrientation)

  // ----- Size information
  width: (screenOrientation == Qt.PortraitOrientation) ? 320 * DevicePixelRatio : 480
                                                         * DevicePixelRatio
  height: (screenOrientation == Qt.PortraitOrientation) ? 480 * DevicePixelRatio : 320
                                                          * DevicePixelRatio
  maximumHeight: height
  maximumWidth: width

  minimumHeight: height
  minimumWidth: width
  // ----- Then comes the other properties. There's no predefined order to these.
  visible: true
  visibility: (isMobile) ? Window.FullScreen : Window.Windowed
  flags: Qt.Dialog
  title: qsTr(" ")
  Screen.orientationUpdateMask: Qt.LandscapeOrientation

  // ----- Then attached properties and attached signal handlers.

  // ----- Signal handlers
  onScreenOrientationChanged: {
    screenOrientationUpdated(screenOrientation)
    if (isDebugMode)
      AppSingleton.toLogTrace(
            `onScreenOrientationChanged:[${screenOrientation}]`)
  }
  Component.onDestruction: {
    var bgrIndex = mSettings.currentBgrIndex
    bgrIndex++
    mSettings.currentBgrIndex = (bgrIndex < 20) ? bgrIndex : 0
  }
  onAppInForegroundChanged: {
    if (appInForeground) {
      if (!appInitialized) {
        appInitialized = true
        screen.state = "first_run"
      }
    } else {
      if (isDebugMode)
        AppSingleton.toLog(
              `appInForeground: [${appInForeground} , appInitialized: ${appInitialized}]`)
    }
  }

  background: Image {
    id: background
    anchors.fill: parent
    source: Utils.getNextBgrImage(mSettings.currentBgrIndex)
    fillMode: Image.PreserveAspectCrop
  }

  // ----- Visual children
  QQC2.StackView {
    id: stackView
    anchors.fill: parent

    initialItem: InitPage {
      onShowGameMenu: {
        stackView.push(menuPage)
      }
    }
    pushEnter: pushEnterTransition
    popEnter: popEnterTransition
    popExit: popExitTransition
  }

  Component {
    id: menuPage
    MenuButtons {

      onMenuCmd: {

        switch (cmd) {
        case Utils.MenuCmd.NewGame:
          stackView.pop()
          break
        case Utils.MenuCmd.NetworkGame:

          break
        default:
          AppSingleton.toLog(`Recive cmd ${cmd}`)
          break
        }
      }
    }
  }
  //  ----- non visual children
  Transition {
    id: pushEnterTransition
    ParallelAnimation {
      PropertyAnimation {
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutCubic
      }
      XAnimator {
        from: (stackView.mirrored ? -1 : 1) * -stackView.width
        to: 0
        duration: 400
        easing.type: Easing.OutCubic
      }
    }
  }

  Transition {
    id: popEnterTransition
    XAnimator {
      from: (stackView.mirrored ? -1 : 1) * -stackView.width
      to: 0
      duration: 400
      easing.type: Easing.OutCubic
    }
  }

  Transition {
    id: popExitTransition
    XAnimator {
      from: 0
      to: (stackView.mirrored ? -1 : 1) * stackView.width
      duration: 400
      easing.type: Easing.OutCubic
    }
  }

  // ----- Custom non-visual children
  Settings {
    id: mSettings
    category: "BackgroundItem"
    property int currentBgrIndex
  }

  // ----- JavaScript functions
}
