import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15

import common 1.0
import datamodels 1.0
import "qrc:/res/js/logic.js" as Logic
import "qrc:/res/js/util.js" as Utils

QQC2.Page {
    id: root

    // ----- Property Declarations
    // Required properties should be at the top.

    // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#a-note-about-accessing-attached-properties-and-signal-handlers
    property bool pageActive: false

    // ----- Signal declarations
    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        AppSingleton.toLog(`GamePage.onActivated pageActive ${pageActive}`)
        //gameTicTimer.restart()
    }
    // ----- Visual children.
    background: {
        null
    }
    Component.onCompleted: {
        AppSingleton.toLog(`GamePage [${root.height}h,${root.width}w]`)
    }
    //-------------
    Item {
        id: bgrRect
        anchors.fill: parent

        RowLayout {
            id: mainGamePageLayout
            anchors.fill: parent

            spacing: 2 * DevicePixelRatio
            ColumnLayout {
                id: speedBarBtnLayout
                Layout.fillHeight: true
                Layout.preferredWidth: 90 * DevicePixelRatio
                spacing: 2 * DevicePixelRatio
                Item {
                    id: topSpace
                    Layout.fillHeight: true
                }

                Rectangle {
                    id: speedBarRect
                    Layout.preferredHeight: 250 * DevicePixelRatio
                    Layout.preferredWidth: 92 * DevicePixelRatio
                    color: "red"
                    Text {
                        text: `[${speedBarRect.height
                              / DevicePixelRatio}h,${speedBarRect.width / DevicePixelRatio}w]`
                    }
                }
                Dpads {
                    id: dpadsItem
                    Layout.preferredHeight: 66 * DevicePixelRatio
                    Layout.preferredWidth: 92 * DevicePixelRatio
                    onClicked: {
                        AppSingleton.toLog(`dpadsItem.clicked[${btnId}]`)
                    }
                }
                Item {
                    id: bottomSpace
                    //Layout.preferredHeight: 2 * DevicePixelRatio
                    Layout.fillHeight: true
                }
            }
        }
    }


    /**
            ColumnLayout {
                id: speedBarBtnLayout
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 2 * DevicePixelRatio

                Rectangle {
                    id: btnRect
                    Layout.preferredHeight: 128 * DevicePixelRatio
                    Layout.preferredWidth: 36 * DevicePixelRatio
                    color: "green"
                }
            }
            Item {
                id: leftSpace
                Layout.fillHeight: true
                Layout.preferredWidth: 2 * DevicePixelRatio
            }
            PongPad {
                Layout.fillHeight: true
                Layout.preferredWidth: 26 * DevicePixelRatio
                pongTypes: Utils.PongType.Right

                pongWidth: 24 * DevicePixelRatio
                pongHeight: 36 * DevicePixelRatio
            }
            Item {
                id: leftPongPlace
                Layout.fillHeight: true
                Layout.preferredWidth: 26 * DevicePixelRatio
                property bool mouseOnThePad: false
                Image {
                    id: leftPongImg
                    property point beginDrag
                    x: LeftPongData.m_x
                    y: LeftPongData.m_y
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/res/images/left_pong.png"
                    sourceSize {
                        width: 24 * DevicePixelRatio
                        height: 36 * DevicePixelRatio
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onMouseYChanged: {
                        var newPos = mouseY - leftPongImg.height / 2
                        newPos = Math.min(newPos, height - leftPongImg.height)
                        LeftPongData.m_y = Math.max(0, newPos)
                        //leftPongImg.y = Qt.binding(function() { return Math.max(0, newPos)})
                        if (isDebugMode) {
                            AppSingleton.toLog(
                                        `newPos[${newPos}], leftPongImg.y[${leftPongImg.y}]`)
                        }
                    }
                }
            }
        */

    //-------------
    // ----- Qt provided non-visual children
    Timer {
        id: gameTicTimer
        interval: AppSingleton.timer16
        repeat: true
        running: false
        onTriggered: {
            Logic.updateWord(BallData)
        }
    }
}
