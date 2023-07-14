import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Common 1.0
import "qrc:/res/js/util.js" as Utils

Rectangle {
    id: test
    property string rulesTxt: " <h1 align='center'>ePong Rules</h1>
<p > Pong’s interface consists of  two paddles and a ball.</p>
<p> The ball deflects off the paddle upon impact.</p>
<p> You need to obtain 11 points when your opponent misses the ball to win.</p1>
<p> Additionally, the game can either be played by two people or one against a computer-controlled paddle. </p>
<h2>For feedback, or to report issues:</h2>
<p>please visit [github.com/ZanyXDev/ePong/issues](https://github.com/ZanyXDev/ePong/issues)</p>
<p>or send email <zanyxdev@gmail.com></p>
"
    anchors {
        //topMargin: 5 * DevicePixelRatio
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    border {
        color: "darkgray"
        width: 2 * DevicePixelRatio
    }
    radius: 10 * DevicePixelRatio
    smooth: true
    color: "black"
    opacity: 0.7

    ScrollView {
        id: scrollArea
        clip: true
        anchors {
            margins: 10 * DevicePixelRatio
            fill: parent
        }
        contentWidth: parent.width
        contentHeight: text1.height
        Text {
            id: text1
            text: rulesTxt
            anchors {
                margins: 5 * DevicePixelRatio
                fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            color: "grey"
            font {
                family: AppSingleton.baseFont.name
                pointSize: AppSingleton.averageFontSize
            }
        }
    }
}

/**
    property string exampleTextLong: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.

Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.

It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.

It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
"




Rectangle {
    id: test

    anchors {
        topMargin: 5 * DevicePixelRatio
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    border {
        color: "darkgray"
        width: 2 * DevicePixelRatio
    }
    radius: 10 * DevicePixelRatio
    smooth: true
    color: "black"
    opacity: 0.7

    Text {
        Layout.fillWidth: true
        Layout.fillHeight: true
        font {
            family: AppSingleton.baseFont.name
            pointSize: AppSingleton.averageFontSize
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        textFormat: Text.MarkdownText
        color: "grey"

        text: "#ePong Rules#
---
Pong’s interface consists of **two paddles** and a **ball**.
> The ball deflects off the paddle upon impact.
> You need to obtain **11 points** when your opponent misses the ball to **win**.
> Additionally, the game can either be played by *two people* or *one against a computer-controlled paddle*.
---
For feedback, or to report issues:

please visit [github.com/ZanyXDev/ePong/issues](https://github.com/ZanyXDev/ePong/issues)
or send email <zanyxdev@gmail.com>"
        onLinkActivated: Qt.openUrlExternally(link)

        // Since Text (and Label) lack cursor-changing abilities of their own,
        // as suggested by QTBUG-30804, use a MouseAra to do our dirty work.
        // See comment https://bugreports.qt.io/browse/QTBUG-30804?#comment-206287
        // TODO: Once HoverHandler and friends are able to change cursor shapes, this will want changing to that method
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
        }
    }
}
*/

