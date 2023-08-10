import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15
import Qt.labs.settings 1.0

import common 1.0
import pages 1.0
import effects.shine 1.0

import "qrc:/res/js/util.js" as Utils
import io.github.zanyxdev.epong.hal 1.0

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
  width: (screenOrientation === Qt.PortraitOrientation) ? 320 * DevicePixelRatio : 480
                                                          * DevicePixelRatio
  height: (screenOrientation === Qt.PortraitOrientation) ? 480 * DevicePixelRatio : 320
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
    if (isDebugMode) {
      console.trace()
      AppSingleton.toLog(`onScreenOrientationChanged:[${screenOrientation}]`)
    }
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
  QQC2.SwipeView {
    id: swipeView
    interactive: false
    anchors.fill: parent

    InitPage {
      id: initPage
      onShowPage: {
        if (isDebugMode) {
          console.log()
          AppSingleton.toLog(`Utils.PagesId.MenuPage=${Utils.PagesId.MenuPage}`)
          AppSingleton.toLog(`swipeView.currentIndex=${swipeView.currentIndex}`)
          AppSingleton.toLog(`swipeView.count=${swipeView.count}`)
        }
        gotoPage(pageId)
      }
    }
    MenuPage {
      id: menuPage
      onShowPage: {
        gotoPage(pageId)
      }
    }
  }

  //  ----- non visual children
  Settings {
    id: mSettings
    category: "BackgroundItem"
    property int currentBgrIndex
  }

  // ----- JavaScript functions
  function gotoPage(pageIndex) {
    if (pageIndex === swipeView.currentIndex) {
      // it's the current page
      return
    }

    if (pageIndex > swipeView.count || pageIndex < 0) {
      return
    }
    swipeView.setCurrentIndex(pageIndex)
  }
}
