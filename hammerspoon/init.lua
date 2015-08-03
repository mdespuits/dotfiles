hs.window.animationDuration = 0.1

-- dnsmasqerade = require("dnsmasq")
utcbar  = require("utcbar")
sizeup  = require("sizeup")

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded", autoWithdraw=true}):send()

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

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "G", function()
  hs.grid.GRIDHEIGHT = 2
  hs.grid.GRIDWIDTH = 2
  hs.grid.show()
end)
