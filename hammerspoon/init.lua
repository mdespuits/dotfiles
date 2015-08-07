---------------------------------------------
-- Configuration
---------------------------------------------

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- We don't like animation around here
hs.window.animationDuration = 0.0

-- Watchers
local configFileWatcher = nil
local screenWatcher = nil
local applicationWatcher = nil
local batteryWatcher = nil

-- Debugging
-- hs.logger.defaultLogLevel = "debug"
logger = hs.logger.new("debugger")

fnutils = require("hs.fnutils")

function fnutils.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- Other libraries
utcbar  = require("utcbar")
utcbar:start()

sizeup  = require("sizeup")

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs:reload()
    hs.notify.new({title="Hammerspoon", informativeText="Config reloaded", autoWithdraw=true}):send()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", hs.reload):start()

-- Reload Hammerspoon every five minutes to keep it alive and well
hs.timer.new(hs.timer.minutes(30), function()
  logger:d("Reloading Hammerspoon for freshness!")
  hs.reload()
end):start()

-- Screen Names
externalDisplayName = "Thunderbolt Display"
mainDisplayName = "Color LCD"

local lastScreenCount = fnutils.length(hs.screen.allScreens())

-- Watch for Screen events
function onScreenCountChange()
  local status = "on"
  local screencount = fnutils.length(hs.screen.allScreens())
  logger:d("Screen count changed: " .. screencount .. " monitors")

  if (screencount >= 2 and not (screencount == lastScreenCount)) then
    -- Toggle WiFi off when I'm plugged into my external monitor at work
    status = "off"
  else
    status = "on"
  end
  lastScreenCount = screencount
  output, status, _, rc = hs.execute("networksetup -setairportpower en0 " .. status)
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
hs.hotkey.bind({"cmd", "alt", "shift"}, "S", function()
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
  hs.applescript._applescript(script)
end)
