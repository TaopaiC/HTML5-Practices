format = (value) ->
  Math.round(value * 100) / 100

showPanel = (panelid) ->
  panel = document.getElementById(panelid)
  panel.getElementsByClassName("no" )[0].style.display = "none"
  panel.getElementsByClassName("yes")[0].style.display = "block"

updateDomIdText = (domid, text) ->
  document.getElementById(domid).innerHTML = text

updateDomIdCounter = (domid, value, range) ->
  percent = Math.abs(value / range) * 50
  dom = document.getElementById(domid)
  dom.style.width = "#{percent}%"
  dom.className = if value > 0 then "pos" else "neg"

updateDeviceMotion = (evt) ->
  updateDomIdText("acce_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("acce_update_interval", "#{evt.interval}")
  if evt.accelerationIncludingGravity
    updateDomIdText("acce_acceleration_including_gravity_x", "#{format evt.accelerationIncludingGravity.x}")
    updateDomIdText("acce_acceleration_including_gravity_y", "#{format evt.accelerationIncludingGravity.y}")
    updateDomIdText("acce_acceleration_including_gravity_z", "#{format evt.accelerationIncludingGravity.z}")
    updateDomIdCounter("acce_acceleration_including_gravity_x_counter", evt.accelerationIncludingGravity.x, 15)
    updateDomIdCounter("acce_acceleration_including_gravity_y_counter", evt.accelerationIncludingGravity.y, 15)
    updateDomIdCounter("acce_acceleration_including_gravity_z_counter", evt.accelerationIncludingGravity.z, 15)
  if evt.acceleration
    updateDomIdText("acce_acceleration_x", "#{format evt.acceleration.x}")
    updateDomIdText("acce_acceleration_y", "#{format evt.acceleration.y}")
    updateDomIdText("acce_acceleration_z", "#{format evt.acceleration.z}")
    updateDomIdCounter("acce_acceleration_x_counter", evt.acceleration.x, 2)
    updateDomIdCounter("acce_acceleration_y_counter", evt.acceleration.y, 2)
    updateDomIdCounter("acce_acceleration_z_counter", evt.acceleration.z, 2)
  if evt.rotationRate
    updateDomIdText("acce_rotation_alpha", "#{format evt.rotationRate.alpha}")
    updateDomIdText("acce_rotation_beta",  "#{format evt.rotationRate.beta}")
    updateDomIdText("acce_rotation_gamma", "#{format evt.rotationRate.gamma}")
    updateDomIdCounter("acce_rotation_alpha_counter", evt.rotationRate.alpha, 50)
    updateDomIdCounter("acce_rotation_beta_counter",  evt.rotationRate.beta,  50)
    updateDomIdCounter("acce_rotation_gamma_counter", evt.rotationRate.gamma, 50)

updateDeviceOrientation = (evt) ->
  updateDomIdText("device_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("device_orientation_alpha",   "#{format evt.alpha}")
  updateDomIdText("device_orientation_beta",    "#{format evt.beta}")
  updateDomIdText("device_orientation_gamma",   "#{format evt.gamma}")
  updateDomIdCounter("device_orientation_alpha_counter", evt.alpha, 360)
  updateDomIdCounter("device_orientation_beta_counter",  evt.beta, 180)
  updateDomIdCounter("device_orientation_gamma_counter", evt.gamma, 180)
  updateDomIdText("device_orientation_absolute","#{evt.absolute}")
  updateDomIdText("window_orientation","#{window.orientation}")

updateMozOrientation = (evt) ->
  updateDomIdText("moz_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("moz_orientation_x", "#{format evt.x}")
  updateDomIdText("moz_orientation_y", "#{format evt.y}")
  updateDomIdText("moz_orientation_z", "#{format evt.z}")

init = ->
  if (window.DeviceMotionEvent != undefined)
    showPanel("acce_panel")
    window.addEventListener("devicemotion", updateDeviceMotion)
  if (window.DeviceOrientationEvent != undefined)
    showPanel("orientation_panel")
    window.addEventListener("deviceorientation", updateDeviceOrientation)
  if (window.MozOrientationEvent != undefined)
    showPanel("moz_orientation_panel")
    window.addEventListener("MozOrientation", updateMozOrientation)

init()
