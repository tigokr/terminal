@setlocal

cd %~dp0

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=%TERM_PATH%xampp\php\php.exe
set PHP_INI=%TERM_PATH%xampp\php\console.ini

rem NetSh Advfirewall set allprofiles state off

REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d terminal /f

%TERM_PATH%lib\metrokiller.exe /s

%TERM_PATH%xampp\mongodb\bin\mongod.exe --journal --dbpath %TERM_PATH%xampp\mongodb\db --logpath %TERM_PATH%xampp\mongodb\db\mongo.log --install --serviceName "mongo" --serviceDisplayName "mongo"
%TERM_PATH%xampp\apache\bin\httpd.exe -f %TERM_PATH%xampp\apache\conf\httpd.conf -k install -n "httpd"

net start mongo
net start httpd

start %TERM_PATH%lib\WpfWbApp.exe

rem %PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\composer.phar -q self-update
rem %PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\composer.phar -q update

%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\typesizes.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_counts.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items_photos.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_desc.php

start tasks.bat

shutdown -r

@endlocal