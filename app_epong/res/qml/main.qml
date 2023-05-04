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
                    `onDestruction() ->bgrIndex=${bgrIndex}, mSettings.currentBgrIndex= ${mSettings.currentBgrIndex}`)
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
    Item {
        id: screen
        visible: true
        anchors.fill: parent

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
            text: "ver." + appVersion
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
        RoundPanel {
            id: menuPanel
            visible: false
            opacity: 0
            width: parent.width * 0.9
            height: parent.height * 0.9
            inlineContent: MenuButtons {
                id: menuButtons
                anchors.fill: parent

                Rectangle {
                    id: borderRectMenu
                    anchors.fill: parent
                    border {
                        color: "darkgray"
                        width: 2 * DevicePixelRatio
                    }
                    color: "transparent"
                    radius: 10 * DevicePixelRatio
                }
                onMenuCmd: {
                    AppSingleton.toLog(`Command ${cmd} recived`)
                    screen.state = "hide_menu"

                    switch (cmd) {
                    case Utils.MenuCmd.NewGame:
                        AppSingleton.toLog(`Command ${cmd} new game`)
                        break
                    case Utils.MenuCmd.NetworkGame:
                        break
                    case Utils.MenuCmd.Settings:
                        break
                    case Utils.MenuCmd.Records:
                        break
                    case Utils.MenuCmd.Rules:
                        break
                    default:
                        AppSingleton.toLog(`Command ${cmd} undefined`)
                    }
                }
            }
        }
        RoundPanel {
            id: rulesPanel
            visible: false
            width: parent.width * 0.9
            height: parent.height * 0.9
            inlineContent: Item {
                anchors.fill: parent

                Rectangle {
                    id: borderRectRules
                    anchors.fill: parent
                    border {
                        color: "darkgray"
                        width: 2 * DevicePixelRatio
                    }
                    color: "transparent"
                    radius: 10 * DevicePixelRatio
                }
            }
        }
        states: [
            State {
                name: "first_run"
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
                name: "hide_logo"
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
            },
            State {
                name: "show_menu"
                PropertyChanges {
                    target: menuPanel
                    visible: true
                }
                PropertyChanges {
                    target: menuPanel
                    opacity: 0.7
                }
            },
            State {
                name: "hide_menu"

                PropertyChanges {
                    target: menuPanel
                    visible: false
                }
                PropertyChanges {
                    target: menuPanel
                    opacity: 0
                }
            },
            State {
                name: "show_rules"
                PropertyChanges {
                    target: rulesPanel
                    opacity: 0.7
                }
                PropertyChanges {
                    target: rulesPanel
                    visible: true
                }
            }
        ]
        transitions: [
            Transition {
                to: "first_run"
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
                to: "hide_logo"
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
                }
            },
            Transition {
                to: "show_menu"
                SequentialAnimation {

                    NumberAnimation {
                        target: menuPanel
                        property: "visible"
                        duration: 0
                    }
                    NumberAnimation {
                        target: menuPanel
                        properties: "opacity"
                        duration: AppSingleton.timer2000
                        easing.type: Easing.Linear
                    }
                }
            },
            Transition {
                to: "hide_menu"
                SequentialAnimation {
                    NumberAnimation {
                        target: menuPanel
                        properties: "opacity"
                        duration: AppSingleton.timer1000
                        easing.type: Easing.Linear
                    }
                    NumberAnimation {
                        targets: [menuPanel]
                        property: "visible"
                        duration: 0
                    }
                }
            },
            Transition {
                from: "hide_logo"
                to: "show_menu"
                PauseAnimation {
                    duration: AppSingleton.timer1000
                }
            }
        ]
        Connections {
            target: logoItem
            function onTimeToDie() {
                screen.state = "hide_logo"
                screen.state = "show_menu"
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
