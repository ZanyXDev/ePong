import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2

import Common 1.0
import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    signal menuCmd(int cmd)

    //    anchors {
    //        topMargin: 20 * DevicePixelRatio
    //        horizontalCenter: parent.horizontalCenter
    //        verticalCenter: parent.verticalCenter
    //    }
    AnimatedImage {
        id: demoPong
        anchors.fill: parent
        source: "qrc:/res/images/demo_pong.gif"
    }
    ColumnLayout {
        id: mainMenuLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        component CmdBtn: BaseButton {
            property int cmd_id
            Layout.preferredWidth: 110 * DevicePixelRatio
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                root.menuCmd(cmd_id)
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 26 * DevicePixelRatio
        }
        CmdBtn {
            id: newGameBtn
            cmd_id: Utils.MenuCmd.NewGame
            text: qsTr("New game")
        }
        CmdBtn {
            id: newNetGameBtn
            enabled: true
            cmd_id: Utils.MenuCmd.NetworkGame
            text: qsTr("Network game")
        }
        CmdBtn {
            id: settingsBtn
            cmd_id: Utils.MenuCmd.Settings
            text: qsTr("Settings")
        }
        CmdBtn {
            id: recordsBtn
            cmd_id: Utils.MenuCmd.Records
            text: qsTr("Records")
        }
        CmdBtn {
            id: helpBtn
            cmd_id: Utils.MenuCmd.Rules
            text: qsTr("Rules")
        }
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * DevicePixelRatio
        }
    }
}
