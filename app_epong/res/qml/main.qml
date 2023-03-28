import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15
import Qt.labs.settings 1.0

import Common 1.0
import Units 1.0

import "qrc:/res/js/util.js" as Utils

QQC2.ApplicationWindow {
    id: appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation
    readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
    readonly property real winScale: Math.min(width / 1280.0, height / 720.0)
    property bool appInitialized: false
    property int bgrIndex

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
    onClosing: {
        bgrIndex++
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
            MouseArea {
                id: logoItemMouseArea
                anchors.fill: parent
                onClicked: {
                    logoItem.timeToDie()
                }
            }
        }
        AppVersionTxt {
            id: appVerText
            text: "ver." + appVersion
            color: "white"
            z: 1
            opacity: 0
            anchors {
                bottom: parent.bottom
                bottomMargin: 20 * DevicePixelRatio
                right: parent.right
                rightMargin: 20 * DevicePixelRatio
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
            },

            State {
                name: "show_menu"
                PropertyChanges {
                    target: logoItem
                    opacity: 0
                }
                PropertyChanges {
                    target: appVerText
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "first_run"
                to: "*"
                NumberAnimation {
                    targets: [logoItem, appVerText]
                    properties: "opacity"
                    to: 0
                    duration: AppSingleton.timer2000
                    easing.type: Easing.OutCubic
                }
            }
        ]
        Connections {
            target: logoItem
            function onTimeToDie() {
                screen.state = "show_menu"
            }
        }
    }
    //  ----- non visual children

    // ----- Custom non-visual children
    Settings {
        id: mSettings
        category: "BackgroundItem"
        property alias currentBgrIndex: appWnd.bgrIndex
    }

    // ----- JavaScript functions
}
