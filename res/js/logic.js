.pragma library

function calcRandomDuration(m_behavior_pause) {
  var rnd = 1 + Math.random() * 0.4 - 0.2
  return Math.floor(m_behavior_pause * rnd)
}

function updateWord(ball_data) {
  console.log("BallData: ", ball_data.m_x, ball_data.m_y)
  var rnd = 10 + Math.random() * 0.4 - 0.2
  ball_data.m_x += Math.floor(rnd)
  ball_data.m_y += Math.floor(rnd)
}
