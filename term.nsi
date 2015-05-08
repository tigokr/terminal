; Script generated with the Venis Install Wizard

; Define your application name
!define APPNAME "Òåðìèíàë"
!define APPNAMEANDVERSION "${APPNAME} 1.2.2"

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "C:\terminal"
InstallDirRegKey HKLM "Software\${APPNAME}" ""
OutFile "terminst_v1.2.exe"


; Modern interface settings
!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\finish.bat"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_RESERVEFILE_LANGDLL

Section "Òåðìèíàë 4tochki.ru" Section1
  SetOutPath "$INSTDIR"
	;WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "Apache" "$INSTDIR\xampp\apache\bin\httpd.exe"
	;WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "MongoDb" "$INSTDIR\xampp\mongodb\bin\mongod.exe --journal --dbpath $INSTDIR\xampp\mongodb\db"
	;WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "metrokiller" "$INSTDIR\metrokiller.exe"
	;WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "web" "$INSTDIR\WpfWbApp.exe"
	WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "terminal" "$INSTDIR\init.bat"
	
	; Set Section properties
	SetOverwrite on
	RMDir /r "$INSTDIR"

	File /r /x ".git" /x ".idea" /x "tmp" \
		/x www\images\*.* /x www\install\*.xml /x "*.pdf" \
		/x "terminst*.*" /x ".git*" /x "mongo*.pdb" \
		/x xampp\mongodb\db\*.* \
		/x xampp\apache\include /x xampp\apache\logs /x Thumbs.db \
		e:\*
	
	WriteUninstaller "$INSTDIR\uninstall.exe"  

SectionEnd

Section "Uninstall"
	;DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "Apache"
	;DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "MongoDb"
	;DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "metrokiller"
	;DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "web"
	DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "terminal"
	
	RMDir /r /REBOOTOK "$INSTDIR"
SectionEnd

BrandingText "4tochki.ru"

; eof