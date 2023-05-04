import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2

Item{
    id: root
    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive: false
    property bool pageInitialized: false
    property bool pageAnimation: false

    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        if (pageActive) {
            if (!pageInitialized) {
                pageInitialized = true
                if (pageAnimation) {
                    pageItemAnimation.start()
                }
            }
        }
    }
    Component.onCompleted: {

    }

    // ----- Visual children.


    // ----- Qt provided non-visual children
    SequentialAnimation {
        id: pageItemAnimation
        running: false
    }
}
