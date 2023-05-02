import QtQuick 2.15

QQC2.Page {
    id: root
    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool pageActive: QQC2.SwipeView.isCurrentItem
    property bool pageInitialized: false
    property bool isAnimationEnable: false

    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        if (pageActive) {
            if (!pageInitialized) {
                pageInitialized = true
                if (isAnimationEnable) {
                    pageAnimation.start()
                }
            }
        }
    }
    Component.onCompleted: {    
    }

    // ----- Visual children.       
   
    
    background: {
        null
    }
       
    // ----- Qt provided non-visual children
        
    SequentialAnimation {
        id: pageAnimation
        running: false
    }
}
