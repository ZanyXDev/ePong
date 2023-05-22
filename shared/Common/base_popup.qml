import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15

import Common 1.0

QQC2.Popup {
  id: root

  property alias textMsg: txtLabel.text
  modal: true
  focus: true
  closePolicy: QQC2.Popup.CloseOnEscape | QQC2.Popup.CloseOnPressOutside
  anchors.centerIn: QQC2.Overlay.overlay

  background: Item {
    Rectangle {
      id: backCorner
      anchors.fill: parent
      border.color: Qt.rgba(0, 0, 0, 0.2)
      radius: 4 * DevicePixelRatio
      color: "darkgrey"
    }
    layer.enabled: true
    layer.effect: DropShadow {
      horizontalOffset: 3 * DevicePixelRatio
      verticalOffset: 4 * DevicePixelRatio
      radius: 4 * DevicePixelRatio
      samples: 30
      color: "#80000000"
      opacity: 0.75
    }
  }

  QQC2.Label {
    id: txtLabel
    anchors.fill: parent

    font {
      family: AppSingleton.baseFont.name
      pointSize: AppSingleton.averageFontSize
    }
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
  }
  enter: Transition {
    NumberAnimation {
      property: "opacity"
      from: 0.0
      to: 1.0
    }
  }
  exit: Transition {
    NumberAnimation {
      property: "opacity"
      from: 1.0
      to: 0.0
    }
  }
}
