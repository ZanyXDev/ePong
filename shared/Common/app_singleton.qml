pragma Singleton

import QtQuick 2.15

QtObject {
    id: root
    readonly property int largeFontSize: 36
    readonly property int middleFontSize: 24
    readonly property int smallFontSize: 12
    readonly property int tinyFontSize: 10

    property FontLoader gameFont: FontLoader {
        id: gameFont
        source: "qrc:/fonts/mailrays.ttf"
    }

    property FontLoader digitalFont: FontLoader {
        id: digitalFont
        source: "qrc:/fonts/681-font.otf"
    }
    //    property FontLoader aboutFont: FontLoader {
    //        id: aboutFont
    //        source: "qrc:/res/fonts/forgotte.ttf"
    //    }

    /* This is msecs. Half of second is enough for smooth animation. */
    readonly property int timer200: 200
    readonly property int timer500: 500
    readonly property int timer800: 800
    readonly property int timer1000: 1000
    readonly property int timer2000: 2000

    function toLogTrace(msg) {
        console.trace()
        toLog(`${msg}`)
    }

    function toLog(msg) {
        console.log(`${msg}`)
    }
}
