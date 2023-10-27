import QtQuick 2.15

Item {
    id: root

    property real value: 5.0
    property real minimumValue: 0.0
    property real maximumValue: 10.0

     property alias pongHeight: pill.height

    Image{
    id:pill
    anchors.horizontalCenter: parent.horizontalCenter

    y: (value - minimumValue) / (maximumValue - minimumValue) * (root.height - pill.height) // pixels from value

    height: 92 * DevicePixelRatio
    fillMode: Image.PreserveAspectFit
    smooth: true
    source:"qrc:/res/images/left_pong.png"
    Component.onCompleted: {
        AppSingleton.toLog(
                    `pill[height,width]:[${pill.height
                    / DevicePixelRatio},${pill.width / DevicePixelRatio}]`)

    }
}


MouseArea {
    id: mouseArea

    anchors.fill: parent

    drag {
        target:   pill
        axis:     Drag.YAxis
        maximumY: root.height - pill.height
        minimumY: 0
    }

    onPositionChanged:  if(drag.active) setPixels(pill.y + 0.5 * pill.height) // drag pill
    onClicked:                          setPixels(mouse.y) // tap tray
}

function setPixels(pixels) {
    var value = (maximumValue - minimumValue) / (root.height - pill.height) * (pixels - pill.height / 2) + minimumValue // value from pixels

}
}
