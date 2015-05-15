@echo off

@setlocal

cd %~dp0

set TERM_PATH=%~dp0

TaskList|Find /I "WpfWbApp.exe">nul&&(ECHO none)||(
  	start %TERM_PATH%lib\WpfWbApp.exe
)

@endlocal