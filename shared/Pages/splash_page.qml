import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import Common 1.0
import Units 1.0

QQC2.Page {
  id: root
  // ----- Property Declarations
  // Required properties should be at the top.
  readonly property bool pageActive: false //QQC2.SwipeView.isCurrentItem
  property bool pageInitialized: false

  // ----- Signal declarations
  signal showNextPage
  // ----- Size information
  // ----- Then comes the other properties. There's no predefined order to these.
  onPageActiveChanged: {
    AppSingleton.toLog(`SplashPage: [ onPageActiveChanged ${pageActive}]`)
    if (pageActive) {
      if (!pageInitialized) {
        pageInitialized = true
        state = "showState"
        AppSingleton.toLog(`SplashPage: [ state = "showState" ]`)
      } else {
        root.showNextPage()
        AppSingleton.toLog(`SplashPage: [ emit signal showNextPage()]`)
      }
    }
  }
  onVisibleChanged: {
    AppSingleton.toLog(`SplashPage.visible:[${root.visible}]`)
  }
  Component.onCompleted: {
    AppSingleton.toLog(
          `SplashPage: [ height:${root.height} , width: ${root.width}]`)
    for (var prop in root) {
      print(prop += " (" + typeof (root[prop]) + ") = " + root[prop])
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
      state = "hideState"
    }
  }

  states: [
    State {
      name: "showState"
      PropertyChanges {
        target: logoItem
        opacity: 1
      }
      PropertyChanges {
        target: appVerText
        opacity: 1
      }
      PropertyChanges {
        target: logoItem
        visible: true
      }
      PropertyChanges {
        target: appVerText
        visible: true
      }
    },
    State {
      name: "hideState"
      PropertyChanges {
        target: logoItem
        opacity: 0
      }
      PropertyChanges {
        target: appVerText
        opacity: 0
      }
      PropertyChanges {
        target: logoItem
        visible: false
      }
      PropertyChanges {
        target: appVerText
        visible: false
      }
    }
  ]

  transitions: [
    Transition {
      to: "showState"
      SequentialAnimation {
        NumberAnimation {
          targets: [logoItem, appVerText]
          property: "visible"
          duration: 0
        }
        NumberAnimation {
          targets: [logoItem, appVerText]
          properties: "opacity"
          duration: AppSingleton.timer2000
          easing.type: Easing.Linear
        }
      }
    },
    Transition {
      to: "hideState"
      SequentialAnimation {
        NumberAnimation {
          targets: [logoItem, appVerText]
          properties: "opacity"
          duration: AppSingleton.timer2000
          easing.type: Easing.Linear
        }
        NumberAnimation {
          targets: [logoItem, appVerText]
          property: "visible"
          duration: 0
        }
        ScriptAction {
          script: root.showNextPage()
        }
      }
    }
  ]
}
