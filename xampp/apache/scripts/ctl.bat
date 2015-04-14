@echo off

if not ""%1"" == ""START"" goto stop

"C:\terminal\xampp\apache\bin\httpd.exe"

if errorlevel 255 goto finish
if errorlevel 1 goto error
goto finish

:stop
"C:\terminal\xampp\apache\bin\pv" -f -k httpd.exe -q
if not exist "C:\terminal\xampp\apache\logs\httpd.pid" GOTO finish
del "C:\terminal\xampp\apache\logs\httpd.pid"
goto finish

:error
echo Error starting Apache

:finish
exit
