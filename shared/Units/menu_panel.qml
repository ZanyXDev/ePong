import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2

import Common 1.0

Rectangle {
    id: root
    anchors {
        topMargin: 20 * DevicePixelRatio
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    border {
        color: "darkgray"
        width: 2 * DevicePixelRatio
    }
    radius: 10 * DevicePixelRatio
    smooth: true

    AnimatedImage {
        id: demoPong
        anchors.fill: parent
        source: "qrc:/res/images/demo_pong.gif"
    }

    ColumnLayout {
        id: mainMenuLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 26 * DevicePixelRatio
        }
        BaseButton {
            id: newGameBtn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: qsTr("New game")
        }
        BaseButton {
            id: newNetGameBtn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: qsTr("Network game")
        }
        BaseButton {
            id: settingsBtn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: qsTr("Settings")
        }
        BaseButton {
            id: recordsBtn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: qsTr("Records")
        }
        BaseButton {
            id: helpBtn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: qsTr("Rules")
        }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * DevicePixelRatio
        }
    }
}
