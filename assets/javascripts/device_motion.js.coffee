format = (value) ->
  Math.round(value * 100) / 100

showPanel = (panelid) ->
  panel = document.getElementById(panelid)
  panel.getElementsByClassName("no" )[0].style.display = "none"
  panel.getElementsByClassName("yes")[0].style.display = "block"

updateDomIdText = (domid, text) ->
  document.getElementById(domid).innerHTML = text

updateDeviceMotion = (evt) ->
  updateDomIdText("acce_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("acce_update_interval", "#{evt.interval}")
  if evt.accelerationIncludingGravity
    updateDomIdText("acce_acceleration_including_gravity_x", "#{format evt.accelerationIncludingGravity.x}")
    updateDomIdText("acce_acceleration_including_gravity_y", "#{format evt.accelerationIncludingGravity.y}")
    updateDomIdText("acce_acceleration_including_gravity_z", "#{format evt.accelerationIncludingGravity.z}")
  if evt.acceleration
    updateDomIdText("acce_acceleration_x", "#{format evt.acceleration.x}")
    updateDomIdText("acce_acceleration_y", "#{format evt.acceleration.y}")
    updateDomIdText("acce_acceleration_z", "#{format evt.acceleration.z}")
  if evt.rotationRate
    updateDomIdText("acce_rotation_alpha", "#{format evt.rotationRate.alpha}")
    updateDomIdText("acce_rotation_beta",  "#{format evt.rotationRate.beta}")
    updateDomIdText("acce_rotation_gamma", "#{format evt.rotationRate.gamma}")

updateDeviceOrientation = (evt) ->
  updateDomIdText("device_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("device_orientation_alpha",   "#{format evt.alpha}")
  updateDomIdText("device_orientation_beta",    "#{format evt.beta}")
  updateDomIdText("device_orientation_gamma",   "#{format evt.gamma}")
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
