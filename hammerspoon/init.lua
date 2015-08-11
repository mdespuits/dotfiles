---------------------------------------------
-- Configuration
---------------------------------------------

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- We don't like animation around here
hs.window.animationDuration = 0.0

-- Watchers
local screenWatcher = nil
local applicationWatcher = nil
local batteryWatcher = nil

local mash      = { "ctrl", "alt", "cmd" }
local mashshift = { "cmd", "alt", "shift" }

-- Debugging
-- hs.logger.defaultLogLevel = "debug"
logger = hs.logger.new("debugger")

-- Other libraries
utcbar  = require("utcbar")
utcbar:start()

sizeup  = require("sizeup")

function reloadConfig(alert)
  hs:reload()
  if alert == true then
    hs.notify.new({title="Hammerspoon", informativeText="Config reloaded", autoWithdraw=true}):send():release()
  end
end

-- Reload Hammerspoon every so often to keep it alive and well
hs.timer.new(hs.timer.minutes(10), function()
  logger:d("Reloading Hammerspoon for freshness!")
  hs.reload(false)
end):start()

-- Screen Names
externalDisplayName = "Thunderbolt Display"
mainDisplayName     = "Color LCD"

local single_display = {
  { "Google Chrome"    , nil , mainDisplayName , hs.layout.maximized , nil , nil } ,
  { "iTerm"            , nil , mainDisplayName , hs.layout.maximized , nil , nil } ,
  { "Activity Monitor" , nil , mainDisplayName , hs.layout.left50    , nil , nil } ,
  { "Dash"             , nil , mainDisplayName , hs.layout.maximized , nil , nil } ,
  { "Messages"         , nil , mainDisplayName , hs.layout.right50   , nil , nil }
}


local dual_display = {
  { "Google Chrome"    , nil , mainDisplayName     , hs.layout.maximized , nil , nil } ,
  { "iTerm"            , nil , externalDisplayName , hs.layout.maximized , nil , nil } ,
  { "Activity Monitor" , nil , mainDisplayName     , hs.layout.left50    , nil , nil } ,
  { "Dash"             , nil , externalDisplayName , hs.layout.right50   , nil , nil } ,
  { "Messages"         , nil , mainDisplayName     , hs.layout.right50   , nil , nil }
}

-- Apply a particular screen layout based on the number of screens present
function applyScreenLayout(screencount)
  if screencount == 1 then
    hs.layout.apply(single_display)
  else
    hs.layout.apply(dual_display)
  end
end

-- Toggle WiFi off when I'm plugged into my external monitor at work
function applyWifiEnabled(screencount)
  local networkstatus = "on"
  networkstatus = screencount > 1 and 'off' or 'on'

  output, status, t, rc = hs.execute("networksetup -setairportpower en0 " .. networkstatus)
  logger:d("Output: " .. output)
  logger:d("Status: " .. tostring(status))
  logger:d("Type: " .. t)
  logger:d("RC: " .. rc)

  if not status == true or not rc == 0 then
    hs.alert("WiFi change failed :" .. output)
  end
end

local lastNumberOfScreens = #hs.screen.allScreens()

-- Watch for Screen events
function onScreenCountChange()
  local status = "on"
  newNumberOfScreens = #hs.screen.allScreens()

  logger:d("Screen count changed: " .. newNumberOfScreens .. " monitors")

  -- Make sure we only apply changes when screen count changes, not on any screen event
  if lastNumberOfScreens ~= newNumberOfScreens then
    applyWifiEnabled(newNumberOfScreens)
    applyScreenLayout(newNumberOfScreens)
  end

  lastNumberOfScreens = newNumberOfScreens
end

-- Watch for Application events
function onApplicationEvent(name, eventType, app)
  if (eventType == hs.application.watcher.activated) then
    -- Bring all Finder windows forward when one gets activated
    if (name == "Finder") then
      app:selectMenuItem({"Window", "Bring All to Front"})
    end

    -- Always unhide the app if it is hidden
    app:unhide()
  elseif (eventType == hs.application.watcher.deactivated) then
    if (name == "Finder") then
      app:hide()
    end
  end
end

-- Watch for Battery events
function onBatteryChange()
  local battery = hs.battery
  local batterylogger = hs.logger.new("battery", "debug")

  if (battery.powerSource() == "Battery Power") then
    batterylogger:d("Minutes Remaining: " .. battery.timeRemaining())
  else
    batterylogger:d("Minutes Until Charged: " .. battery.timeToFullCharge())
  end
end

-- Enable Application Watcher
applicationWatcher = hs.application.watcher.new(onApplicationEvent)
applicationWatcher:start()

-- Enable Screen Watcher
screenWatcher = hs.screen.watcher.new(onScreenCountChange)
screenWatcher:start()

-- Enable Battery Watcher
batteryWatcher = hs.battery.watcher.new(onBatteryChange)
batteryWatcher:start()

---------------------------------------------
-- OS X Notification Clear
---------------------------------------------
function clearNotifications()
  local script = [[
    my closeNotif()
    on closeNotif()

        tell application "System Events"
            tell process "Notification Center"
                set theWindows to every window
                repeat with i from 1 to number of items in theWindows
                    set this_item to item i of theWindows
                    try
                        click button 1 of this_item
                    on error

                        my closeNotif()
                    end try
                end repeat
            end tell
        end tell

    end closeNotif
  ]]
  hs.applescript.applescript(script)
end

---------------------------------------------
-- General Hotkeys
---------------------------------------------
hs.hotkey.bind(mash, '1', function() applyScreenLayout(1) end)
hs.hotkey.bind(mash, '2', function() applyScreenLayout(2) end)

hs.hotkey.bind(mash, 'y', function() hs.toggleConsole() end)
hs.hotkey.bind(mash, 'r', function() reloadConfig(true) end)

hs.hotkey.bind(mashshift, "S", clearNotifications)
