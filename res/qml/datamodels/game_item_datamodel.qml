import QtQuick 2.15

ListModel {
    id: root

    ListElement {
        item_type: 0
        pos_x: 0
        pos_y: 0
        size_h: 92 * DevicePixelRatio
        size_w: 24 * DevicePixelRatio
        img_src:"qrc:/res/images/left_pong.png"
        speed: 0
        angle: 0
        momentum: 0.0
        desc:"left pong"
        move_effect: false
        touch_effect:false
        collision_effect:false
    }


}
