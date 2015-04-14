@echo off

@setlocal

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=xampp\php\php.exe
set PHP_INI=xampp\php\php.ini

:label
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_items_photos.php
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_desc.php
timeout /t 6000
GOTO label

@endlocal