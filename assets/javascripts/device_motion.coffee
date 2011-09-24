format = (value) ->
  Math.round(value * 100) / 100

showHasEventObject = (domid) ->
  obj = document.getElementById(domid)
  obj.innerHTML = "yes"

showPanel = (panelid) ->
  panel = document.getElementById(panelid)
  if (panel.className.indexOf("support") < 0)
    panel.className += " support"

updateDomIdText = (domid, text) ->
  document.getElementById(domid).innerHTML = text

updateDomIdCounter = (domid, value, range) ->
  percent = Math.abs(value / range) * 50
  dom = document.getElementById(domid)
  dom.style.width = "#{percent}%"
  dom.className = if value > 0 then "pos" else "neg"

updateDomIdTextAndCounter = (domid, value, range) ->
  updateDomIdText(domid, "#{format value}")
  updateDomIdCounter("#{domid}_counter", value, range)

updateDeviceMotion = (evt) ->
  showPanel("acce_panel")
  updateDomIdText("acce_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("acce_update_interval", "#{evt.interval}")
  if evt.accelerationIncludingGravity
    updateDomIdTextAndCounter("acce_acceleration_including_gravity_x", evt.accelerationIncludingGravity.x, 15)
    updateDomIdTextAndCounter("acce_acceleration_including_gravity_y", evt.accelerationIncludingGravity.y, 15)
    updateDomIdTextAndCounter("acce_acceleration_including_gravity_z", evt.accelerationIncludingGravity.z, 15)
  if evt.acceleration
    updateDomIdTextAndCounter("acce_acceleration_x", evt.acceleration.x, 2)
    updateDomIdTextAndCounter("acce_acceleration_y", evt.acceleration.y, 2)
    updateDomIdTextAndCounter("acce_acceleration_z", evt.acceleration.z, 2)
  if evt.rotationRate
    updateDomIdTextAndCounter("acce_rotation_alpha", evt.rotationRate.alpha, 50)
    updateDomIdTextAndCounter("acce_rotation_beta",  evt.rotationRate.beta , 50)
    updateDomIdTextAndCounter("acce_rotation_gamma", evt.rotationRate.gamma, 50)

updateDeviceOrientation = (evt) ->
  showPanel("orientation_panel")
  updateDomIdText("device_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdTextAndCounter("device_orientation_alpha",   evt.alpha, 360)
  updateDomIdTextAndCounter("device_orientation_beta",    evt.beta , 180)
  updateDomIdTextAndCounter("device_orientation_gamma",   evt.gamma, 180)
  updateDomIdText("device_orientation_absolute","#{evt.absolute}")
  updateDomIdText("window_orientation_by_deviceorientation","#{window.orientation}")

updateOrientation = (evt) ->
  showPanel("window_orientation_panel")
  updateDomIdText("window_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdText("window_orientation","#{window.orientation}")

updateMozOrientation = (evt) ->
  showPanel("moz_orientation_panel")
  updateDomIdText("moz_orientation_update_time", "#{(new Date()).getTime()}")
  updateDomIdTextAndCounter("moz_orientation_x", evt.x, 360)
  updateDomIdTextAndCounter("moz_orientation_y", evt.y, 180)
  updateDomIdTextAndCounter("moz_orientation_z", evt.z, 180)

init = ->
  # on orientation change
  window.onorientationchange = updateOrientation
  # device motion
  showHasEventObject("acce_event_object") if (window.DeviceMotionEvent != undefined)
  window.addEventListener("devicemotion", updateDeviceMotion)
  # device orientation
  showHasEventObject("device_orientation_event_object") if (window.DeviceOrientationEvent != undefined)
  window.addEventListener("deviceorientation", updateDeviceOrientation)
  # moz device orientation
  showHasEventObject("moz_orientation_event_object") if (window.MozOrientationEvent != undefined)
  window.addEventListener("MozOrientation", updateMozOrientation)

init()
