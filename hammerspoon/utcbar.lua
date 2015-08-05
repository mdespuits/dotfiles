---------------------------------------------
-- UTC Menu Bar
---------------------------------------------
local utcbar = { }

function utcbar.title(value)
  utcbar.menubar:setTitle(value)
end

function utcbar.update()
  utcbar.title(os.date(utcbar.dateformat))
end

function utcbar.start()
  utcbar.timer:start()
end

-- Initializes the hs.menubar
utcbar.menubar = hs.menubar.new()

-- Initializes the hs.timer
utcbar.timer = hs.timer.new(0.05, utcbar.update)

-- What format should we display
utcbar.dateformat = "!%H:%M:%S" .. " UTC"

return utcbar
