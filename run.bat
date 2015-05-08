@echo off

@setlocal

cd %~dp0

set TERM_PATH=%~dp0

:CheckStart

TaskList|Find /I "httpd.exe">nul&&(ECHO none)||(
	start %TERM_PATH%\xampp\apache\bin\httpd.exe
	GOTO CheckStart
)

TaskList|Find /I "mongod.exe">nul&&(ECHO none)||(
	Taskkill /im "mongod.exe" /f /t
	start %TERM_PATH%\xampp\mongodb\bin\mongod.exe --journal --dbpath %TERM_PATH%\xampp\mongodb\db
	GOTO CheckStart
)

TaskList|Find /I "WpfWbApp.exe">nul&&(ECHO none)||(
  	start %TERM_PATH%\WpfWbApp.exe
	GOTO CheckStart
)

timeout /t 600
GOTO CheckStart

@endlocal