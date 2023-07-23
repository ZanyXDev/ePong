.pragma library

const PagesId = {
  "Init": 0,
  "Menu": 1,
  "NewGame": 2,
  "NetworkGame": 3,
  "Settings": 4,
  "LeaderBoards": 5,
  "Rules": 6
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
  return "qrc:/res/images/backgrounds/bgr" + bgrStr + ".jpg"
}

function getNextBgrImage(index) {
  var bgrStr
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
