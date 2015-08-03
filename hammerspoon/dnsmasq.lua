---------------------------------------------
-- Dnsmasq Refresher
---------------------------------------------
function reloadDnsmasq(files)
  local logger = hs.logger.new("matt.dnsmasq", "debug")
  shell = "ps aux | grep -v grep | grep dnsmasq | awk '{print $2}' | xargs sudo kill"
  logger.d(shell)
  output, status, type, rc = hs.execute(shell)
  for _,file in pairs(files) do
    logger.d(file)
    if file ~= "dnsmasq.conf" then
      logger.d("dnsmasq.conf was reloaded. Status: " .. rc)
      local notifier = hs.notify.new({title="Hammerspoon", informativeText="Dnsmasq Restart Failed", autoWithdraw=true})
      if status then
        logger.d("Dnsmasq was restarted")
        notifier:informativeText("Dnsmasq Restarted")
      end
      notifier:send()
    end
  end
end

local watcher = hs.pathwatcher.new("/usr/local/etc/dnsmasq.conf", reloadDnsmasq)
watcher:start()

return watcher
