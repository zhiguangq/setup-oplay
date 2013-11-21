!include "mui2.nsh"
InstType "Full"
InstType "Lite"
InstType "Minimal"
!include "MUI2.nsh"
!include "Sections.nsh"
!include "LogicLib.nsh"
!include "Memento.nsh"
!include "WordFunc.nsh"

#!define QTDIR "D:\Qt\4.7.0"
!define PRODUCT_NAME "oplay"
!define PRODUCT_VERSION "1.0.0.6"
Var SPACE_STR
Var INSTALL_DIR

outfile "Setup${PRODUCT_NAME}_${PRODUCT_VERSION}.exe"
installDir "$PROGRAMFILES\oplay" 
RequestExecutionLevel admin

Page directory beforeDirectoryPage "" afterDirectoryPage
Page instfiles
;!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Function beforeDirectoryPage
	ReadRegStr $0 HKCU "Software\oplay" "installDirectory"
	${If} $0 == ""
		;no exit directory page, do nothing
	${Else}
		;exit directory page
		Abort
	${EndIf}
FunctionEnd

Function afterDirectoryPage
	ReadRegStr $0 HKCU "Software\oplay" "installDirectory"
	${If} $0 == ""
		;set install directory to reg
		WriteRegStr HKCU "Software\oplay" "installDirectory" $INSTDIR
		StrCpy $INSTALL_DIR $INSTDIR
	${Else}
		;exit directory page and get last install dir
		StrCpy $INSTALL_DIR $0
		Abort
	${EndIf}
FunctionEnd

Function .onInit
FunctionEnd

section
ReadRegStr $0 HKCU "Software\oplay" "installDirectory"
StrCpy $INSTALL_DIR $0

StrCpy $SPACE_STR " "
WriteRegStr HKCR "oplay" "" "URL:oplay Protocol Handler"
WriteRegStr HKCR "oplay" "URL Protocol" ""
WriteRegStr HKCR "oplay\shell\open\command" "" $INSTALL_DIR\${PRODUCT_NAME}.exe$SPACE_STR"%0"

setOutPath $INSTALL_DIR
file oplay\avcodec-55.dll
file oplay\avformat-55.dll
file oplay\avresample-1.dll
file oplay\avfilter-3.dll
file oplay\avutil-52.dll
file oplay\msvcp100d.dll
file oplay\msvcr100d.dll
file oplay\playlist.xml
file oplay\oplay.html
file oplay\portaudio_x86.dll
file oplay\pthreadgc2.dll
file oplay\QtAVd1.dll
file oplay\QtCored4.dll
file oplay\QtGuid4.dll
file oplay\QtNetworkd4.dll
file oplay\QtOpenGLd4.dll
file oplay\QtXmld4.dll
file oplay\swresample-0.dll
file oplay\swscale-2.dll
file oplay\zlib1.dll
file oplay\oplay.exe

setOutPath $INSTALL_DIR\plugins\codecs
file oplay\plugins\codecs\qcncodecs4.dll
file oplay\plugins\codecs\qcncodecsd4.dll
file oplay\plugins\codecs\qjpcodecs4.dll
file oplay\plugins\codecs\qjpcodecsd4.dll
file oplay\plugins\codecs\qkrcodecs4.dll
file oplay\plugins\codecs\qkrcodecsd4.dll
file oplay\plugins\codecs\qtwcodecs4.dll
file oplay\plugins\codecs\qtwcodecsd4.dll

setOutPath $INSTALL_DIR\plugins\iconengines
file oplay\plugins\iconengines\qsvgicon4.dll
file oplay\plugins\iconengines\qsvgicond4.dll

setOutPath $INSTALL_DIR\plugins\imageformats
file oplay\plugins\imageformats\qgif4.dll
file oplay\plugins\imageformats\qgifd4.dll
file oplay\plugins\imageformats\qico4.dll
file oplay\plugins\imageformats\qicod4.dll
file oplay\plugins\imageformats\qjpeg4.dll
file oplay\plugins\imageformats\qjpegd4.dll
file oplay\plugins\imageformats\qmng4.dll
file oplay\plugins\imageformats\qmngd4.dll
file oplay\plugins\imageformats\qsvg4.dll
file oplay\plugins\imageformats\qsvgd4.dll
file oplay\plugins\imageformats\qtga4.dll
file oplay\plugins\imageformats\qtgad4.dll
file oplay\plugins\imageformats\qtiff4.dll
file oplay\plugins\imageformats\qtiffd4.dll

setOutPath $INSTALL_DIR\translations
file oplay\translations\qwinff_cs_CZ.qm
file oplay\translations\qwinff_it_IT.qm
file oplay\translations\qwinff_ja_JP.qm
file oplay\translations\qwinff_zh_CN.qm
file oplay\translations\qwinff_zh_TW.qm

writeUninstaller $INSTALL_DIR\uninstaller.exe

createShortCut "$DESKTOP\oplay.lnk" "$INSTALL_DIR\oplay.exe"

CreateDirectory "$SMPROGRAMS\oplay"
createShortCut "$SMPROGRAMS\oplay\oplay.lnk" "$INSTALL_DIR\oplay.exe"
createShortCut "$SMPROGRAMS\oplay\uninstaller.lnk" "$INSTALL_DIR\uninstaller.exe"
#ExecShell "open" "http://www.baidu.com/"
sectionEnd

section "Uninstall"
ReadRegStr $0 HKCU "Software\oplay" "installDirectory"
StrCpy $INSTALL_DIR $0
rmDir /r "$INSTALL_DIR"
delete "$DESKTOP\oplay.lnk"
delete "$SMPROGRAMS\oplay\oplay.lnk"
delete "$SMPROGRAMS\oplay\uninstaller.lnk"
rmDir /r "$SMPROGRAMS\oplay"
DeleteRegKey /ifempty HKCU "Software\oplay"
#ExecShell "open" "http://www.baidu.com/"
sectionEnd