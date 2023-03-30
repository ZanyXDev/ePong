.pragma library

const MenuCmd = {
    "NewGame": 0,
    "NetworkGame": 1,
    "Settings": 2,
    "Records": 3,
    "Rules": 4
}
//console.log(`getYFromIndex ${index}  is [y:${y}] position`)
function calcRandomDuration(m_behavior_pause) {
    var rnd = 1 + Math.random() * 0.4 - 0.2
    return Math.floor(m_behavior_pause * rnd)
}

function getRandomBackGround() {
    var bgrStr = Math.floor(Math.random() * 20 + 1).toString()
    if (bgrStr.length === 1) {
        bgrStr = "0" + bgrStr
    }
    console.log(`qrc:/res/images/backgrounds/bgr${bgrStr}.jpg`)
    return "qrc:/res/images/backgrounds/bgr" + bgrStr + ".jpg"
}

function getNextBgrImage(index) {
    var bgrStr
    console.log(`index=${index}`)
    if ((index === undefined) || (index > 20) || (index < 0)) {
        index = 0
    }
    if (index < 10) {
        bgrStr = "0" + index
    } else {
        bgrStr = index
    }

    return "qrc:/res/images/backgrounds/bgr" + bgrStr + ".jpg"
}
