@echo off

@setlocal

cd %~dp0

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=xampp\php\php.exe
set PHP_INI=xampp\php\php.ini

start /min %TERM_PATH%\metrokiller.exe
timeout /t 1
enter.vbs
timeout /t 1
enter.vbs
timeout /t 1
start run.bat
timeout /t 15

start tasks.bat

%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\typesizes.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_counts.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items_photos.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_desc.php

shutdown -r

@endlocal