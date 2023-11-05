import QtQuick 2.15

Image {
    id:root
    property int type_id: 0
    property bool isMoveFree: false

    fillMode: Image.PreserveAspectFit
    smooth:true

    ParallelAnimation {
        running: model.type_id === 1
        RotationAnimator {
            target: tst
            to: 360
            duration: animationDuration
            loops: Animation.Infinite
        }
    }
}
