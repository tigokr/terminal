@echo off

@setlocal

cd %~dp0

set TERM_PATH=%~dp0
set WWW_PATH=%TERM_PATH%www
set PHP_COMMAND=xampp\php\php.exe
set PHP_INI=xampp\php\php.ini

:label
%PHP_COMMAND% -c "%PHP_INI%" %WWW_PATH%\install\import_counts.php
timeout /t 300
GOTO label

@endlocal