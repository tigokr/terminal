:CheckStart

TaskList|Find /I "httpd.exe">nul&&(ECHO none)||(
	start c:\terminal\xampp\apache\bin\httpd.exe
	GOTO CheckStart
)

TaskList|Find /I "mongod.exe">nul&&(ECHO none)||(
	Taskkill /im "mongod.exe" /f /t
	start c:\terminal\xampp\mongodb\bin\mongod.exe --journal --dbpath c:\terminal\xampp\mongodb\db
	GOTO CheckStart
)

TaskList|Find /I "WpfWbApp.exe">nul&&(ECHO none)||(
  	start c:\terminal\WpfWbApp.exe
	GOTO CheckStart
)

timeout /t 600
GOTO CheckStart