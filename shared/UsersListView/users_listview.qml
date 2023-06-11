import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2

import Common 1.0
import Units 1.0

ListView {
  id: root
  property bool darkTheme: false
  clip: true
  focus: true
  boundsBehavior: Flickable.StopAtBounds
  snapMode: ListView.SnapToItem

  model: dataModel

  delegate: Item {
    height: root.height
    width: root.width / 2
    anchors.left: root.contentItem.horizontalCenter

    Column {
      spacing: 15 * DevicePixelRatio
      anchors.verticalCenter: parent.verticalCenter

      Image {
        anchors.horizontalCenter: parent.horizontalCenter
        source: qsTr("qrc:/UsersListView/images/avatar%1-%2.png").arg(
                  model.gender).arg(root.darkTheme ? "dark" : "light")
      }

      Text {
        text: model.name
        anchors.horizontalCenter: parent.horizontalCenter
        font {
          family: AppSingleton.baseFont.name
          pointSize: AppSingleton.middleFontSize
          bold: true
        }
        color: "grey"
      }

      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: date + " " + time
        font {
          family: AppSingleton.baseFont.name
          pointSize: AppSingleton.largeFontSize
          italic: true
        }
        color: "darkgrey"
      }
    }
  }

  Component.onCompleted: {
    populateData(dataModel)
  }

  ListModel {
    id: dataModel
  }
  function populateData(listData) {
    listData.append({
                      "name": "John Doe",
                      "gender": "m",
                      "date": "02/15/2017",
                      "time": "09:20 am"
                    })

    listData.append({
                      "name": "Jane Worldege",
                      "gender": "f",
                      "date": "02/06/2017",
                      "time": "10:15 am"
                    })

    listData.append({
                      "name": "Jennifer Wang",
                      "gender": "f",
                      "date": "02/03/2017",
                      "time": "05:16 pm"
                    })
  }
}
