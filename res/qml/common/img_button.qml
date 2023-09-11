import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.0

import common 1.0
import "qrc:/res/js/util.js" as Utils

Item {
    id: root
    property alias buttonId: imgBtn.m_type


    /**
      * @var Qt::MouseButtons acceptedButtons
      * This property holds the mouse buttons that the mouse area reacts to.
      * See <a href="https://doc.qt.io/qt-5/qml-qtquick-mousearea.html#acceptedButtons-prop">Qt documentation</a>.
      */
    property alias acceptedButtons: mArea.acceptedButtons


    /**
      * @var mouseArea Mouse area element covering the button.
      */
    property alias mouseArea: mArea


    /** This property Enables accessibility of QML items.
      * See <a href="https://doc.qt.io/qt-5/qml-qtquick-accessible.html">Qt documentation</a>.
      */
    Accessible.role: Accessible.Button
    Accessible.name: qsTr("Image Button")
    Accessible.onPressAction: root.clicked(null)

    property bool isActive: root.enabled && mArea.containsMouse
    property int buttonWidth: 48 * DevicePixelRatio
    property int buttonHeight: root.buttonWidth

    signal pressed(int btnId)
    signal clicked(int btnId)
    signal hoverChanged

    Image {
        id: imgBtn

        property int m_type: -1
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: Utils.getButtonsImage(m_type)
        sourceSize {
            height: buttonHeight
            width: buttonWidth
        }
        layer.enabled: true
        layer.effect: DropShadow {
            anchors.fill: control
            horizontalOffset: 3
            verticalOffset: 4
            radius: 5
            samples: 11
            color: "black"
            opacity: 0.75
        }
        MouseArea {
            id: mArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: isActive ? Qt.PointingHandCursor : Qt.ArrowCursor

            onClicked: root.clicked(mouse)
            onPressed: root.pressed(mouse)
            onHoveredChanged: root.hoverChanged()
        }
    }
}
