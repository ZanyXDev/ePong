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
    property real offset: 10
    anchors.fill: parent

    initialItem: InitPage {
      onLaunched: {
        stackView.push(page)
      }
    }

    /**
    pushEnter: Transition {
      id: pushEnter
      ParallelAnimation {
        PropertyAction {
          property: "x"
          value: pushEnter.ViewTransition.item.pos
        }
        NumberAnimation {
          properties: "y"
          from: pushEnter.ViewTransition.item.pos + stackView.offset
          to: pushEnter.ViewTransition.item.pos
          duration: 400
          easing.type: Easing.OutCubic
        }
        NumberAnimation {
          property: "opacity"
          from: 0
          to: 1
          duration: 400
          easing.type: Easing.OutCubic
        }
      }
    }
    popExit: Transition {
      id: popExit
      ParallelAnimation {
        PropertyAction {
          property: "x"
          value: popExit.ViewTransition.item.pos
        }
        NumberAnimation {
          properties: "y"
          from: popExit.ViewTransition.item.pos
          to: popExit.ViewTransition.item.pos + stackView.offset
          duration: 400
          easing.type: Easing.OutCubic
        }
        NumberAnimation {
          property: "opacity"
          from: 1
          to: 0
          duration: 400
          easing.type: Easing.OutCubic
        }
      }
    }
    pushExit: Transition {
      id: pushExit
      PropertyAction {
        property: "x"
        value: pushExit.ViewTransition.item.pos
      }
      PropertyAction {
        property: "y"
        value: pushExit.ViewTransition.item.pos
      }
    }
    popEnter: Transition {
      id: popEnter
      PropertyAction {
        property: "x"
        value: popEnter.ViewTransition.item.pos
      }
      PropertyAction {
        property: "y"
        value: popEnter.ViewTransition.item.pos
      }
    }
*/
  }

  //  ----- non visual children

  // ----- Custom non-visual children
  Settings {
    id: mSettings
    category: "BackgroundItem"
    property int currentBgrIndex
  }

  // ----- JavaScript functions
}
