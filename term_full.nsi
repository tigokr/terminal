; Script generated with the Venis Install Wizard

; Define your application name
!define APPNAME "Òåðìèíàë"
!define VERSION "1.2.6"
!define APPNAMEANDVERSION "${APPNAME} ${VERSION}"


; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "C:\terminal"
InstallDirRegKey HKLM "Software\${APPNAME}" ""
OutFile "terminst_v${VERSION}_full.exe"



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

!include LogicLib.nsh

RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)

Function .onInit
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
${EndIf}
FunctionEnd

Section "Òåðìèíàë 4tochki.ru" Section1
    ;WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "terminal" "$INSTDIR\init.bat"

    ; Set Section properties
    SetOverwrite on
    RMDir /r "$INSTDIR"

    SetOutPath "$INSTDIR"
    File /r /x .git /x .idea /x tmp /x .git* /x *.pdf \
        /x www /x xampp /x terminst* \
    f:\dev\terminal\*

    SetOutPath "$INSTDIR\www"
    File /r /x .git /x .idea /x tmp /x .git* /x *.log /x *.pdf \
        /x install \
    f:\dev\terminal\www\*
    CreateDirectory "$INSTDIR\tmp"

    SetOutPath "$INSTDIR\www\install"
    File /r /x .git /x .idea /x tmp /x .git* \
        /x *.xml \
    f:\dev\terminal\www\install\*

    SetOutPath "$INSTDIR\xampp"
    File /r /x .git /x .idea /x tmp /x .git* /x *.log /x *.pdf \
        /x tmp /x mongodb \
        f:\dev\terminal\xampp\*
    CreateDirectory "$INSTDIR\xampp\tmp"

    SetOutPath "$INSTDIR\xampp\mongodb"
    File /r /x .git /x .idea /x tmp /x .git* /x *.log /x *.pdf \
        /x db /x *.pdb \
        f:\dev\terminal\xampp\mongodb\*
    CreateDirectory "$INSTDIR\xampp\mongodb\db"

    WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

Section "Uninstall"
	;DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Run" "terminal"
    ExecShell "" "$INSTDIR\remove_tasks.bat"
	RMDir /r /REBOOTOK "$INSTDIR"
	ExecShell "" "shutdown -r"
SectionEnd

BrandingText "4tochki.ru"

; eof