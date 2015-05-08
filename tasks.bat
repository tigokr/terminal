cd %~dp0
schtasks /create /f /sc weekly /tn "weekly reports" /tr "lib\wget.exe http:\\localhost\reporter.php?get=2"
schtasks /create /f /sc monthly /tn "monthly reports" /tr "lib\wget.exe http:\\localhost\reporter.php?get=3"
exit