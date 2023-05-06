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
  property int bgrIndex: mSettings.currentBgrIndex

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
    AppSingleton.toLog(
          `onDestruction()->bgrIndex=${bgrIndex}, mSettings.currentBgrIndex= ${mSettings.currentBgrIndex}`)
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
    source: Utils.getNextBgrImage(bgrIndex)
    fillMode: Image.PreserveAspectCrop
  }

  // ----- Visual children
  QQC2.SwipeView {
    id: swipeView
    anchors.fill: parent
    interactive: (isDebugMode) ? true : false

    onCurrentIndexChanged: {
      AppSingleton.toLog(`SwipeView.currentIndex: [${swipeView.currentIndex}]`)
    }

    SplashPage {
      id: splashPage
    }

    Rectangle {
      id: debugRect
      border.color: "#ff0000"
      color: "#ffffff"
      opacity: 0.8
      visible: true
    }
    Component.onCompleted: {
      AppSingleton.toLog(`SwipeView.interactive: [${swipeView.interactive} ]`)
    }
    Connections {
      target: splashPage
      function onShowNextPage() {
        swipeView.incrementCurrentIndex()
        AppSingleton.toLog(
              `swipeView: [ recive signal showNextPage()] do increment page`)
      }
    }
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
