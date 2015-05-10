cd %~dp0

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=%TERM_PATH%xampp\php\php.exe
set PHP_INI=%TERM_PATH%xampp\php\console.ini

schtasks /create /tn "Terminal 2w report" /f /sc WEEKLY /mo 2 /st 23:00 /tr "%TERM_PATH%lib\wget.exe http://localhost/reporter.php?get=2 -o NUL"
schtasks /create /tn "Terminal 1m report" /f /sc MONTHLY /st 23:00 /tr "%TERM_PATH%lib\wget.exe http://localhost/reporter.php?get=3 -o NUL"
schtasks /create /tn "Terminal alltime report" /f /sc MONTHLY /st 23:00 /tr "%TERM_PATH%lib\wget.exe http://localhost/reporter.php?get=1 -o NUL"

schtasks /create /tn "Terminal update rests" /f /sc MINUTE /mo 15 /tr "%PHP_COMMAND% -c %PHP_INI% %WWW_PATH%\install\import_counts.php"
schtasks /create /tn "Terminal update by car selection" /f /sc DAILY /st 01:01 /tr "%PHP_COMMAND% -c %PHP_INI% %WWW_PATH%\install\import.php"
schtasks /create /tn "Terminal update nomenclature" /f /sc WEEKLY /d sun /st 03:01 /tr "%PHP_COMMAND% -c %PHP_INI% %WWW_PATH%\install\import_items.php"
schtasks /create /tn "Terminal update goods photos" /f /sc WEEKLY /d sun /st 05:01 /tr "%PHP_COMMAND% -c %PHP_INI% %WWW_PATH%\install\import_items_photos.php"
schtasks /create /tn "Terminal update goods descriptions" /f /sc WEEKLY /d sun /st 05:30 /tr "%PHP_COMMAND% -c %PHP_INI% %WWW_PATH%\install\import_desc.php"
schtasks /create /tn "Terminal update www" /f /sc WEEKLY /d sun /st 00:01 /tr "%TERM_PATH%update.bat"

schtasks /create /tn "Terminal kill metrointerface" /f /sc ONSTART /delay 0001:00 /tr "%TERM_PATH%lib\metrokiller.exe /s"
schtasks /create /tn "Terminal browser" /f /sc ONSTART /delay 0001:05 /tr "%TERM_PATH%lib\WpfWbApp.exe"

exit