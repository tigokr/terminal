cd %~dp0

set TERM_PATH=%~dp0

net stop mongo
net stop httpd

%TERM_PATH%xampp\apache\bin\httpd.exe -k uninstall
%TERM_PATH%xampp\mongodb\bin\mongod.exe --remove

schtasks /delete /f /tn "Terminal 2w report"
schtasks /delete /f /tn "Terminal 1m report"
schtasks /delete /f /tn "Terminal alltime report"

schtasks /delete /f /tn "Terminal update rests"
schtasks /delete /f /tn "Terminal update by car selection"
schtasks /delete /f /tn "Terminal update nomenclature"
schtasks /delete /f /tn "Terminal update goods photos"
schtasks /delete /f /tn "Terminal update goods descriptions"
schtasks /delete /f /tn "Terminal update www"

schtasks /delete /f /tn "Terminal kill metrointerface"
schtasks /delete /f /tn "Terminal browser"

timeout /t 30