---------------------------------------------
-- UTC Menu Bar
---------------------------------------------
utcbar = hs.menubar.new()
utcbar:setTitle(os.date("!%b %d, %H:%M:%S" .. " UTC"))

function updateUtcBar()
  utcbar:setTitle(os.date("!%b %d, %H:%M:%S" .. " UTC"))
end

hs.timer.new(0.05, updateUtcBar):start()

return utcbar
