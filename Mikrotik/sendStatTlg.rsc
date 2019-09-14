:log info "Start WANstat script"
# set router name
:global routername "router name";
# set url to telegramm bot
# Замените значение в кавычках на свое
:global sendToTele "https://api.telegram.org/botХХХХХХХХХХ:YYYYYYYYYYYYYYYYY/sendmessage\?chat_id=-ZZZZZZZZZZZ&text=";
# set downloaded Gb
# Замените название интерфейса на нужный
:global rxbyte [/interface get [find name=WAN] rx-byte];
:global simplGbrxreport ($rxbyte / 1073741824);
:global lowGbrxreport ((($rxbyte - ($simplGbrxreport * 1073741824)) * 1000000000) / 1048576);
:global Gbrxreport ("$[$simplGbrxreport]".",".[:pick "$[$lowGbrxreport]" 0 3] );
# set uploaded Gb
# Замените название интерфейса на нужный
:global txbyte [/interface get [find name=WAN] tx-byte];
:global simplGbtxreport ($txbyte / 1073741824);
:global lowGbtxreport ((($txbyte - ($simplGbtxreport * 1073741824)) * 1000000000) / 1048576);
:global Gbtxreport ("$[$simplGbtxreport]".",".[:pick "$[$lowGbtxreport]" 0 3] );
# set temp
:global tempC [/system health get temperature];
# set voltage
:global volt [/system health get voltage];
:global simplvolt ($volt / 10);
:global lowvolt ((($volt - ($simplvolt * 10)) * 10) / 1);
:global involt ("$[$simplvolt]".",".[:pick "$[$lowvolt]" 0 3] );
# set uptime
:global uptime [/system resource get uptime]
# set CPU load
:global cpuZ [/system resource get cpu-load]
# set version
:global vers [/system resource get version]
# set memory
:global memt [/system resource get total-memory]
:global memtotal ($memt / 1048576)
:global memo [/system resource get free-memory]
:global memoMB ($memo / 1048576)
#
# Message to telegramm bot
#
/tool fetch url="$sendToTele $routername%0AVersion: $vers%0AUptime: $uptime%0AVoltage: $involt V%0ATemperature: $tempC C%0ACPU load: $cpuZ %%0AMemory Free / Total: $memoMB / $memtotal MB%0ADownload: $Gbrxreport GB%0AUpload: $Gbtxreport GB "  keep-result=no
:log info "WANstat script finished"
