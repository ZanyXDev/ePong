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
        gameTicTimer.start()
    }

    //-------------
    Item {
        ///TODO separate item
        id: bgrRect
        anchors.fill: parent
        property int itemWidth: 98 * DevicePixelRatio
        Repeater {
            id: exampleRepeater
            model: itemsModel
            delegate: Image {
                ///TODO base item for Pong (left,right) and Ball
                id:tst
                property int type_id: model.type_id
                property int animationDuration: 9000
                fillMode: Image.PreserveAspectFit
                smooth:true
                source: model.src
                x: model.pos_x * DevicePixelRatio
                y: model.pos_y * DevicePixelRatio
                sourceSize {
                    width: model.size_hw * DevicePixelRatio
                    height: model.size_hw * DevicePixelRatio
                }

                RotationAnimator {
                    target: tst
                    to: 360
                    duration: animationDuration
                    loops: Animation.Infinite
                    running: model.type_id === 1
                }

            }
        }

    }

    //-------------
    // ----- Qt provided non-visual children
    ListModel{
        id:itemsModel
        ListElement{
            type_id:1
            src: "qrc:/res/images/ball_in_yan.png"
            pos_x: 10
            pos_y: 10
            size_hw: 32
            speed: 1.0
            angle: 10.5
            desc: "ball"
        }
    }

    Timer {
        id: gameTicTimer
        interval: AppSingleton.timer16
        repeat: true
        running: false
        onTriggered: {
            //Logic.updateWord(BallData)
            itemsModel.get(0).pos_x += 1
            //itemsModel.setProperty(1, "pos_x", pos_x + 2)
        }
    }


}
