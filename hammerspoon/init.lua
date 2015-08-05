-- Capture the hostname, so we can make this config behave differently across my Macs
hostname = hs.host.localizedName()

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

local fnutils = require("hs.fnutils")

-- Watchers
local configFileWatcher = nil
local screenWatcher = nil
local applicationWatcher = nil

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

hs.window.animationDuration = 0.0

-- Other libraries
utcbar  = require("utcbar")
sizeup  = require("sizeup")

utcbar:start()

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

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded", autoWithdraw=true}):send():release()

-- Toggle WiFi off when I'm plugged into my external monitor at work

function onScreenCountChange()
  local status = "on"
  local screencount = tablelength(hs.screen.allScreens())

  if screencount > 1 then
    status = "off"
  else
    status = "on"
  end
  output, status, _, rc = hs.execute("networksetup -setairportpower en0 " .. status)
end

-- Bring all windows to the front
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

-- Enable Application Watcher
applicationWatcher = hs.application.watcher.new(onApplicationEvent)
applicationWatcher:start()

-- Enable Screen Watcher
screenWatcher = hs.screen.watcher.new(onScreenCountChange)
screenWatcher:start()

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
