.pragma library

const GameMode = {
    "Black": 0,
    "Blue": 1,
    "Red": 2
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
