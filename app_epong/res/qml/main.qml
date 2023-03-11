import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15

import Common 1.0
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
            console.log("onScreenOrientationChanged [" + screenOrientation + "]")
    }
    onClosing: {

    } //appCore.uninitialize()
    onAppInForegroundChanged: {
        if (appInForeground) {
            if (!appInitialized) {
                appInitialized = true
            }
        } else {
            if (isDebugMode)
                console.log("onAppInForegroundChanged-> [appInForeground:"
                            + appInForeground + ", appInitialized:" + appInitialized + "]")
        }
    }

    background: Image {
        id: background
        anchors.fill: parent
        source: Utils.getRandomBackGround()

        fillMode: Image.PreserveAspectCrop

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.OutElastic
                easing.amplitude: 3.0
                easing.period: 2.0
                duration: 300
            }
        }
    }

    // ----- Visual children
    //  ----- non visual children
    // ----- Custom non-visual children
    Timer {
        id: autoChangeBackgroundTimer
        interval: 1000 /// TODO move to settings!
        repeat: true
        running: true
        onTriggered: {
            background.opacity = 0.1
            background.source = Utils.getRandomBackGround()
            background.opacity = 0.9
        }
    }

    // ----- JavaScript functions
}
