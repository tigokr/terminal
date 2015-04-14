@echo off

@setlocal

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=xampp\php\php.exe
set PHP_INI=xampp\php\php.ini

rem start /min metrokiller.exe
timeout /t 1
enter.vbs
timeout /t 1
enter.vbs
timeout /t 1
start run.bat
timeout /t 15

%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_counts.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items_photos.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_desc.php

start /min rests.bat
start /min nomenclature.bat

@endlocal

