:---------------------------------------
:INIT_SECTION
:---------------------------------------
     ECHO OFF
:---------------------------------------
     TITLE - WELCOME -
:---------------------------------------   
     CHCP 1251 >NUL
     MODE CON:COLS=80 LINES=29
:---------------------------------------
     SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS 
:--------------------------------------- 
     SET "_NFF_I="
:---------------------------------------
     SET "CE=_BIN\CECHO.EXE"
     SET "MU=_BIN\CMDMENUSEL.EXE"
     SET "AP=_BIN\AAPT.EXE"
:---------------------------------------
     SET "NFF_HME=%~dp0"
:--------------------------------------- 
     CD /D "!NFF_HME!"
:---------------------------------------


REM ============================================================================
:_CLE
REM ============================================================================
     DEL /S /F /Q *.TMP *.SER *.MOR >NUL 2>&1
REM ----------------------------------------------------------------------------
     DEL /F /Q "_KRN\x32\_SCY\ADB*.*" "_KRN\x32\_SCY\*.BAT" >NUL 2>&1
     DEL /F /Q "_KRN\x64\_SCY\ADB*.*" "_KRN\x64\_SCY\*.BAT" >NUL 2>&1
REM ----------------------------------------------------------------------------
     FOR %%F IN (CUR*.*) DO IF /I NOT "%%~nxF"=="CUR.IPA" DEL /S /F /Q "%%F"
REM ============================================================================


REM ============================================================================
:_CPY
REM ============================================================================
     IF EXIST "_BIN\ADB.EXE" GOTO _SPLASH
REM ----------------------------------------------------------------------------
     IF EXIST "%PROGRAMFILES(x86)%" (SET "BIT=x64") ELSE (SET "BIT=x32")
REM ----------------------------------------------------------------------------
     SET "KRN_PATH=_KRN\%BIT%\"
REM ----------------------------------------------------------------------------
     ECHO Y|XCOPY "_KRN\%BIT%\_BSE\*.*" "_BIN\" /E /H >NUL 2>&1
     ECHO Y|XCOPY "_KRN\%BIT%\_SCY\*.*" "_BIN\" /E /H >NUL 2>&1
REM ----------------------------------------------------------------------------
     ECHO Y|XCOPY "_KRN\ALL-W\*.*" "_BIN\" /E /H >NUL 2>&1
REM ----------------------------------------------------------------------------
     ECHO Y|XCOPY "_KRN\ALL-Z\*.*" "_BIN\" /E /H >NUL 2>&1
REM ============================================================================


:---------------------------------------


REM ============================================================================
:_SPLASH
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     CLS
REM ----------------------------------------------------------------------------

     COLOR 08
     TITLE - WELCOME - 

     ECHO. 
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO. 
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" {08}    ========================================================================{#}{\n}
     "!CE!"                               {02}- CONFIG SCRIPT -{#}{\n}
     "!CE!"                           {04}FIRE OS 5-8{#} {06}STOCK FW{#} {09}NO ROOT{#}{\n}
     "!CE!" {08}    ========================================================================{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO. 
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO. 

REM ----------------------------------------------------------------------------
     TASKKILL /F /IM ADB.EXE >NUL 2>&1
REM ----------------------------------------------------------------------------
     PING -n 5 127.0.0.1 >NUL
REM ============================================================================ 


:---------------------------------------


REM ============================================================================
:_INA
REM ============================================================================
     VER | FIND "6.1" >NUL
     IF ERRORLEVEL 1 GOTO _INB
REM ----------------------------------------------------------------------------
::   ONLY FOR WIN 7     
REM ----------------------------------------------------------------------------
     IF EXIST "_KRN\W7F" (
          REM ФАЙЛ W7F СУЩЕСТВУЕТ, НИЧЕГО НЕ ДЕЛАЕМ
     ) ELSE (
          REM NON-UNICODE - WIN 7
          REG DELETE "HKCU\Console" /f  >NUL 2>&1
          REG IMPORT "_KRN\NEW_FNT.REG" >NUL 2>&1
          REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v ACP   /d 1251 /f >NUL 2>&1
          REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v OEMCP /d 866  /f >NUL 2>&1
          ECHO PASS A > "_KRN\W7F"
          :: CMD.EXE /C %0
          START "NEW START COMMAND FILE" "%~f0"
          EXIT
     )
REM ----------------------------------------------------------------------------
     ECHO "language=english">"_LNG\lang"
REM ============================================================================ 


REM ============================================================================
:_INB
REM ============================================================================
     VER | FIND "10.0" >NUL
     IF ERRORLEVEL 1 GOTO _INC
REM ----------------------------------------------------------------------------
::   ONLY FOR WIN 10-11     
REM ----------------------------------------------------------------------------
     IF EXIST "_KRN\W1F" (
          REM ФАЙЛ W1F СУЩЕСТВУЕТ, НИЧЕГО НЕ ДЕЛАЕМ
     ) ELSE (
          REM NON-UNICODE - WIN 10-11

          REG DELETE "HKCU\Console" /f  >NUL 2>&1
          REG IMPORT "_KRN\NEW_FNT.REG" >NUL 2>&1

          POWERSHELL -ExecutionPolicy Bypass -File "_KRN\LNG.PS1" >NUL 2>&1

          ECHO PASS A > "_KRN\W1F"
          :: CMD.EXE /C %0
          START "NEW START COMMAND FILE" "%~f0"
          EXIT
     )
REM ----------------------------------------------------------------------------
     IF EXIST "_KRN\TRM" (
          REM ФАЙЛ TRM СУЩЕСТВУЕТ, НИЧЕГО НЕ ДЕЛАЕМ
     ) ELSE (
          REM ПРАВИМ ТЕРМИНАЛ - WIN 11

          REG DELETE "HKCU\Console" /f  >NUL 2>&1
          REG IMPORT "_KRN\NEW_FNT.REG" >NUL 2>&1

          POWERSHELL -ExecutionPolicy Bypass -File "_KRN\TRM.PS1" >NUL 2>&1

          ECHO PASS A > "_KRN\TRM"
          :: CMD.EXE /C %0
          START "NEW START COMMAND FILE" "%~f0"
          EXIT
     )
REM ============================================================================ 


REM ============================================================================
:_INC
REM ============================================================================
     REG ADD "HKCU\Console" /v "LineWrap" /t REG_DWORD /d 0 /f >NUL 2>&1
     REG ADD "HKCU\Console" /v "ScreenBufferSize" /t REG_DWORD /d 2329012c /f >NUL 2>&1
REM ============================================================================ 


REM ============================================================================
:_IND
REM ============================================================================
     _BIN\ADB.EXE kill-server >NUL 2>&1
     TASKKILL /F /IM ADB.EXE  >NUL 2>&1
REM ----------------------------------------------------------------------------
     START "" /WAIT /B "_BIN\AHK.EXE" /FORCE "_BIN\_UOF.AHK"
REM  TASKKILL /f /fi "WINDOWTITLE eq DROP-CAT"  >NUL 2>&1
REM  TASKKILL /f /fi "WINDOWTITLE eq КОТО-ДРОП" >NUL 2>&1
REM ============================================================================


:---------------------------------------
:_LNG
:---------------------------------------


REM ============================================================================
     IF EXIST "_LNG\english.lng" GOTO _LNG_YES
REM ============================================================================


:_LNG_NOT


REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     CLS
REM ----------------------------------------------------------------------------
     
     COLOR 04
     TITLE ERROR - TROUBLE - ISSUE
     
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO                            - LANG FILE'S NOT FOUND -
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     
     PAUSE >NUL
     EXIT /B

REM ----------------------------------------------------------------------------


:_LNG_YES


     IF EXIST "_LNG\lang" (
          REM  команда установит переменную окружения language в значение russian или english в зависимости от содержимого файла lang
          FOR /F "USEBACKQ TOKENS=1* DELIMS==" %%a IN ("_LNG\lang") DO SET %%a=%%b
     ) ELSE (
          REM если текущая кодовая страница консоли - это 866 (русский язык), то переменная language устанавливается в russian. В противном случае language устанавливается в english
          FOR /F "DELIMS=" %%a IN ('CHCP') DO SET x=%%a
	  IF NOT !x!==!x:866=! (SET language=russian) ELSE (SET language=english)
     )

     CALL :__language

     IF NOT EXIST "_LNG\lang" (
	  CALL :setlanguage
     )


:---------------------------------------
:_LNK
:---------------------------------------


REM ============================================================================
     SET "DESKTOP_FOLDER=%USERPROFILE%\DESKTOP"
REM ----------------------------------------------------------------------------
     MKDIR "%DESKTOP_FOLDER%\INST-APK" >NUL 2>&1
     ECHO [.ShellClassInfo] > "%DESKTOP_FOLDER%\INST-APK\desktop.ini"
     ECHO IconFile=!NFF_HME!_KRN\INST-APK.ICO >> "%DESKTOP_FOLDER%\INST-APK\desktop.ini"
     ECHO IconIndex=0 >> "%DESKTOP_FOLDER%\INST-APK\desktop.ini"
     ECHO InfoTip=!str_tips_inapk! >> "%DESKTOP_FOLDER%\INST-APK\desktop.ini"
     ATTRIB +S "%DESKTOP_FOLDER%\INST-APK" >NUL 2>&1
REM ----------------------------------------------------------------------------
     MKDIR "%DESKTOP_FOLDER%\MEDIA" >NUL 2>&1
     ECHO [.ShellClassInfo] > "%DESKTOP_FOLDER%\MEDIA\desktop.ini"
     ECHO IconFile=!NFF_HME!_KRN\MEDIA.ICO >> "%DESKTOP_FOLDER%\MEDIA\desktop.ini"
     ECHO IconIndex=0 >> "%DESKTOP_FOLDER%\MEDIA\desktop.ini"
     ECHO InfoTip=!str_tips_media! >> "%DESKTOP_FOLDER%\MEDIA\desktop.ini"
     ATTRIB +S "%DESKTOP_FOLDER%\MEDIA" >NUL 2>&1
REM ----------------------------------------------------------------------------
     SET "TargetFile=%~f0"
     SET "ShortcutFile=%USERPROFILE%\DESKTOP\N-R-Z.LNK"
     SET "IconFile=%~dp0_KRN\N-R-Z.ICO"
     SET "WorkingDirectory=%~dp0"
     SET "Description=!str_shcut_desc!"
REM ----------------------------------------------------------------------------     
     ECHO Set oWS = WScript.CreateObject("WScript.Shell") > CRSH.VBS
     ECHO sLinkFile = "%ShortcutFile%" >> CRSH.VBS
     ECHO Set oLink = oWS.CreateShortcut(sLinkFile) >> CRSH.VBS
     ECHO oLink.TargetPath = "%TargetFile%" >> CRSH.VBS
     ECHO oLink.IconLocation = "%IconFile%" >> CRSH.VBS
     ECHO oLink.WorkingDirectory = "%WorkingDirectory%" >> CRSH.VBS
     ECHO oLink.Description = "%Description%" >> CRSH.VBS
     ECHO oLink.Save >> CRSH.VBS
REM  CSCRIPT //B //Nologo "CRSH.VBS" >NUL 2>&1
     DEL /F /Q CRSH.VBS >NUL 2>&1
REM ============================================================================


:---------------------------------------


:_IN_0

    
     IF NOT EXIST "CUR.IPA" (
          GOTO CONN_SECTION
     )


:_IN_1


     SET /P _NFF_I=<CUR.IPA

     ECHO %_NFF_I% | FINDSTR /C:"192.168." >NUL

     IF errorlevel 1 (
          DEL /F /Q CUR.IPA >NUL 2>&1 
     ) ELSE (
          SET "_NFF_I=%_NFF_I: =%"
          SET "_NFF_I=%_NFF_I:	=%"
          GOTO CONN_SECTION
     )


:---------------------------------------


:---------------------------------------
:CONN_SECTION
:---------------------------------------


:_IP_QUERY


:_TST_FILE


     IF NOT EXIST "CUR.IPA" (
          GOTO _IP_INP
     )


:_IP_FLE


     SET /P _NFF_I=<CUR.IPA 
     SET "_NFF_I=%_NFF_I: =%"
     SET "_NFF_I=%_NFF_I:	=%"

     GOTO _TRY_CONN


:_IP_INP     
 

REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 08
     TITLE - NEW CONNECT -

     CLS

     ECHO.
     "!CE!" {80} {00} {80} CONNECT {#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"   !str_ip_1!
     "!CE!"   !str_ip_2!
     "!CE!"   !str_ip_3!
     "!CE!"   !str_ip_4!
     "!CE!"   !str_ip_5!
     "!CE!"   !str_ip_6!
     "!CE!"   !str_ip_7!
     "!CE!"   !str_ip_8!
     "!CE!"   !str_ip_9!
     ECHO.

     SET /P _NFF_I="|   "
REM  SET /P _NFF_I="|   " || SET "_NFF_I=USB"


:_TRY_CONN


:: -----------------------------------------------
     SET "title_text=CONNECT" & CALL :_WAI
:: -----------------------------------------------


     _BIN\ADB.EXE kill-server      >NUL 2>&1
     TASKKILL /F /IM ADB.EXE       >NUL 2>&1

     _BIN\ADB.EXE devices          >NUL 2>&1

     PING -n 3 127.0.0.1           >NUL

     ECHO %_NFF_I% | FINDSTR /C:"192.168." >NUL
     IF ERRORLEVEL 1 GOTO _NIP


:_YIP


     SET "_NFF_I=%_NFF_I: =%"
     SET "_NFF_I=%_NFF_I:	=%"

     _BIN\ADB.EXE tcpip 5555       >NUL 2>&1
     PING -n 5 127.0.0.1           >NUL
     _BIN\ADB.EXE connect !_NFF_I! >NUL 2>&1

     GOTO _TST_CONN


:_NIP


     SET "_NFF_I="
     DEL /F /Q CUR.IPA             >NUL 2>&1 


:_TST_MOR


     SET "state="
     SET "ERR_mor="

     FOR /f "delims=" %%i IN (' _BIN\ADB.EXE -s "%_NFF_I%" get-state 2^>^&1 ') DO (
          SET "state=%%i"
          GOTO :FIN
     )


:FIN


     ECHO "!state!" | FIND /i "more than"    >NUL && (SET "ERR_mor=1")

     IF "%ERR_mor%"=="1" (
          GOTO _ERR_MORE
     )

     IF "%_NFF_I%" == "" (
          SET "_NFF_I="
          DEL /F /Q CUR.IPA        >NUL 2>&1
          GOTO _ERR_EMPT
     ) 


:_TST_CONN


:: -----------------------------------------------
     SET "title_text=CONNECT" & CALL :_WAI
:: -----------------------------------------------

     SET "state="

     SET "ERR_err="
     SET "ERR_off="
     SET "ERR_nod="
     SET "ERR_not="
     SET "ERR_una="

     FOR /f "delims=" %%i IN (' _BIN\ADB.EXE -s "%_NFF_I%" get-state 2^>^&1 ') DO (
          SET "state=%%i"
          GOTO :DONE
     )


:---------------------------------------


:DONE


     ECHO "!state!" | FIND /i "error"        >NUL && (SET "ERR_err=1")
     ECHO "!state!" | FIND /i "offline"      >NUL && (SET "ERR_off=1")
     ECHO "!state!" | FIND /i "no devices"   >NUL && (SET "ERR_nod=1")
     ECHO "!state!" | FIND /i "not found"    >NUL && (SET "ERR_not=1")
     ECHO "!state!" | FIND /i "unauthorized" >NUL && (SET "ERR_una=1")

     IF NOT "%ERR_err%"=="1" GOTO _NRM_CONN


:---------------------------------------


:_ERR


     IF "%ERR_off%"=="1" (
          GOTO _ERR_CONN
     )

     IF "%ERR_nod%"=="1" (
          GOTO _ERR_CONN
     )

     IF "%ERR_not%"=="1" (
          GOTO _ERR_CONN
     )

     IF "%ERR_una%"=="1" (
          GOTO _ERR_AUTH
     )


:_ERR_CONN
REM ============================================================================
     SET "_NFF_I="
REM ----------------------------------------------------------------------------
     DEL /F /Q CUR.IPA        >NUL 2>&1  
REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 04
     TITLE - ERROR - TROUBLE - ISSUE -

     CLS

     ECHO.
     "!CE!" !str_ec_0!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" !str_ec_a!
     "!CE!" !str_ec_b!
     "!CE!" !str_ec_c!
     "!CE!" !str_ec_d!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"   !str_ec_1!
     "!CE!"   !str_ec_2!
     "!CE!"   !str_ec_3!
     "!CE!"   !str_ec_4!
     "!CE!"   !str_ec_5!
     "!CE!"   !str_ec_6!
     "!CE!"   !str_ec_7!
     "!CE!"   !str_ec_8!
     "!CE!"   !str_ec_9!
     ECHO.
REM ----------------------------------------------------------------------------
     SET /P _NFF_I="|   "
REM  SET /P _NFF_I="|   " || SET "_NFF_I=USB"
REM ----------------------------------------------------------------------------
     IF NOT "%_NFF_I%" == "" ( 
          SET "_NFF_I=%_NFF_I: =%"
          SET "_NFF_I=%_NFF_I:	=%"
     )
REM ----------------------------------------------------------------------------
     GOTO _TRY_CONN
REM ============================================================================
EXIT /B


:_ERR_MORE
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 08
     TITLE - ERROR - TROUBLE - ISSUE -

     CLS

REM ---------------------------------------------------------------------------- 
     SET "_NFF_I="
REM ---------------------------------------------------------------------------- 
     _BIN\ADB.EXE devices     >NUL 2>&1
REM ----------------------------------------------------------------------------  
     DEL /F /Q _BIN\*.MOR     >NUL 2>&1
REM ----------------------------------------------------------------------------  
     _BIN\ADB.EXE devices | FINDSTR /v "list of" | FINDSTR /v "offline" | FINDSTR /v "192." > _BIN\LST.MOR
REM ---------------------------------------------------------------------------- 

REM ---------------------------------------------------------------------------- 
     MODE CON:COLS=80 LINES=29
REM ---------------------------------------------------------------------------- 
     CLS
REM ---------------------------------------------------------------------------- 

     ECHO.
     "!CE!" !str_em_1!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" !str_em_2!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.     
     ECHO.   
     "!CE!" !str_em_3!
     "!CE!" !str_em_a!
     ECHO.
     
     SET count=0
     SET "choice_options="
     FOR /F %%A IN (_BIN\LST.MOR) DO (
          SET /a count+=1
          SET "options[!count!]=%%A"
          SET choice_options=!choice_options!!count!
     )

     SET /a empty_count=5-count

     FOR /L %%A in (1,1,!count!) DO ECHO    [%%A] !options[%%A]!
     FOR /L %%A in (1,1,!empty_count!) DO ECHO.

     CHOICE /c:!choice_options! /n

     CLS

REM ----------------------------------------------------------------------------

REM ----------------------------------------------------------------------------
     SET _NFF_I=!options[%errorlevel%]!
REM ----------------------------------------------------------------------------
     SET "_NFF_I=%_NFF_I: =%"
     SET "_NFF_I=%_NFF_I:	=%"
     SET "_NFF_I=%_NFF_I:device=%"
REM ----------------------------------------------------------------------------     
     DEL /F /Q _BIN\*.MOR     >NUL 2>&1
REM ----------------------------------------------------------------------------
     DEL /F /Q CUR.IPA        >NUL 2>&1
REM ----------------------------------------------------------------------------
     GOTO _TST_CONN
REM ============================================================================
EXIT /B


:_ERR_EMPT
REM ============================================================================

REM ---------------------------------------------------------------------------- 
     SET "_NFF_I="
REM ---------------------------------------------------------------------------- 
     _BIN\ADB.EXE devices     >NUL 2>&1
REM ----------------------------------------------------------------------------  
     DEL /F /Q _BIN\*.MOR     >NUL 2>&1
REM ----------------------------------------------------------------------------  
     _BIN\ADB.EXE devices | FINDSTR /v "list of" | FINDSTR /v "offline" | FINDSTR /v "192." > _BIN\LST.MOR
REM ---------------------------------------------------------------------------- 
     FOR /F %%A IN (_BIN\LST.MOR) DO (
          SET "_NFF_I=%%A"
     )
REM ----------------------------------------------------------------------------     
     DEL /F /Q _BIN\*.MOR     >NUL 2>&1
REM ----------------------------------------------------------------------------
     DEL /F /Q CUR.IPA        >NUL 2>&1
REM ----------------------------------------------------------------------------
     GOTO _TST_CONN
REM ============================================================================
EXIT /B


:_ERR_AUTH
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 08
     TITLE - ERROR - TROUBLE - ISSUE -

     CLS

     ECHO.
     "!CE!" !str_ea_0!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"  !str_ea_a!
     "!CE!"  !str_ea_b!
     "!CE!"  !str_ea_c!
     "!CE!"  !str_ea_d!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"   !str_ea_1!
     "!CE!"   !str_ea_2!
     "!CE!"   !str_ea_3!
     "!CE!"   !str_ea_4!
     "!CE!"   !str_ea_5!
     "!CE!"   !str_ea_6!
     "!CE!"   !str_ea_7!
     "!CE!"   !str_ea_8!
     "!CE!"   !str_ea_9!
     ECHO.
REM ----------------------------------------------------------------------------
     SET /P _NFF_I="|   "
REM  SET /P _NFF_I="|   " || SET "_NFF_I=USB"
REM ----------------------------------------------------------------------------
     IF NOT "%_NFF_I%" == "" (
          SET "_NFF_I=%_NFF_I: =%"
          SET "_NFF_I=%_NFF_I:	=%"
     )
REM ----------------------------------------------------------------------------
     DEL /F /Q CUR.IPA        >NUL 2>&1
REM ----------------------------------------------------------------------------
     GOTO _TRY_CONN
REM ============================================================================
EXIT /B


:---------------------------------------


REM ============================================================================
:_NRM_CONN
REM ============================================================================

     SET "title_text=CONNECT" & CALL :_WAI

     <NUL SET /P strTemp=%_NFF_I%>CUR.SER

     ECHO %_NFF_I% | FINDSTR /C:"192.168." >NUL
     IF ERRORLEVEL 1 (
          DEL /F /Q CUR.IPA   >NUL 2>&1 
     ) ELSE (
          <NUL SET /P strTemp=%_NFF_I%>CUR.IPA

     )

REM ==================================================================
REM --- TURN OFF - GOOGLE PLAY VERIFY ---
REM ==================================================================

     _BIN\ADB.EXE -s "%_NFF_I%" shell " settings put global package_verifier_enable 0 ; settings put global package_verifier_user_consent -1 ; settings put global upload_apk_enable 0 " >NUL 2>&1

REM ==================================================================
REM --- PUSH FILE'S FROM "_PUS" FOLDER ---
REM ==================================================================

     CD /D "!NFF_HME!_PUS"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/"             >NUL 2>&1

REM ==================================================================
REM --- PUSH SH+ELF FROM "_SHS" FOLDER ---
REM ==================================================================

     CD /D "!NFF_HME!_SHS"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/data/local/tmp/"     >NUL 2>&1

REM ==================================================================
REM --- GRANT SH+ELF IN "/data/local/tmp/" FOLDER ---
REM ==================================================================
     
     CD /D "!NFF_HME!
     _BIN\ADB.EXE -s "%_NFF_I%" shell "chmod -R 777 /data/local/tmp/*" >NUL 2>&1

REM ==================================================================
REM --- MAIN CONF ---
REM ==================================================================

     _BIN\ADB.EXE -s "%_NFF_I%" shell "sh /data/local/tmp/mai.sh"      >NUL 2>&1

REM ==================================================================
REM --- GET DEVICE INFO ---
REM ==================================================================

     _BIN\ADB.EXE -s "%_NFF_I%" shell getprop > %TEMP%\PRP.TXT
     
     SET "_MNF="
     SET "_MDL="
     SET "_NAM="
     SET "_SNO="
     SET "_SDK="
     SET "_FRW="
     SET "_FWA="
     SET "_FWB="
     
     FOR /f "tokens=*" %%a IN ('type %TEMP%\PRP.TXT') DO (
     
          SET "line=%%a"
     
          IF "!line:ro.product.manufacturer=!" NEQ "!line!" SET "_MNF=!line!"
          IF "!line:ro.product.model=!" NEQ "!line!" SET "_MDL=!line!"
          IF "!line:ro.product.device=!" NEQ "!line!" SET "_NAM=!line!"
          IF "!line:ro.serialno=!" NEQ "!line!" SET "_SNO=!line!"
          IF "!line:ro.build.version.sdk=!" NEQ "!line!" SET "_SDK=!line!"
          IF "!line:ro.build.version.name=!" NEQ "!line!" SET "_FRW=!line!"
          IF "!line:ro.build.id=!" NEQ "!line!" SET "_FWA=!line!"
          IF "!line:ro.build.version.incremental=!" NEQ "!line!" SET "_FWB=!line!"
     
     )
     
     IF NOT "%_MNF%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_MNF!") DO SET "_MNF=%%a"
     IF NOT "%_MDL%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_MDL!") DO SET "_MDL=%%a"
     IF NOT "%_NAM%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_NAM!") DO SET "_NAM=%%a"
     IF NOT "%_SNO%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_SNO!") DO SET "_SNO=%%a"
     IF NOT "%_SDK%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_SDK!") DO SET "_SDK=%%a"
     IF NOT "%_FRW%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_FRW!") DO SET "_FRW=%%a"
     IF NOT "%_FWA%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_FWA!") DO SET "_FWA=%%a"
     IF NOT "%_FWB%"=="" FOR /f "tokens=3 delims=][" %%a IN ("!_FWB!") DO SET "_FWB=%%a"

REM ==================================================================
REM --- FIRMWARE FORMAT: FW + BUILD ---
REM ==================================================================

     IF /i "%_MNF%"=="AMAZON" (

REM ECHO AMAZON - '%_MNF%'
REM PAUSE

          FOR /f "tokens=3 delims= " %%a IN ("!_FRW!") DO SET "_FWA=%%a"
          SET "_FWA=!_FWA:.=!"
          
          FOR /f "tokens=4 delims= " %%a IN ("!_FRW!") DO SET "_FWB=%%a"
          SET "_FWB=!_FWB:~1!"
          SET "_FWB=!_FWB:~0,-1!"
          
          IF not "!_FWB:/=!"=="%_FWB%" FOR /f "tokens=2 delims=/" %%a IN ("!_FWB!") DO SET "_FWB=%%a"

     ) ELSE (

REM ECHO NOT AMAZON - '%_MNF%'
REM PAUSE

     )

REM ==================================================================
REM --- INST KEY OPT FOR SDK 22 OR MORE ---
REM ==================================================================


     IF %_SDK% LEQ 22 (
          SET "INS_OPT=-d -r"
          SET "NEE_PRM=1"
     ) ELSE (
          SET "INS_OPT=-d -r -g"
          SET "NEE_PRM=0"
     )

REM ============================================================================


:---------------------------------------


REM ============================================================================
:_TST_FRW
REM ============================================================================

REM ==================================================================
REM --- FIX - FIX - FIX ---
REM ==================================================================

REM ----------------------------------------------------------------------------
     SET "var_ERR_HW=0"
REM ----------------------------------------------------------------------------
REM  ECHO %_MNF% | FINDSTR /i /c:"AMAZON" >NUL 2>&1
REM  IF ERRORLEVEL 1 SET "var_ERR_HW=1" & CALL :_ERR_DVC & GOTO MODE_SELECT_MENU
REM ----------------------------------------------------------------------------
     IF /i NOT "%_MNF%"=="AMAZON" SET "var_ERR_HW=1" & CALL :_ERR_DVC & GOTO MODE_SELECT_MENU
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" CALL :_OTF_ & CALL :_AMZ_WIN & GOTO MODE_SELECT_MENU
REM ----------------------------------------------------------------------------


REM ----------------------------------------------------------------------------
     SET "var_ERR_FW=0"
REM ----------------------------------------------------------------------------
REM     IF %_SDK% LEQ 22 SET "var_ERR_FW=1" & GOTO MODE_SELECT_MENU
REM ----------------------------------------------------------------------------
REM     ECHO %_MDL% | FINDSTR /ir /c:"AFTN" /c:"AFTA" /c:"AFTMM" >NUL 2>&1
REM     IF %ERRORLEVEL% EQU 0 IF %_FWA% LEQ 6281 (SET "var_ERR_FW=0" & CALL :_OTF & GOTO MODE_SELECT_MENU) ELSE (SET "var_ERR_FW=1" & CALL :_OTF & GOTO MODE_SELECT_MENU)
REM ----------------------------------------------------------------------------
REM     ECHO %_MDL% | FINDSTR /ir /c:"AFTR" /c:"AFTSS" /c:"AFTSSS" /c:"AFTKA" /c:"AFTGAZL" >NUL 2>&1
REM     IF %ERRORLEVEL% EQU 0 IF %_FWA% LEQ 7255 (SET "var_ERR_FW=0" & CALL :_OTF & GOTO MODE_SELECT_MENU) ELSE (SET "var_ERR_FW=1" & CALL :_OTF & GOTO MODE_SELECT_MENU)
REM ----------------------------------------------------------------------------
REM     ECHO %_MDL% | FINDSTR /ir /c:"AFTKM" /c:"AFTKRT" >NUL 2>&1
REM     IF %ERRORLEVEL% EQU 0 SET "var_ERR_FW=1" & GOTO MODE_SELECT_MENU
REM ----------------------------------------------------------------------------
     SET "var_ERR_FW=1" & GOTO MODE_SELECT_MENU
REM ============================================================================


:=======================================


:=======================================


:MODE_SELECT_MENU
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     SET "CUR_MOD=0"

     COLOR 02
     TITLE - !str_mde_ttl! -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO  !str_mde_mnu!
     "!CE!" !str_mde_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mde_wiz!"
     SET "PAR03=   !str_mde_cst!"
     SET "PAR04=    --------------------------------------------"
     SET "PAR05=   !str_mde_kot!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mde_adb!"
     SET "PAR08=   !str_mde_cmd!"
     SET "PAR09=    --------------------------------------------"
     SET "PAR10=   !str_mde_pat!"
     SET "PAR11=    --------------------------------------------"
     SET "PAR12=   !str_mde_lng!"
     SET "PAR13=    --------------------------------------------"
     SET "PAR14=   !str_mde_dis!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "2"  (SET "CUR_MOD=1" & GOTO _WIZ)
     IF /i "%ERRORLEVEL%" == "3"  (SET "CUR_MOD=2" & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "4"  (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "5"  (SET "CUR_MOD=3" & CALL :_KOT & GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "7"  (SET "CUR_MOD=4" & START "" "_BIN\_SHL.BAT" !NFF_HME! !_NFF_I! & GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "8"  (SET "CUR_MOD=5" & START "" "_BIN\_CLI.BAT" !NFF_HME! & GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "9"  (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "10" (SET "CUR_MOD=6" & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "11" (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "12" (DEL /F /S /Q "_LNG\lang" >NUL 2>&1 & GOTO _LNG)
     IF /i "%ERRORLEVEL%" == "13" (GOTO MODE_SELECT_MENU)
     IF /i "%ERRORLEVEL%" == "14" (CALL :_DIS & GOTO _IP_INP)

REM ============================================================================
     GOTO MODE_SELECT_MENU
REM ============================================================================


:=======================================






:=======================================


:MODE_SECTION


:=======================================


:---------------------------------------


:_WIZ

REM ============================================================================
     CALL :UNI_MNU_XN
REM ----------------------------------------------------------------------------

     CALL :_UOF
     
     IF /i "%_MNF%"=="AMAZON" CALL :_OTF_ 
     IF /i "%_MNF%"=="AMAZON" CALL :_ADW & CALL :_LIV
     
     CALL :_CLE_DIS & CALL :_RES_LAU
     
     CALL :_SUI_OF
     
     IF /i "%_MNF%"=="AMAZON" CALL :_LOC
     
     CALL :_FSK
     
     IF /i "%_MNF%"=="AMAZON" CALL :_KAT
     
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% GEQ 25 CALL :_GACC
     
     CALL :_BASE
     
     CALL :_FLE_A
     
     CALL :_FTP
     
     IF /i "%_MNF%"=="AMAZON" CALL :_RUN
     
     CALL :TUB_MNU_XN
     CALL :IPT_MNU_XN
     CALL :PLY_MNU_XN
     
     CALL :TOR_MNU_XN
     CALL :_OTH_XN
     
     IF /i "%_MNF%"=="AMAZON" IF %_FWA% GEQ 8100 SET "TT=AMBIENT" & SET "FF=_UPD\" & SET "FL=*ftvambient*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
     
     CALL :SCR_MNU_XN
     
     IF /i "%_MNF%"=="AMAZON" CALL :LAU_MNU_XN
     IF /i "%_MNF%"=="AMAZON" CALL :_SEL_LAU

REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------

     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "com.amazon.tv.leanbacklauncher" >NUL 2>&1
     IF %ERRORLEVEL% EQU 0 CALL :_DRW_XN

REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     
     CALL :_CFG

REM     FOR /R "_PUS\" %%i IN (*.*) DO _BIN\ADB.EXE -s "%_NFF_I%" push "%%i" /sdcard/%%~nxi >NUL 2>&1

     CALL :_GRA
     CALL :_RES_LAU

REM  CALL :_ENQ
REM  GOTO _IP_INP

REM ----------------------------------------------------------------------------
     GOTO MODE_SELECT_MENU
REM ============================================================================


:---------------------------------------


:---------------------------------------


:_KOT
REM ============================================================================
     START "" /B "_BIN\AHK.EXE" /FORCE "_KOT\_KOT.AHK"
REM ============================================================================
EXIT /B


:---------------------------------------


:---------------------------------------


:_DIS
REM ============================================================================
     SET "title_text=DISCONNECT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     SET "_NFF_I="
REM ----------------------------------------------------------------------------
     DEL /F /Q *.TMP                                                  >NUL 2>&1
     _BIN\ADB.EXE kill-server                                         >NUL 2>&1
     TASKKILL /F /IM ADB.EXE                                          >NUL 2>&1
REM ----------------------------------------------------------------------------
     START "" /B /WAIT "_BIN\AHK.EXE" /FORCE "_BIN\_UOF.AHK"
REM ----------------------------------------------------------------------------
     TASKKILL /F /IM AAPT.EXE                                         >NUL 2>&1
     TASKKILL /F /IM AAPT2.EXE                                        >NUL 2>&1
     TASKKILL /F /IM ADB.EXE                                          >NUL 2>&1
     TASKKILL /F /IM CECHO.EXE                                        >NUL 2>&1
     TASKKILL /F /IM CMDMENUSEL.EXE                                   >NUL 2>&1
     TASKKILL /F /IM FASTBOOT.EXE                                     >NUL 2>&1
     TASKKILL /F /IM PYTHON.EXE                                       >NUL 2>&1
     TASKKILL /F /IM PYTHONW.EXE                                      >NUL 2>&1
     TASKKILL /F /IM SCRCPY.EXE                                       >NUL 2>&1
REM ----------------------------------------------------------------------------
     PING -n 5 127.0.0.1 >NUL
REM ----------------------------------------------------------------------------
     CALL :_LAT
REM ============================================================================
EXIT /B


:---------------------------------------


:=======================================



:=======================================


:CST_SEL_MNU
REM ============================================================================
     MODE CON:COLS=80 LINES=44
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - !str_cst_ttl! -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO  !str_cst_mnu!
     "!CE!"  !str_cst_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_cst_uni!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_cst_oth!"
     SET "PAR05=    --------------------------------------------"
     SET "PAR06=   !str_cst_lvl!"
     SET "PAR07=    --------------------------------------------"
     SET "PAR08=   !str_cst_lau!"
     SET "PAR09=    --------------------------------------------"
     SET "PAR10=   !str_cst_loc!"
     SET "PAR11=   !str_cst_key!"
     SET "PAR12=   !str_cst_kat!"
     SET "PAR13=    --------------------------------------------"
     SET "PAR14=   !str_cst_stt!"
     SET "PAR15=    --------------------------------------------"
     SET "PAR16=   !str_cst_fle!"
     SET "PAR17=   !str_cst_drw!"
     SET "PAR18=    --------------------------------------------"
     SET "PAR19=   !str_cst_scr!"
     SET "PAR20=    --------------------------------------------"
     SET "PAR21=   !str_cst_ftp!"
     SET "PAR22=    --------------------------------------------"
     SET "PAR23=   !str_cst_run!"
     SET "PAR24=    --------------------------------------------"
     SET "PAR25=   !str_cst_dln!"
     SET "PAR26=   !str_cst_rad!"
     SET "PAR27=    --------------------------------------------"
     SET "PAR28=   !str_cst_tub!"
     SET "PAR29=   !str_cst_ipt!"
     SET "PAR30=   !str_cst_ply!"
     SET "PAR31=    --------------------------------------------"
     SET "PAR32=   !str_cst_tor!"
     SET "PAR33=    --------------------------------------------"
     SET "PAR34= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%" "%PAR15%" "%PAR16%" "%PAR17%" "%PAR18%" "%PAR19%" "%PAR20%" "%PAR21%" "%PAR22%" "%PAR23%" "%PAR24%" "%PAR25%" "%PAR26%" "%PAR27%" "%PAR28%" "%PAR29%" "%PAR30%" "%PAR31%" "%PAR32%" "%PAR33%" "%PAR34%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_UNI & CALL :_RES_LAU & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_OTH_XC & CALL :_RES_LAU & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "5"  (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :LVL_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "7"  (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "8"  (CALL :LAU_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "9"  (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "10" (CALL :_LOC & GOTO CST_SEL_MNU)      
     IF /i "%ERRORLEVEL%" == "11" (CALL :KEY_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "12" (CALL :KAT_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "13" (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "14" (CALL :STT_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "15" (GOTO CST_SEL_MNU)  
     IF /i "%ERRORLEVEL%" == "16" (CALL :FLE_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "17" (CALL :DRW_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "18" (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "19" (CALL :SCR_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "20" (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "21" (CALL :_FTP & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "22" (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "23" (CALL :_RUN & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "24" (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "25" (CALL :DLN_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "26" (CALL :RAD_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "27" (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "28" (CALL :TUB_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "29" (CALL :IPT_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "30" (CALL :PLY_MNU_XC & GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "31" (GOTO CST_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "32" (CALL :_TOR & GOTO CST_SEL_MNU) 
     IF /i "%ERRORLEVEL%" == "33" (GOTO CST_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "34" (GOTO MODE_SELECT_MENU)     

REM ============================================================================
     GOTO MODE_SELECT_MENU
REM ============================================================================


:=======================================


:=======================================


:PAT_SEL_MNU
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - PATCH MENU -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO  !str_pat_mnu!
     "!CE!" !str_pat_inf! 
     ECHO.

     SET "PAR01=    ------------------------------------------------"
     SET "PAR02=   !str_pat_tvq!"
     SET "PAR03=    ------------------------------------------------"
     SET "PAR04=   !str_pat_but!"
     SET "PAR05=    ------------------------------------------------"
     SET "PAR06=   !str_pat_tzk!"
     SET "PAR07=    ------------------------------------------------"
     SET "PAR08=   !str_pat_key!"
     SET "PAR09=   !str_pat_mou!"
     SET "PAR10=    ------------------------------------------------"
     SET "PAR11=   !str_pat_sui!"
     SET "PAR12=    ------------------------------------------------"
     SET "PAR13=   !str_pat_thm!"
     SET "PAR14=    ------------------------------------------------"
     SET "PAR15=   !str_pat_upd!"
     SET "PAR16=    ------------------------------------------------"
     SET "PAR17= !str_exi!"

REM  SET "PAR13=   !str_pat_vol!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%" "%PAR15%" "%PAR16%" "%PAR17%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_TVQ & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :BUT_MNU_XP & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "5"  (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_TZK & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "7"  (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "8" (CALL :_EXT_KEY & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "9" (CALL :MOU_MNU & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "10" (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "11" (CALL :SUI_MNU & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "12"  (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "13"  (CALL :THM_MNU & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "14" (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "15" (CALL :_UPD & GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "16" (GOTO PAT_SEL_MNU)
     IF /i "%ERRORLEVEL%" == "17" (GOTO MODE_SELECT_MENU)

REM  IF /i "%ERRORLEVEL%" == "13" (CALL :_SYS_VOL & GOTO PAT_SEL_MNU)

REM ============================================================================
     GOTO MODE_SELECT_MENU
REM ============================================================================


:=======================================


:BUT_MNU_XP
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - COLOR BUTTON'S -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_but_mnu!:
     "!CE!"  !str_mnu_but_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_but_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_but_dny!"
     SET "PAR05=   !str_mnu_but_hlu!"
     SET "PAR06=   !str_mnu_but_nfx!"
     SET "PAR07=   !str_mnu_but_ctv!"
     SET "PAR08=   !str_mnu_but_cra!"
     SET "PAR09=   !str_mnu_but_pea!"
     SET "PAR10=   !str_mnu_but_dtv!"
     SET "PAR11=    --------------------------------------------"
     SET "PAR12= !str_pre!"
     SET "PAR13= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO BUT_MNU_XP)                                 
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_BUT_M_DEL & GOTO BUT_MNU_XP)               
     IF /i "%ERRORLEVEL%" == "3"  (GOTO BUT_MNU_XP)                                 
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_BUT_M_DNY & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_BUT_M_HLU & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_BUT_M_NFX & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_BUT_M_CTV & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "8"  (CALL :_BUT_M_CRA & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_BUT_M_PEA & GOTO BUT_MNU_XP)             
     IF /i "%ERRORLEVEL%" == "10" (CALL :_BUT_M_DTV & GOTO BUT_MNU_XP) 
     IF /i "%ERRORLEVEL%" == "11" (GOTO BUT_MNU_XP)                                 
     IF /i "%ERRORLEVEL%" == "12" (GOTO PAT_SEL_MNU)                               
     IF /i "%ERRORLEVEL%" == "13" (GOTO MODE_SELECT_MENU)                               

REM ============================================================================
EXIT /B


:_BUT_M_DEL
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*remap*.APK" & SET "II=0" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_DNY
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*disney*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_HLU
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*hulu*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_NFX
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*netflix*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_CTV
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*ctv*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_CRA
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*crave*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_PEA
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*pea*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:_BUT_M_DTV
REM ============================================================================
     SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*direct*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK 
REM ============================================================================
EXIT /B


:---------------------------------------


:_TVQ
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     SET "TT=TVQA" & SET "FF=_PAT\_TVQ\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------   
     _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/_TVQ/ ; mkdir sdcard/_TVQ"                                                                 >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  FOR /R "_PAT\_TVQ\" %%f IN (*.zip) DO _BIN\ADB.EXE -s "%_NFF_I%" push "%%f" "/sdcard/_TVQ/"                                                 >NUL 2>&1
REM ----------------------------------------------------------------------------  
     CD /D "!NFF_HME!_PAT\_TVQ\CFG"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/_TVQ/"                                                                                  >NUL 2>&1
     CD /D "!NFF_HME!
REM ----------------------------------------------------------------------------  
     _BIN\ADB.EXE -s "%_NFF_I%" shell "dumpsys deviceidle whitelist +dev.vodik7.tvquickactions"                                                  >NUL 2>&1
REM ============================================================================
EXIT /B


:---------------------------------------


:_TZK
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     SET "TT=TASKER" & SET "FF=_PAT\_TZK\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm grant net.dinglisch.android.taskerm android.permission.PACKAGE_USAGE_STATS" >NUL 2>&1
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/Tasker/ ; mkdir sdcard/Tasker sdcard/Tasker/profiles sdcard/Tasker/tasks sdcard/Tasker/configs sdcard/Tasker/configs/user"    >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" push  "_PAT\_TZK\LITE.xml" "/sdcard/Tasker/configs/user/"                                                        >NUL 2>&1
REM  FOR /R "_PAT\_TZK\" %%f IN (*.xml) DO _BIN\ADB.EXE -s "%_NFF_I%" push "%%f" "/sdcard/Tasker/configs/user/"                                  >NUL 2>&1
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!_PAT\_TZK\XML\CFG"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/Tasker/configs/user/"                                                                   >NUL 2>&1
     CD /D "!NFF_HME!
REM ----------------------------------------------------------------------------
REM     CD /D "!NFF_HME!_PAT\_TZK\XML\PRF"
REM     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/Tasker/profiles/"                                                                   >NUL 2>&1
REM     CD /D "!NFF_HME!
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!_PAT\_TZK\XML/TSK"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/Tasker/tasks/"                                                                   >NUL 2>&1
     CD /D "!NFF_HME!
REM ----------------------------------------------------------------------------

REM  IF %CUR_MOD% EQU 6 _BIN\ADB.EXE -s "%_NFF_I%" shell "am start -n 'net.dinglisch.android.taskerm/net.dinglisch.android.taskerm.Tasker'"      >NUL 2>&1
REM  IF %CUR_MOD% EQU 6 _BIN\ADB.EXE -s "%_NFF_I%" shell "am start -n net.dinglisch.android.taskerm/com.joaomgcd.taskerm.datashare.import.ActivityImportTaskerDataFromXml -d file:///sdcard/Tasker/profiles/IF_HME_BUT.prf.xml"      >NUL 2>&1

REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " am start -n 'net.dinglisch.android.taskerm/net.dinglisch.android.taskerm.Tasker' ; sleep 5 "     >NUL 2>&1
REM ----------------------------------------------------------------------------

REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_RIGHT " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_MENU ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_DOWN KEYCODE_DPAD_DOWN KEYCODE_DPAD_DOWN  KEYCODE_DPAD_DOWN " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_DOWN " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DEL ; sleep 2 " >NUL 2>&1
REM 
REM REM      IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 (
REM REM           _BIN\ADB.EXE -s "%_NFF_I%" shell "input text TANK.xml; input keyevent KEYCODE_BACK; input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_CENTER ; sleep 1 " >NUL 2>&1
REM REM      ) ELSE (
REM REM           _BIN\ADB.EXE -s "%_NFF_I%" shell "input text AMZN.xml; input keyevent KEYCODE_BACK; input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_CENTER ; sleep 1 " >NUL 2>&1
REM REM      )
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell "input text AMZN.xml; input keyevent KEYCODE_BACK; input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_CENTER ; sleep 1 " >NUL 2>&1
REM 
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP KEYCODE_DPAD_UP " >NUL 2>&1
REM      _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM REM     _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_RIGHT " >NUL 2>&1
REM REM     _BIN\ADB.EXE -s "%_NFF_I%" shell " input keyevent KEYCODE_DPAD_CENTER ; sleep 2 " >NUL 2>&1
REM 
REM 
REM REM ----------------------------------------------------------------------------
REM REM     _BIN\ADB.EXE -s "%_NFF_I%" shell "input tap 1700 0; input tap 1900 0; input tap 960 740" >NUL 2>&1
REM REM ----------------------------------------------------------------------------
REM 
REM REM ----------------------------------------------------------------------------
REM REM     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 (
REM REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "input tap 1900 0; input tap 1900 500; input tap 1900 300; input tap 1900 100; input keyevent KEYCODE_DEL; input text TANK.xml; input keyevent KEYCODE_BACK; input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_CENTER; input tap 1700 0" >NUL 2>&1
REM REM     ) ELSE (
REM REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "input tap 1900 0; input tap 1900 500; input tap 1900 300; input tap 1900 100; input keyevent KEYCODE_DEL; input text AMZN.xml; input keyevent KEYCODE_BACK; input keyevent KEYCODE_DPAD_DOWN KEYCODE_DPAD_CENTER; input tap 1700 0" >NUL 2>&1
REM REM     )
REM REM ----------------------------------------------------------------------------
                                                                                                                                                          
REM ============================================================================
EXIT /B


:---------------------------------------
:---------------------------------------
:---------------------------------------


:MOU_MNU
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - MOUSE -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_mou_mnu!:
     "!CE!"  !str_mnu_mou_inf!  
     ECHO.

     SET "PAR01=    ---------------------------------------"
     SET "PAR02=   !str_mnu_mou_a!"
     SET "PAR03=   !str_mnu_mou_b!"
     SET "PAR04=    ---------------------------------------"
     SET "PAR05= !str_pre!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO MOU_MNU)                       
     IF /i "%ERRORLEVEL%" == "2" (CALL :_MOU_A & GOTO MOU_MNU)      
     IF /i "%ERRORLEVEL%" == "3" (CALL :_MOU_B & GOTO MOU_MNU)      
     IF /i "%ERRORLEVEL%" == "4" (GOTO MOU_MNU)                       
     IF /i "%ERRORLEVEL%" == "5" (GOTO PAT_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "6" (GOTO MODE_SELECT_MENU)                   

REM ============================================================================
EXIT /B


:---------------------------------------


:_MOU_A
REM ============================================================================
     SET "TT=MOUSE TOGGLE" & SET "FF=_PAT\_MOU\" & SET "FL=*MouseToggle*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!_PAT\_MOU\_PUS"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/data/local/tmp/"                  >NUL 2>&1
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!"
     _BIN\ADB.EXE -s "%_NFF_I%" shell "chmod -R 777 /data/local/tmp/.mousetoggle/*" >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell " cd /data/local/tmp/.mousetoggle ; ./nmouseg stop ; ./nmouseg start & " >NUL 2>&1  
REM ============================================================================
EXIT /B

:_MOU_B
REM ============================================================================
     SET "TT=MOUSE TOGGLE" & SET "FF=_PAT\_MOU\" & SET "FL=*MATVT*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " settings put secure accessibility_enabled 1 ; settings put secure enabled_accessibility_services 'io.github.virresh.matvt/.services.MouseEventService' " >NUL 2>&1  
REM ============================================================================
EXIT /B


:---------------------------------------


:_EXT_KEY
REM ============================================================================
     SET "TT=EXTKEY HELPER" & SET "FF=_PAT\_EXK\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:---------------------------------------


:SUI_MNU
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - SUI -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_sui_mnu!:
     "!CE!"  !str_mnu_sui_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_sui_of!"
     SET "PAR03=   !str_mnu_sui_on!"
     SET "PAR04=    --------------------------------------------"
     SET "PAR05= !str_pre!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO SUI_MNU)                       
     IF /i "%ERRORLEVEL%" == "2" (CALL :_SUI_OF & GOTO SUI_MNU)      
     IF /i "%ERRORLEVEL%" == "3" (CALL :_SUI_ON & GOTO SUI_MNU)      
     IF /i "%ERRORLEVEL%" == "4" (GOTO SUI_MNU)                       
     IF /i "%ERRORLEVEL%" == "5" (GOTO PAT_SEL_MNU)                   
     IF /i "%ERRORLEVEL%" == "6" (GOTO MODE_SELECT_MENU)                   

REM ============================================================================
EXIT /B


:_SUI_OF
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.android.documentsui ; pm disable-user --user 0 com.android.documentsui" >NUL 2>&1    
REM ============================================================================
EXIT /B


:_SUI_ON
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.android.documentsui ; pm enable --user 0 com.android.documentsui" >NUL 2>&1    
REM ============================================================================
EXIT /B


:---------------------------------------


:_CBU_APK
REM ==================================================================================
REM  SET "TT=COLOR BUTTON'S" & SET "FF=_PAT\_MAP\" & SET "FL=*hulu*.APK" & SET "II=1" & SET "SS=0" & CALL :_CBU_APK
REM -----------------------------------------------------------------------------
     CHCP 65001>NUL
REM -----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM -----------------------------------------------------------------------------
     setlocal

:_STA_CBU

     FOR /R "%FF%" %%f IN (%FL%) DO (

          REM -----------------------------------------------------------------------------

               CALL :UPPERCASE "%%~xnf" "apk_NAME"

               FOR /F "tokens=2 delims=: " %%j IN ('!AP! dump badging "%%f" ^| FINDSTR /r /c:"^package: name="') DO FOR /f "tokens=2 delims=='" %%k IN ("%%j") DO SET "pkg_NAME=%%k"

               FOR /F "tokens=2 delims=:'" %%g IN ('!AP! dump badging "%%f" ^| FINDSTR /c:"application-label:"') DO SET "label_EN=%%g"
               CALL :UPPERCASE "!label_EN!" "label_EN"

               FOR /F "tokens=6 delims=='" %%g IN ('!AP! dump badging "%%f" ^| FINDSTR /c:"versionName"') DO SET "app_VER=%%g"
               CALL :UPPERCASE "!app_VER!" "app_VER"

               COLOR 04
               TITLE - !TT! -

               CLS
               
               "!CE!" {\n}

               IF "%II%"=="1" (
                    "!CE!" {20} {00} {20} INSTALL {#}{\n}
               ) ELSE (
                    "!CE!" {40} {00} {40} CLEAN {#}{\n}
               )

               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!"                    !str_sta_wai!{\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}

               IF "%SS%"=="1" (
          
                    "!CE!" {\n}
                    "!CE!" {\n}
                    "!CE!" {\n}
                    "!CE!" {\n}
          
               )
          
               IF "%II%"=="1" IF "%SS%"=="0" (

                    "!CE!" {00} {06} NAM: {08}!label_EN!{\n}
                    "!CE!" {00} {06} VER: {08}!app_VER!{\n}
                    "!CE!" {00} {06} PKG: {08}!pkg_NAME!{\n}
                    "!CE!" {00} {06} APK: {08}!apk_NAME!{\n}
     
               )
     
               IF "%II%"=="0" IF "%SS%"=="0" (
         
                    "!CE!" {\n}
                    "!CE!" {00} {06} NAM: {08}!label_EN!{\n}
                    "!CE!" {00} {06} VER: {08}!app_VER!{\n}
                    "!CE!" {00} {06} PKG: {08}!pkg_NAME!{\n}
               )
     
          REM -----------------------------------------------------------------------------
               _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear !pkg_NAME! ; pm uninstall !pkg_NAME!"                    >NUL 2>&1
          REM -----------------------------------------------------------------------------
               IF "%II%"=="1" (
                    _BIN\ADB.EXE -s "%_NFF_I%" push "%%f" "/sdcard/%%~nxf"                                         >NUL 2>&1
                    _BIN\ADB.EXE -s "%_NFF_I%" shell "cp /sdcard/%%~nxf /data/local/tmp/ ; pm install -i com.amazon.venezia /data/local/tmp/%%~nxf" >NUL 2>&1
               )
          REM ----------------------------------------------------------------------------- 

     )

:_END_CBU

REM -----------------------------------------------------------------------------
     CHCP 1251>NUL
REM -----------------------------------------------------------------------------
     endlocal
REM ==================================================================================
EXIT /B


:---------------------------------------


:THM_MNU
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - COLOR THEME -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_thm_mnu!:
     "!CE!"  !str_mnu_thm_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_pat_lof_thm_gre!"
     SET "PAR03=   !str_pat_lof_thm_gld!"
     SET "PAR04=   !str_pat_lof_thm_ali!"
     SET "PAR05=    --------------------------------------------"
     SET "PAR06=   !str_pat_lof_thm_def!"
     SET "PAR07=    --------------------------------------------"
     SET "PAR08= !str_pre!"
     SET "PAR09= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO THM_MNU)                                                
     IF /i "%ERRORLEVEL%" == "2" (SET "THM_NAM=GRE" & CALL :_LOF_THM & GOTO THM_MNU)         
     IF /i "%ERRORLEVEL%" == "3" (SET "THM_NAM=GLD" & CALL :_LOF_THM & GOTO THM_MNU)         
     IF /i "%ERRORLEVEL%" == "4" (SET "THM_NAM=ALI" & CALL :_LOF_THM & GOTO THM_MNU)
     IF /i "%ERRORLEVEL%" == "5" (GOTO THM_MNU)                                                
     IF /i "%ERRORLEVEL%" == "6" (SET "THM_NAM=DEF" & CALL :_LOF_THM & GOTO THM_MNU)         
     IF /i "%ERRORLEVEL%" == "7" (GOTO THM_MNU)                                                
     IF /i "%ERRORLEVEL%" == "8" (GOTO PAT_SEL_MNU)                                            
     IF /i "%ERRORLEVEL%" == "9" (GOTO MODE_SELECT_MENU)                                            

REM ============================================================================
EXIT /B


:---------------------------------------


:_LOF_THM
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------


     SET "title_text=COLOR THEME" & CALL :_WAI


:_STA_THM


     SET "PKG_LST="

     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 > "%TEMP%\PKG_LST.TXT"
     FOR /f "tokens=2 delims=: " %%I IN (%TEMP%\PKG_LST.TXT) DO SET "PKG_LST=!PKG_LST! %%I"

REM  FOR /f "delims=" %%a IN ('_BIN\ADB.EXE shell pm list packages -3') DO SET "PKG_LST=%%a"

     IF "%PKG_LST%"=="" EXIT /B


:_THM_LOF


     ECHO !PKG_LST! | FINDSTR "com.amazon.tv.leanbacklauncher" >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B

     REM ПРОВЕРЯЕМ, ЧТО LOF УСТАНОВЛЕН
     SET "_LOF="

REM  FOR /f "tokens=2 delims== " %%I IN (' _BIN\ADB.EXE -s "%_NFF_I%" shell dumpsys package com.amazon.tv.leanbacklauncher ^| FINDSTR "versionName" ') DO SET "_LOF=%%I"
     FOR /f "tokens=2 delims== " %%I IN (' _BIN\ADB.EXE -s "%_NFF_I%" shell "dumpsys package com.amazon.tv.leanbacklauncher | grep versionName" ') DO SET "_LOF=%%I"
     
     REM ЕСЛИ НЕТ, НА ВЫХОД
     IF NOT defined _LOF EXIT /B
     
     IF "%_LOF%"=="1.32" (

          REM ЕСЛИ ВЕРСИЯ 1.32 - УДАЛИТЬ ТЕКУЩУЮ ВЕРСИЮ И ЗАМЕНИТЬ НА ВЫБРАННУЮ     
          REM -----------------------------------------------------------------------------
REM            _BIN\ADB.EXE -s "%_NFF_I%" shell "pm uninstall com.amazon.tv.leanbacklauncher" >NUL 2>&1
          REM -----------------------------------------------------------------------------
               IF "%THM_NAM%"=="DEF" (CALL :_LAU_LOF_NW) ELSE (CALL :_LAU_LOF_NW_THM)
          REM ----------------------------------------------------------------------------- 
     
     ) ELSE (
     
          REM ЕСЛИ ВЕРСИЯ 1.5X - УДАЛИТЬ ТЕКУЩУЮ ВЕРСИЮ И ЗАМЕНИТЬ НА ВЫБРАННУЮ 
          REM -----------------------------------------------------------------------------
REM            _BIN\ADB.EXE -s "%_NFF_I%" shell "pm uninstall com.amazon.tv.leanbacklauncher" >NUL 2>&1
          REM -----------------------------------------------------------------------------
               IF "%THM_NAM%"=="DEF" (CALL :_LAU_LOF_WW) ELSE (CALL :_LAU_LOF_WW_THM)
          REM ----------------------------------------------------------------------------- 
     
     )
         
                                                                       
:_THM_DSH


     REM ПРОВЕРЯЕМ, DRW DSH УСТАНОВЛЕН - ЕСЛИ НЕТ, ПРОПУСКАЕМ

          ECHO !PKG_LST! | FINDSTR "com.samabox.dashboard" >NUL 2>&1
          IF %ERRORLEVEL% EQU 1 GOTO _THM_TVA

     REM -----------------------------------------------------------------------------
REM       _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.samabox.dashboard ; pm uninstall com.samabox.dashboard" >NUL 2>&1
     REM -----------------------------------------------------------------------------
          IF "%THM_NAM%"=="DEF" (CALL :_DRW_DSH) ELSE (CALL :_DRW_DSH_THM)
     REM ----------------------------------------------------------------------------- 


:_THM_TVA


     REM ПРОВЕРЯЕМ, DRW TVA УСТАНОВЛЕН - ЕСЛИ НЕТ, ПРОПУСКАЕМ

          ECHO !PKG_LST! | FINDSTR "com.android.tv.appsdrawer" >NUL 2>&1
          IF %ERRORLEVEL% EQU 1 GOTO _THM_TSY

     REM -----------------------------------------------------------------------------
REM       _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.android.tv.appsdrawer ; pm uninstall com.android.tv.appsdrawer" >NUL 2>&1
     REM -----------------------------------------------------------------------------
          IF "%THM_NAM%"=="DEF" (CALL :_DRW_DRW) ELSE (CALL :_DRW_DRW_THM)
     REM ----------------------------------------------------------------------------- 


:_THM_TSY


     REM ПРОВЕРЯЕМ, TSY STT УСТАНОВЛЕН - ЕСЛИ НЕТ, ПРОПУСКАЕМ

          ECHO !PKG_LST! | FINDSTR /ir /c:"com.amazon.lm" /c:"com.wolf.lm" >NUL 2>&1
          IF %ERRORLEVEL% EQU 1 GOTO _THM_NOL
 
     REM -----------------------------------------------------------------------------
REM       _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.wolf.lm ; pm uninstall com.wolf.lm"     >NUL 2>&1
REM       _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.lm ; pm uninstall com.amazon.lm" >NUL 2>&1
     REM -----------------------------------------------------------------------------
          IF "%THM_NAM%"=="DEF" (CALL :_STT_TSY) ELSE (CALL :_STT_TSY_THM)
     REM ----------------------------------------------------------------------------- 


:_THM_NOL


     REM ПРОВЕРЯЕМ, TSY STT УСТАНОВЛЕН - ЕСЛИ НЕТ, ПРОПУСКАЕМ

          ECHO !PKG_LST! | FINDSTR "com.wolf.lms" >NUL 2>&1
          IF %ERRORLEVEL% EQU 1 GOTO _END_THM

     REM -----------------------------------------------------------------------------
          IF "%THM_NAM%"=="DEF" (CALL :_STT_NOL) ELSE (CALL :_STT_NOL_THM)
     REM ----------------------------------------------------------------------------- 


:_END_THM

     
     REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell "pm disable-user --user 0 com.amazon.device.sale.service ; pm disable-user --user 0 com.amazon.tv.alexanotifications" >NUL 2>&1
     REM ----------------------------------------------------------------------------
     
REM  CALL :_SOF
     CALL :_RES_LAU

REM ============================================================================
EXIT /B


:=======================================
















:---------------------------------------
:FUNC_SECTION
:---------------------------------------


:=======================================
:UNI_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - PRE-CLEAN -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO     !str_uni_mnu!:
     "!CE!"   !str_uni_inf!
     "!CE!"   !str_uni_infb!
     "!CE!"   !str_uni_infa!
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_uni!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04= !str_ski!"
     SET "PAR05= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO UNI_MNU_XN)

REM  IF /i "%ERRORLEVEL%" == "2" (CALL :_UNI & CALL :_ROL)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_UNI)

     IF /i "%ERRORLEVEL%" == "3" (GOTO UNI_MNU_XN)
     IF /i "%ERRORLEVEL%" == "4" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "5" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_UNI
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
    _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | grep -E 'launcher|firehomestarter' | grep -vE 'icon_pack|website' | while read -r PKG; do ID=${PKG##*:}; pm enable $ID; done; pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; pm uninstall $ID; done; pm trim-caches 999G; input keyevent KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B


:_ROL
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | while read -r PKG; do ID=${PKG##*:}; pm uninstall $ID; done; pm trim-caches 999G" >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:_OTH_XN
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     SET "TT=OTHER-APK" & SET "FF=_OTH\BASE\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "ru.yourok.torrserve" >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     SET "TT=OTHER-APK" & SET "FF=_OTH\TORR\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK    
REM ============================================================================
EXIT /B


:_OTH_XC
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     MD "%USERPROFILE%\DESKTOP\INST-APK" >NUL 2>&1
REM ----------------------------------------------------------------------------
     SET "TT=OTHER-APK" & SET "FF=%USERPROFILE%\DESKTOP\INST-APK\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:LVL_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - BLOATWARE -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO    !str_lvl_mnu!: 
     "!CE!"   !str_lvl_inf!
     "!CE!"   !str_lvl_infa!
     "!CE!"   !str_lvl_infb!
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_lvl_uof!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_lvl_amz!"
     SET "PAR05=   !str_lvl_adw!"
     SET "PAR06=   !str_lvl_liv!"
     SET "PAR07=   !str_lvl_kid!"
     SET "PAR08=   !str_lvl_dee!"
     SET "PAR09=    --------------------------------------------"
     SET "PAR10=   !str_lvl_max!"
     SET "PAR11=    --------------------------------------------"
     SET "PAR12= !str_pre!"
     SET "PAR13= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_UOF                    & CALL :_OTF_                      & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_AMZ                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_ADW                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_LIV                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_KID                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (CALL :_DEE                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (GOTO LVL_MNU_XC)                                                 
     IF /i "%ERRORLEVEL%" == "10" (CALL :_MAX                                                       & CALL :_RES_LAU & GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "11" (GOTO LVL_MNU_XC)
     IF /i "%ERRORLEVEL%" == "12" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "13" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_UOF
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------

     FOR /F "delims=: tokens=2" %%i IN (' _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d -s ^| FINDSTR /v "launcher" ^| FINDSTR /v "firehomestarter" ^| FINDSTR /v "documentsui" ^| FINDSTR /v "sale" ^| FINDSTR /v "ota" ^| FINDSTR /v "traceur" ') DO (

          COLOR 04
          TITLE - !str_blo_und_ttl! ^| %%i -

          CLS
          
          ECHO.
          "!CE!" {90} {00} {90} BLOAT {#}{\n}
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          "!CE!"                    !str_sta_wai!{\n}
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          "!CE!" {00}  {06}!str_sta_blon!{\n}
          "!CE!" {00}  {08}%%i{\n}

          _BIN\ADB.EXE -s "%_NFF_I%" shell "cmd package install-existing %%i ; pm enable --user 0 %%i" >NUL 2>&1

     )
REM ============================================================================
EXIT /B


:_ADW
REM ============================================================================
     SET "TT=!str_blo_adw_ttl!" & SET "FL=_BLO\ADW.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_LIV
REM ============================================================================
     SET "TT=!str_blo_liv_ttl!" & SET "FL=_BLO\LIV.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_KID
REM ============================================================================
     SET "TT=!str_blo_kid_ttl!" & SET "FL=_BLO\KID.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_AMZ
REM ============================================================================
     SET "TT=!str_blo_amz_ttl!" & SET "FL=_BLO\AMZ.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_DEE
REM ============================================================================
     SET "TT=!str_blo_dee_ttl!" & SET "FL=_BLO\DEE.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_MAX
REM ============================================================================
     SET "TT=!str_blo_max_ttl!" & SET "FL=_BLO\MAX.TXT" & CALL :_BLO
REM ============================================================================
EXIT /B


:_BLO
REM ============================================================================
REM  SET "TT=!str_blo_liv_ttl!" & SET "FL=_BLO\LIV.TXT" & CALL :_BLO
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     FOR /F %%i IN (%FL%) DO (

          COLOR 04
          TITLE - !TT! ^| %%i -

          CLS

          ECHO.
          "!CE!" {90} {00} {90} BLOAT {#}{\n}
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          "!CE!"                    !str_sta_wai!{\n}
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          ECHO.
          "!CE!" {00}  {06}!str_sta_blof!{\n}
          "!CE!" {00}  {08}%%i{\n}

          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear %%i ; pm disable-user --user 0 %%i" >NUL 2>&1

     )

     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.tv.settings.v2" >NUL 2>&1

REM ============================================================================
EXIT /B


:-----------------------------


:_OTF
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     SET "var_color_unk={08}"
     SET "var_color_err={04}"
     SET "var_color_nrm={0A}"
REM ----------------------------------------------------------------------------
     SET "var_ERR_OTA=0"
REM ----------------------------------------------------------------------------
     SET "var_color_pkg_1=!var_color_unk!"
     SET "var_color_pkg_2=!var_color_unk!"
     SET "var_color_pkg_3=!var_color_unk!"
REM ----------------------------------------------------------------------------
     SET "var_ota_status=!str_ota_status_testing!"
     SET "var_ota_down=!str_ota_down_empty!"
REM ----------------------------------------------------------------------------
     IF /i "%var_ERR_FW%" == "1" (SET "sta_FWR=!str_fw_bad!") ELSE (SET "sta_FWR=!str_fw_nrm!")
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.tv.settings.v2" >NUL 2>&1               
REM ----------------------------------------------------------------------------
     CALL :_OTN_WIN
     PING -n 5 127.0.0.1 >NUL
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.tv.forcedotaupdater.v2 ; pm disable-user com.amazon.tv.forcedotaupdater.v2" >NUL 2>&1     
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d -s | FINDSTR "com.amazon.tv.forcedotaupdater.v2" >NUL 2>&1

     IF %ERRORLEVEL% EQU 1 (
          SET "var_color_pkg_1=!var_color_err!"
          SET "var_ERR_OTA=1"
     ) ELSE (
          SET "var_color_pkg_1=!var_color_nrm!"
     )
REM ----------------------------------------------------------------------------
     CALL :_OTN_WIN
     PING -n 3 127.0.0.1 >NUL
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.device.software.ota ; pm disable-user com.amazon.device.software.ota" >NUL 2>&1  
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d | FINDSTR "com.amazon.device.software.ota" >NUL 2>&1

     IF %ERRORLEVEL% EQU 1 (
          SET "var_color_pkg_2=!var_color_err!"
          SET "var_ERR_OTA=1"
     ) ELSE (
          SET "var_color_pkg_2=!var_color_nrm!"
     )
REM ----------------------------------------------------------------------------
     CALL :_OTN_WIN
     PING -n 3 127.0.0.1 >NUL
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.device.software.ota.override ; pm disable-user --user 0 com.amazon.device.software.ota.override" >NUL 2>&1   
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d | FINDSTR "com.amazon.device.software.ota.override" >NUL 2>&1

     IF %ERRORLEVEL% EQU 1 (
          SET "var_color_pkg_3=!var_color_err!"
          SET "var_ERR_OTA=1"
     ) ELSE (
          SET "var_color_pkg_3=!var_color_nrm!"
     )
REM ----------------------------------------------------------------------------
     CALL :_OTN_WIN
     PING -n 3 127.0.0.1 >NUL
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm clear com.amazon.tv.settings.v2" >NUL 2>&1        
REM ----------------------------------------------------------------------------
     IF /i "%var_ERR_OTA%" == "1" (SET "var_ota_status=!str_ota_status_problem!") ELSE (SET "var_ota_status=!str_ota_status_success!")
     SET "var_ota_down=!str_ota_down_enter!"
     CALL :_OTN_WIN
REM ----------------------------------------------------------------------------
     PAUSE >NUL 2>&1
REM ============================================================================
EXIT /B


:_OTF_
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | grep -E 'ota' | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID; pm disable-user $ID; pm clear $ID; done; pm trim-caches 999G; pm clear com.amazon.tv.settings.v2; input keyevent KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B


:_OTN_WIN
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     CALL :UPPERCASE "%_MNF%" "var_MNF"
     CALL :UPPERCASE "%_MDL%" "var_MDL"
     CALL :UPPERCASE "%_NAM%" "var_NAM"
     CALL :UPPERCASE "%_FRW%" "var_FRW"
REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 08
     TITLE - TURN OFF UPDATE - 
     CLS
REM ----------------------------------------------------------------------------
     ECHO.
     ECHO.
     ECHO.
     "!CE!" {0D}  DEVICE:  {04}!var_MNF! {08}- {09}!var_MDL! {08}- {03}!var_NAM!{#}{\n}
     ECHO.
     "!CE!" {06}  !var_FRW!{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" !sta_FWR!{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"  !var_color_pkg_1!   com.amazon.tv.forcedotaupdater          {#}{\n}
     "!CE!"    {08}-----------------------------------------{#}{\n}
     "!CE!"  !var_color_pkg_2!   com.amazon.device.software.ota          {#}{\n}
     "!CE!"    {08}-----------------------------------------{#}{\n}
     "!CE!"  !var_color_pkg_3!   com.amazon.device.software.ota.override {#}{\n}
     ECHO.
     ECHO.
     "!CE!" !var_ota_status!
     "!CE!" !var_ota_down!
REM ============================================================================
EXIT /B



:_AMZ_WIN
REM ============================================================================
REM     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     CALL :UPPERCASE "%_MNF%" "var_MNF"
     CALL :UPPERCASE "%_MDL%" "var_MDL"
     CALL :UPPERCASE "%_NAM%" "var_NAM"
     CALL :UPPERCASE "%_FRW%" "var_FRW"
     CALL :UPPERCASE "%_SNO%" "var_SNO"
REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 08
     TITLE - INFO - AMAZON - 
     CLS
REM ----------------------------------------------------------------------------
     ECHO.
     ECHO.
     "!CE!" {07} !str_amz_inf_a!{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" {08}  MNF: {04}!var_MNF!{#}{\n}
     ECHO.
     "!CE!" {08}  MDL: {09}!var_MDL!{#}{\n}
     ECHO.
     "!CE!" {08}  NAM: {02}!var_NAM!{#}{\n}
     ECHO.
     "!CE!" {08}  FRW: {06}!var_FRW!{#}{\n}
     ECHO.
     "!CE!" {08}  SER: {03}!var_SNO!{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}
REM ----------------------------------------------------------------------------
     PAUSE >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:LAU_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - LAUNCHER -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_lau_mnu!:
     "!CE!"  !str_mnu_lau_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_lau_stk_xn!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_lau_lof_nw!"
     SET "PAR05=   !str_mnu_lau_lof_ww!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_lau_emo!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09=   !str_mnu_lau_prj!"
     SET "PAR10=    --------------------------------------------"
     SET "PAR11=   !str_mnu_lau_wlf!"
     SET "PAR12=    --------------------------------------------"
     SET "PAR13= !str_ski!"
     SET "PAR14= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO LAU_MNU_XN)       
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_LAU_STK)        
     IF /i "%ERRORLEVEL%" == "3"  (GOTO LAU_MNU_XN)       
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_LAU_LOF_NW)     
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_LAU_LOF_WW)     
     IF /i "%ERRORLEVEL%" == "6"  (GOTO LAU_MNU_XN)       
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_LAU_EMO)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO LAU_MNU_XN)
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_LAU_PRJ)
     IF /i "%ERRORLEVEL%" == "10" (GOTO LAU_MNU_XN)      
     IF /i "%ERRORLEVEL%" == "11" (CALL :_LAU_WLF)
     IF /i "%ERRORLEVEL%" == "12" (GOTO LAU_MNU_XN)
     IF /i "%ERRORLEVEL%" == "13" (EXIT /B)              
     IF /i "%ERRORLEVEL%" == "14" (GOTO MODE_SELECT_MENU)     

REM ============================================================================
EXIT /B


:LAU_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - LAUNCHER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_lau_mnu!:
     "!CE!"  !str_mnu_lau_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_lau_stk_xc!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_lau_lof_nw!"
     SET "PAR05=   !str_mnu_lau_lof_ww!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_lau_emo!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09=   !str_mnu_lau_prj!"
     SET "PAR10=    --------------------------------------------"
     SET "PAR11=   !str_mnu_lau_wlf!"
     SET "PAR12=    --------------------------------------------"
     SET "PAR13= !str_pre!"
     SET "PAR14= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO LAU_MNU_XC)                                                                
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_LAU_STK                                                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)                        
     IF /i "%ERRORLEVEL%" == "3"  (GOTO LAU_MNU_XC)                                                                
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_LAU_LOF_NW             & CALL :_SEL_LAU                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)      
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_LAU_LOF_WW             & CALL :_SEL_LAU                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)      
     IF /i "%ERRORLEVEL%" == "6"  (GOTO LAU_MNU_XC)                                                                
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_LAU_EMO                & CALL :_SEL_LAU                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)     
     IF /i "%ERRORLEVEL%" == "8"  (GOTO LAU_MNU_XC)                                                               
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_LAU_PRJ                & CALL :_SEL_LAU                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)      
     IF /i "%ERRORLEVEL%" == "10" (GOTO LAU_MNU_XC)                                                                
     IF /i "%ERRORLEVEL%" == "11" (CALL :_LAU_WLF                & CALL :_SEL_LAU                   & CALL :_RES_LAU & GOTO LAU_MNU_XC)
     IF /i "%ERRORLEVEL%" == "12" (GOTO LAU_MNU_XC)                                                           
     IF /i "%ERRORLEVEL%" == "13" (EXIT /B)                                                                       
     IF /i "%ERRORLEVEL%" == "14" (GOTO MODE_SELECT_MENU)                                                              

REM ============================================================================
EXIT /B


:_LAU_STK
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     CALL :_SON
REM ============================================================================
EXIT /B


:_LAU_LOF_NW
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\LOF_NW\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:_LAU_LOF_WW
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\LOF_WW\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:_LAU_WLF
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\WLF\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
REM     _BIN\ADB.EXE -s "%_NFF_I%" shell "appwidget grantbind --package com.wolf.firelauncher --user 0; appwidget grantbind --package ca.dstudio.atvlauncher --user 0; appwidget grantbind --package ca.dstudio.atvlauncher.pro --user 0" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:_LAU_EMO
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\EMO\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:_LAU_PRJ
REM ============================================================================
     IF %_SDK% LEQ 25 (
          SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\PRJ\567" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
     ) ELSE (
          SET "TT=LAUNCHER" & SET "FF=_APP\_LAU\PRJ\911" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     )
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:-----------------------------


:_LAU_LOF_NW_THM
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*NW*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:_LAU_LOF_WW_THM
REM ============================================================================
     SET "TT=LAUNCHER" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*WW*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ----------------------------------------------------------------------------
     CALL :_SOF
REM ============================================================================
EXIT /B


:-----------------------------


:_SEL_LOF
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

ECHO 0
PAUSE

     IF %var_ERR_FW% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------

ECHO 1
PAUSE

     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "\.lm"  >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------

ECHO 2
PAUSE

     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID 2>/dev/null ; done "
REM ----------------------------------------------------------------------------                                                                                                     

     CLS                                                                                                 
     COLOR 02                                                                                            
     TITLE - LAUNCHER -                                                                       

     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_1!
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_lof!
     "!CE!"                       !str_sta_lau_sel_3!
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

     PAUSE >NUL 2>&1
     CLS
                                                                                                          
REM ============================================================================
EXIT /B


:_SEL_WLF
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     IF %var_ERR_FW% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "\.lm"  >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID 2>/dev/null ; done "
REM ----------------------------------------------------------------------------                                                                                                     

     CLS                                                                                                 
     COLOR 02                                                                                            
     TITLE - LAUNCHER -                                                                       

     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_1!
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_wlf!
     "!CE!"                       !str_sta_lau_sel_3!
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

     PAUSE >NUL 2>&1
     CLS
                                                                                                          
REM ============================================================================
EXIT /B


:_SEL_ATV
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     IF %var_ERR_FW% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "\.lm"  >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID 2>/dev/null ; done "
REM ----------------------------------------------------------------------------                                                                                                   

     CLS                                                                                                 
     COLOR 02                                                                                            
     TITLE - LAUNCHER -                                                                       

     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_1!
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_atv!
     "!CE!"                       !str_sta_lau_sel_3!
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

     PAUSE >NUL 2>&1
     CLS
                                                                                                          
REM ============================================================================
EXIT /B


:_SEL_EMO
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     IF %var_ERR_FW% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "\.lm"  >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID 2>/dev/null ; done "
REM ----------------------------------------------------------------------------                                                                                                  

     CLS                                                                                                 
     COLOR 02                                                                                            
     TITLE - LAUNCHER -                                                                       

     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_1!
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_emo!
     "!CE!"                       !str_sta_lau_sel_3!
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

     PAUSE >NUL 2>&1
     CLS
                                                                                                          
REM ============================================================================
EXIT /B                                                                                                         
                                                                                                         

:_SEL_PRJ
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     IF %var_ERR_FW% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -3 | FINDSTR "\.lm"  >NUL 2>&1
     IF %ERRORLEVEL% EQU 1 EXIT /B
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID 2>/dev/null ; done "
REM ----------------------------------------------------------------------------

     CLS                                                                                                 
     COLOR 02                                                                                            
     TITLE - LAUNCHER -                                                                       

     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_1!
     "!CE!" {\n}
     "!CE!"                       !str_sta_lau_sel_prj!
     "!CE!"                       !str_sta_lau_sel_3!
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!" {\n}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

     PAUSE >NUL 2>&1
     CLS

REM ============================================================================
EXIT /B     


:-----------------------------
:-----------------------------


:_SEL_LAU
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d -s | FINDSTR "com.amazon.tv.launcher" >NUL 2>&1

     IF %ERRORLEVEL% EQU 1 (

          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*MIN*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK

          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 25 IF %_FWA% GTR 6281 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*MIN*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 28 IF %_FWA% GTR 7255 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*MIN*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK

     ) ELSE (

          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 25 IF %_FWA% GEQ 6265 IF %_FWA% LEQ 6281 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*NOL*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 28 IF %_FWA% GEQ 7248 IF %_FWA% LEQ 7255 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*NOL*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
          IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% EQU 8100 SET "TT=LM" & SET "FF=_APP\_STT\" & SET "FL=*NOL*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK

     )
REM ----------------------------------------------------------------------------

REM ============================================================================
EXIT /B


:-----------------------------


:_SOF
REM ============================================================================
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | grep -E 'launcher|firehomestarter' | grep -vE 'icon_pack|website' | while read -r PKG; do ID=${PKG##*:}; pm disable-user $ID; done; pm trim-caches 999G; input keyevent KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B


:_SON
REM ============================================================================
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | grep -E 'launcher|firehomestarter' | grep -vE 'icon_pack|website' | while read -r PKG; do ID=${PKG##*:}; pm enable $ID; done; pm trim-caches 999G; input keyevent KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B




:-----------------------------


:_WAI
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 04
     TITLE - !title_text! -

     CLS

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                    !str_sta_wai!{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

REM ============================================================================
EXIT /B


:-----------------------------


:_ERR_DVC
REM ============================================================================
     SET "var_ERR_HW=1"
REM ----------------------------------------------------------------------------
     CALL :UPPERCASE "%_MNF%" "var_MNF"
     CALL :UPPERCASE "%_MDL%" "var_MDL"
     CALL :UPPERCASE "%_NAM%" "var_NAM"
     CALL :UPPERCASE "%_SNO%" "var_SNO"
REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 04                                                                                            
     TITLE - WARNING -                                                                       
REM ----------------------------------------------------------------------------

     CLS

     ECHO.
     "!CE!" !str_ed_0!
     ECHO.
     ECHO.
     "!CE!"   !str_ed_1!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" {08}   -------------------------------------{#}{\n}
     "!CE!" {04}   !var_MNF! {08}- {09}!var_MDL!{\n}
     "!CE!" {09}   !var_NAM!{\n}
     "!CE!" {02}   !var_SNO!{\n}
     "!CE!" {08}   -------------------------------------{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" !str_ed_2!
     ECHO.
     "!CE!" !str_ed_3!
     "!CE!" !str_ed_4!
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

REM ----------------------------------------------------------------------------
     PAUSE >NUL 2>&1
REM ----------------------------------------------------------------------------
     CLS
REM ============================================================================
EXIT /B


:-----------------------------


:_INF_AMZ
REM ============================================================================
     SET "var_ERR_HW=1"
REM ----------------------------------------------------------------------------
     CALL :UPPERCASE "%_MNF%" "var_MNF"
     CALL :UPPERCASE "%_MDL%" "var_MDL"
     CALL :UPPERCASE "%_NAM%" "var_NAM"
     CALL :UPPERCASE "%_SNO%" "var_SNO"
REM ----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     COLOR 04                                                                                            
     TITLE - WARNING -                                                                       
REM ----------------------------------------------------------------------------

     CLS

     ECHO.
     "!CE!" !str_ed_0!
     ECHO.
     ECHO.
     "!CE!"   !str_ed_1!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" {08}   -------------------------------------{#}{\n}
     "!CE!" {04}   !var_MNF! {08}- {09}!var_MDL!{\n}
     "!CE!" {09}   !var_NAM!{\n}
     "!CE!" {02}   !var_SNO!{\n}
     "!CE!" {08}   -------------------------------------{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!" !str_ed_2!
     ECHO.
     "!CE!" !str_ed_3!
     "!CE!" !str_ed_4!
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

REM ----------------------------------------------------------------------------
     PAUSE >NUL 2>&1
REM ----------------------------------------------------------------------------
     CLS
REM ============================================================================
EXIT /B


:-----------------------------


:_RES_LAU
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -s | grep -E 'launcher|firehomestarter|venezia|settings.v2|ota' | grep -vE 'icon_pack|website' | while read -r PKG; do ID=${PKG##*:}; am force-stop $ID; pm clear $ID; done; pm trim-caches 999G; input keyevent KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B


:_LAU_STO_STA
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "am force-stop com.google.android.tvlauncher ; am force-stop com.amazon.tv.launcher ; am force-stop com.amazon.tv.leanbacklauncher ; am force-stop com.wolf.firelauncher ; am force-stop com.oversea.aslauncher ; am force-stop com.spocky.projengmenu" >NUL 2>&1
     _BIN\ADB.EXE -s "%_NFF_I%" shell "am start -n com.google.android.tvlauncher/com.google.android.tvlauncher.MainActivity ; am start -n com.amazon.tv.launcher/com.amazon.tv.launcher.ui.HomeActivity_vNext ; am start -n com.amazon.tv.leanbacklauncher/com.amazon.tv.leanbacklauncher.MainActivity ; am start -n com.wolf.firelauncher/com.wolf.firelauncher.screens.launcher.LauncherActivity ; am start -n com.oversea.aslauncher/com.oversea.aslauncher.ui.main.MainActivity; am start -n com.spocky.projengmenu/.ui.home.MainActivity" >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell input keyevent KEYCODE_HOME >NUL 2>&1
REM ============================================================================
EXIT /B


:_STK_CLE
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages | grep -E 'launcher|firehomestarter|venezia|settings.v2|ota' | grep -vE 'icon_pack|website' | while read -r PKG; do ID=${PKG##*:}; pm clear $ID; done; pm trim-caches 999G" >NUL 2>&1
REM ============================================================================
EXIT /B


:_CLE_DIS
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -d | grep -v com.amazon.imp | grep -v com.wolf.firelauncher | while read -r PKG ; do ID=${PKG##*:} ; pm clear $ID ; done" >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:KEY_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - KEYBOARD -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_key_mnu!:
     "!CE!"  !str_mnu_key_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_key_fsk!"
     SET "PAR03=   !str_mnu_key_lkk!"
     SET "PAR04=    --------------------------------------------"
     SET "PAR05= !str_ski!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"
REM  "!MU!" 0660 "    ---------------------------------------" "   !str_mnu_key_fsk!" "   !str_mnu_key_lkk!" "    ---------------------------------------" " !str_ski!" " !str_exi!"

     IF /i "%ERRORLEVEL%" == "1" (GOTO KEY_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_FSK)
     IF /i "%ERRORLEVEL%" == "3" (CALL :_LKK)
     IF /i "%ERRORLEVEL%" == "4" (GOTO KEY_MNU_XN)
     IF /i "%ERRORLEVEL%" == "5" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "6" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:KEY_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - KEYBOARD -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_key_mnu!:
     "!CE!"  !str_mnu_key_inf! 
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_key_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_key_fsk!"
     SET "PAR05=   !str_mnu_key_lkk!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_key_all!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%"
REM  "!MU!" 0660 "    ---------------------------------------" "   !str_mnu_key_del!" "    ---------------------------------------" "   !str_mnu_key_fsk!" "   !str_mnu_key_lkk!" "    ---------------------------------------" "   !str_mnu_key_all!" "    ---------------------------------------" " !str_pre!" " !str_exi!"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_KEY_D & GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_FSK & GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_LKK & GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_KEY_A & GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO KEY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_KEY_D
REM ============================================================================
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable com.amazon.tv.ime/.FireTVIME; ime set com.amazon.tv.ime/.FireTVIME" >NUL 2>&1
REM ============================================================================
EXIT /B


:_LKK
REM ============================================================================
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*LKK*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*SYM*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
:: - GHU -
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable com.liskovsoft.leankeyboard/.ime.LeanbackImeService; ime set com.liskovsoft.leankeyboard/.ime.LeanbackImeService" >NUL 2>&1
REM ----------------------------------------------------------------------------
:: - PLY -
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable org.liskovsoft.androidtv.rukeyboard/com.liskovsoft.leankeyboard.ime.LeanbackImeService; ime set org.liskovsoft.androidtv.rukeyboard/com.liskovsoft.leankeyboard.ime.LeanbackImeService" >NUL 2>&1
REM ============================================================================
EXIT /B


:_FSK
REM ============================================================================
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*FSK*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*SYM*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
:: - ORI -
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable com.example.semitop7.FireTVStyle/.FireTVStyleIME; ime set com.example.semitop7.FireTVStyle/.FireTVStyleIME" >NUL 2>&1
REM ----------------------------------------------------------------------------
:: - TSY -
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable com.amazon.tv.ftvstylekb/.IMS; ime set com.amazon.tv.ftvstylekb/.IMS" >NUL 2>&1
REM ============================================================================
EXIT /B


:_KEY_A
REM ============================================================================
     SET "TT=KEYBOARD" & SET "FF=_APP\_KEY\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell "ime enable com.amazon.tv.ftvstylekb/.IMS ; ime enable com.example.semitop7.FireTVStyle/.FireTVStyleIME ; ime enable com.liskovsoft.leankeyboard/.ime.LeanbackImeService ; ime enable org.liskovsoft.androidtv.rukeyboard/com.liskovsoft.leankeyboard.ime.LeanbackImeService" >NUL 2>&1
     _BIN\ADB.EXE -s "%_NFF_I%" shell "ime list -a -s | while read -r KEY; do ime enable $KEY; ime set $KEY; done; input keyevent KEYCODE_SYM" >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:_LOC
REM ============================================================================
     SET "TT=LOCALE" & SET "FF=_APP\_LOC\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant jp.co.c_lis.ccl.morelocale android.permission.CHANGE_CONFIGURATION; am start -n jp.co.c_lis.ccl.morelocale/jp.co.c_lis.ccl.morelocale.ui.MainActivity"        >NUL 2>&1                                                               
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell "am start -n jp.co.c_lis.ccl.morelocale/jp.co.c_lis.ccl.morelocale.ui.MainActivity"  >NUL 2>&1  
REM ----------------------------------------------------------------------------

     MODE CON:COLS=80 LINES=29
     
     COLOR 02
     TITLE - LOCALE -

     CLS
                
     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                      !str_sta_loc_sel_1!
     ECHO.
     "!CE!"                      !str_sta_loc_sel_2!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}
                 
     PAUSE >NUL 2>&1
     CLS

REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "input keyevent KEYCODE_BACK KEYCODE_BACK KEYCODE_BACK KEYCODE_HOME" >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:_CFG
REM ============================================================================
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" push  "_SHS\mai.sh" "/data/local/tmp/mai.sh" >NUL 2>&1
     _BIN\ADB.EXE -s "%_NFF_I%" shell "chmod 777 /data/local/tmp/mai.sh ; sh /data/local/tmp/mai.sh" >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:_BASE
REM ============================================================================
     IF %_SDK% EQU 22 (
          SET "TT=BASE APP'S SET" & SET "FF=_APP\_BSE\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
          SET "TT=BASE APP'S SET" & SET "FF=_APP\_BSE_5\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     ) ELSE (
          SET "TT=BASE APP'S SET" & SET "FF=_APP\_BSE\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
     )
REM ============================================================================
EXIT /B


:-----------------------------


:_GACC
REM ============================================================================
     SET "TT=BASE APP'S SET" & SET "FF=_APP\_ACC\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:_FTP
REM ============================================================================
     SET "TT=FTP-SHARE" & SET "FF=_APP\_FTP\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_FTP_THM
REM ============================================================================
     SET "TT=FTP-SHARE" & SET "FF=_THM\%THM_NAM%\" & SET "FL=_WF-FTP*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:TUB_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - YOUTUBE -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_tub_mnu!:
     "!CE!"  !str_mnu_tub_inf!
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_tub_stn!"
     SET "PAR03=   !str_mnu_tub_ggl!"
     SET "PAR04=    --------------------------------------------"
     SET "PAR05= !str_ski!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO TUB_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_TUB_STN)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_TUB_GGL)
     IF /i "%ERRORLEVEL%" == "4"  (GOTO TUB_MNU_XN)
     IF /i "%ERRORLEVEL%" == "5"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:TUB_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - YOUTUBE -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_tub_mnu!:
     "!CE!"  !str_mnu_tub_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_tub_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_tub_stn!"
     SET "PAR05=   !str_mnu_tub_ggl!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07= !str_pre!"
     SET "PAR08= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_TUB_D & GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_TUB_STN & GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_TUB_GGL & GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO TUB_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_TUB_D
REM ============================================================================
     SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_TUB_STN
REM ============================================================================
     SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\STN\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -s | FINDSTR "com.google.android.youtube.tv" >NUL 2>&1
     IF %ERRORLEVEL% EQU 0 EXIT /B
     SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\BRG\" & SET "FL=ATV_*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\BRG\" & SET "FL=AMAZON_*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_TUB_GGL
REM ============================================================================
     SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     IF %_SDK% EQU 22 (
          SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\GGL_5" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     ) ELSE (
          SET "TT=YOUTUBE" & SET "FF=_APP\_TUB\GGL" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     )
REM ============================================================================
EXIT /B


:-----------------------------


:PLY_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - MEDIA PLAYER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_ply_mnu!:
     "!CE!"  !str_mnu_ply_inf!
     ECHO.

     SET "PAR01=    -----------------------------------"
     SET "PAR02=   !str_mnu_ply_vim!"
     SET "PAR03=   !str_mnu_ply_kod!"
     SET "PAR04=    -----------------------------------"
     SET "PAR05= !str_ski!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO PLY_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_PLY_VIMU)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_PLY_KODI)
     IF /i "%ERRORLEVEL%" == "4"  (GOTO PLY_MNU_XN)
     IF /i "%ERRORLEVEL%" == "5"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:PLY_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - MEDIA PLAYER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_ply_mnu!:
     "!CE!"  !str_mnu_ply_inf!  
     ECHO.

     SET "PAR01=    -----------------------------------"
     SET "PAR02=   !str_mnu_ply_del!"
     SET "PAR03=    -----------------------------------"
     SET "PAR04=   !str_mnu_ply_vim!"
     SET "PAR05=   !str_mnu_ply_kod!"
     SET "PAR06=    -----------------------------------"
     SET "PAR07=   !str_mnu_ply_all!"
     SET "PAR08=    -----------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_PLY_D & GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_PLY_VIMU & GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_PLY_KODI & GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_PLY_A & GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO PLY_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_PLY_D
REM ============================================================================
     SET "TT=MEDIA PLAYER" & SET "FF=_APP\_PLA\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/*element*.zip /sdcard/*upnext*.zip"           >NUL 2>&1  
REM ============================================================================
EXIT /B


:_PLY_VIMU
REM ============================================================================
     SET "TT=MEDIA PLAYER" & SET "FF=_APP\_PLA\" & SET "FL=*vimu*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_PLY_KODI
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------                            
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/_KODI/; mkdir sdcard/_KDI"                    >NUL 2>&1                           
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell "mkdir sdcard/_KODI"                                          >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  FOR /R "_APP\_PLA\" %%f IN (*.zip) DO _BIN\ADB.EXE -s "%_NFF_I%" push "%%f" "/sdcard/_KODI/"   >NUL 2>&1 
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/*element*.zip /sdcard/*upnext*.zip"           >NUL 2>&1  
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!_APP\_PLA\KODI\ZIP"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/"                                          >NUL 2>&1
     CD /D "!NFF_HME!
REM ----------------------------------------------------------------------------
     SET "TT=MEDIA PLAYER" & SET "FF=_APP\_PLA\KODI\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_PLY_A
REM ============================================================================
     SET "TT=MEDIA PLAYER" & SET "FF=_APP\_PLA\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "rm -rf /sdcard/*element*.zip /sdcard/*upnext*.zip"           >NUL 2>&1  
REM ----------------------------------------------------------------------------
     CD /D "!NFF_HME!_APP\_PLA\KODI\ZIP"
     !NFF_HME!_BIN\ADB.EXE -s "%_NFF_I%" push . "/sdcard/"                                          >NUL 2>&1
     CD /D "!NFF_HME!
REM ============================================================================
EXIT /B


:-----------------------------


:TOR_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - TORR SERVE -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_tor_mnu!:
     "!CE!"  !str_mnu_tor_inf_1!
     "!CE!"  !str_mnu_tor_inf_2!
     ECHO.

     SET "PAR01=    -----------------------------------"
     SET "PAR02=   !str_mnu_tor_ins!"
     SET "PAR03=    -----------------------------------"
     SET "PAR04= !str_ski!"
     SET "PAR05= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO TOR_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_TOR & EXIT /B)
     IF /i "%ERRORLEVEL%" == "3" (GOTO TOR_MNU_XN)
     IF /i "%ERRORLEVEL%" == "4" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "5" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_TOR
REM ============================================================================
     SET "TT=TORR SERVE" & SET "FF=_APP\_TOR\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:-----------------------------


:IPT_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - IPTV PLAYER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_ipt_mnu!:
     "!CE!"  !str_mnu_ipt_inf!  
     ECHO.

     SET "PAR01=    -----------------------------------"
     SET "PAR02=   !str_mnu_ipt_ott!"
     SET "PAR03=   !str_mnu_ipt_viz!"
     SET "PAR04=   !str_mnu_ipt_nav!"
     SET "PAR05=   !str_mnu_ipt_tiv!"
     SET "PAR06=    -----------------------------------"
     SET "PAR07= !str_ski!"
     SET "PAR08= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO IPT_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_IPT_OTT)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_IPT_VIZ)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_IPT_NAV)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_IPT_TIV)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO IPT_MNU_XN)
     IF /i "%ERRORLEVEL%" == "7"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:IPT_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - IPTV PLAYER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_ipt_mnu!:
     "!CE!"  !str_mnu_ipt_inf!  
     ECHO.

     SET "PAR01=    -----------------------------------"
     SET "PAR02=   !str_mnu_ipt_del!"
     SET "PAR03=    -----------------------------------"
     SET "PAR04=   !str_mnu_ipt_ott!"
     SET "PAR05=   !str_mnu_ipt_viz!"
     SET "PAR06=   !str_mnu_ipt_nav!"
     SET "PAR07=   !str_mnu_ipt_tiv!"
     SET "PAR08=    -----------------------------------"
     SET "PAR09=   !str_mnu_ipt_all!"
     SET "PAR10=    -----------------------------------"
     SET "PAR11= !str_pre!"
     SET "PAR12= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_IPT_D & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_IPT_OTT & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_IPT_VIZ & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_IPT_NAV & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_IPT_TIV & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_IPT_A & GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "10" (GOTO IPT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "11" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "12" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_IPT_D
REM ============================================================================
     SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_IPT_OTT
REM ============================================================================
     SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*foss*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_IPT_VIZ
REM ============================================================================
     SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*televizo*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_IPT_NAV
REM ============================================================================
     IF %_SDK% EQU 22 (
          SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*nav*MustHave*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
     ) ELSE (
          SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*nav*TryRoom*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK   
     )
REM ============================================================================
EXIT /B


:_IPT_TIV
REM ============================================================================
     SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*tivimate*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_IPT_A
REM ============================================================================
     SET "TT=IPTV PLAYER" & SET "FF=_APP\_IPT\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:FLE_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     CLS
     COLOR 02
     TITLE - FILE MANAGER -

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_fle_mnu!:
     "!CE!"  !str_mnu_fle_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_fle_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_fle_fx!"
     SET "PAR05=   !str_mnu_fle_xp!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_fle_all!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_FLE_D & GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_FLE_FX & GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_FLE_XP & GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_FLE_A & GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO FLE_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_FLE_D
REM ============================================================================
     SET "TT=FILE MANAGER" & SET "FF=_APP\_FLE\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_FLE_FX


REM ============================================================================
     SET "TT=FILE MANAGER" & SET "FF=_APP\_FLE\" & SET "FL=*fx*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK    
REM ============================================================================
EXIT /B


:_FLE_XP
REM ============================================================================
     SET "TT=FILE MANAGER" & SET "FF=_APP\_FLE\" & SET "FL=*xp*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK    
REM ============================================================================
EXIT /B


:_FLE_A
REM ============================================================================
     SET "TT=FILE MANAGER" & SET "FF=_APP\_FLE\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK    
REM ============================================================================
EXIT /B


:-----------------------------


:SCR_MNU_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - SCREEN SAVER'S -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.

     IF /i "%_MNF%"=="AMAZON" IF %_FWA% GTR 8100 GOTO _XNUSCR_B
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 GOTO _XNUSCR_C

: XNUSCR_A

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_scr_av!"
     SET "PAR03=   !str_mnu_scr_cl!"
     SET "PAR04=   !str_mnu_scr_co!"
     SET "PAR05=   !str_mnu_scr_do!"
     SET "PAR06=   !str_mnu_scr_bd!"
     SET "PAR07=   !str_mnu_scr_bl!"
     SET "PAR08=   !str_mnu_scr_fo!"
     SET "PAR09=   !str_mnu_scr_ma!"
     SET "PAR10=   !str_mnu_scr_wv!"
     SET "PAR11=   !str_mnu_scr_w3!"
     SET "PAR12=    --------------------------------------------"
     SET "PAR13= !str_ski!"
     SET "PAR14= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XN)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_AV)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_CL)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_CO)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_DO)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_BD)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_BL)
     IF /i "%ERRORLEVEL%" == "8"  (CALL :_FO)
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_MA)
     IF /i "%ERRORLEVEL%" == "10" (CALL :_WV)
     IF /i "%ERRORLEVEL%" == "11" (CALL :_W3)
     IF /i "%ERRORLEVEL%" == "12" (GOTO SCR_MNU_XN)
     IF /i "%ERRORLEVEL%" == "13" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "14" (GOTO MODE_SELECT_MENU)

REM ----------------------------------------------------------------------------
EXIT /B
REM ----------------------------------------------------------------------------

:_XNUSCR_B

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    ----------------------------------------"
     SET "PAR02=   !str_mnu_scr_av!"
     SET "PAR03=   !str_mnu_scr_cl!"
     SET "PAR04=   !str_mnu_scr_co!"
     SET "PAR05=    ----------------------------------------"
     SET "PAR06= !str_ski!"
     SET "PAR07= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XN)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_AV)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_CL)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_CO)
     IF /i "%ERRORLEVEL%" == "5"  (GOTO SCR_MNU_XN) 
     IF /i "%ERRORLEVEL%" == "6"  (EXIT /B)                                   
     IF /i "%ERRORLEVEL%" == "7"  (GOTO MODE_SELECT_MENU)   

REM ============================================================================
EXIT /B


:_XNUSCR_C

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_scr_av!"
     SET "PAR03=   !str_mnu_scr_cl!"
     SET "PAR04=   !str_mnu_scr_bd!"
     SET "PAR05=   !str_mnu_scr_bl!"
     SET "PAR06=   !str_mnu_scr_fo!"
     SET "PAR07=    --------------------------------------------"
     SET "PAR08= !str_ski!"
     SET "PAR09= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XN)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_AV)
     IF /i "%ERRORLEVEL%" == "3"  (CALL :_CL)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_BD)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_BL)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_FO)
     IF /i "%ERRORLEVEL%" == "7"  (GOTO SCR_MNU_XN)
     IF /i "%ERRORLEVEL%" == "8"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "9"  (GOTO MODE_SELECT_MENU)

REM ----------------------------------------------------------------------------
EXIT /B
REM ----------------------------------------------------------------------------


:SCR_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - SCREEN SAVER'S -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.

     IF /i "%_MNF%"=="AMAZON" IF %_FWA% GTR 8100 GOTO _MNUSCR_B
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 GOTO _MNUSCR_C

: MNUSCR_A

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_scr_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_scr_av!"
     SET "PAR05=   !str_mnu_scr_cl!"
     SET "PAR06=   !str_mnu_scr_co!"
     SET "PAR07=   !str_mnu_scr_do!"
     SET "PAR08=   !str_mnu_scr_bd!"
     SET "PAR09=   !str_mnu_scr_bl!"
     SET "PAR10=   !str_mnu_scr_fo!"
     SET "PAR11=   !str_mnu_scr_ma!"
     SET "PAR12=   !str_mnu_scr_wv!"
     SET "PAR13=   !str_mnu_scr_w3!"
     SET "PAR14=    --------------------------------------------"
     SET "PAR15= !str_pre!"
     SET "PAR16= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%" "%PAR12%" "%PAR13%" "%PAR14%" "%PAR15%" "%PAR16%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_SCR_D & GOTO SCR_MNU_XC)            
     IF /i "%ERRORLEVEL%" == "3"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_AV & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_CL & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_CO & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_DO & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (CALL :_BD & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (CALL :_BL & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "10" (CALL :_FO & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "11" (CALL :_MA & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "12" (CALL :_WV & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "13" (CALL :_W3 & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "14" (GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "15" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "16" (GOTO MODE_SELECT_MENU)

REM ----------------------------------------------------------------------------
EXIT /B
REM ----------------------------------------------------------------------------

:_MNUSCR_B

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    ----------------------------------------"
     SET "PAR02=   !str_mnu_scr_del!"
     SET "PAR03=    ----------------------------------------"
     SET "PAR04=   !str_mnu_scr_av!"
     SET "PAR05=   !str_mnu_scr_cl!"
     SET "PAR06=   !str_mnu_scr_co!"
     SET "PAR07=    ----------------------------------------"
     SET "PAR08= !str_pre!"
     SET "PAR09= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_SCR_D & GOTO SCR_MNU_XC)            
     IF /i "%ERRORLEVEL%" == "3"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_AV & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_CL & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_CO & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (GOTO SCR_MNU_XC) 
     IF /i "%ERRORLEVEL%" == "8"  (EXIT /B)                                   
     IF /i "%ERRORLEVEL%" == "9"  (GOTO MODE_SELECT_MENU)   

REM ============================================================================
EXIT /B

:_MNUSCR_C

     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_scr_mnu!:
     "!CE!"  !str_mnu_scr_inf! 
     ECHO.
     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_scr_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_scr_av!"
     SET "PAR05=   !str_mnu_scr_cl!"
     SET "PAR06=   !str_mnu_scr_bd!"
     SET "PAR07=   !str_mnu_scr_bl!"
     SET "PAR08=   !str_mnu_scr_fo!"
     SET "PAR09=    --------------------------------------------"
     SET "PAR10= !str_pre!"
     SET "PAR11= !str_exi!"
     
     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" "%PAR11%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_SCR_D & GOTO SCR_MNU_XC)            
     IF /i "%ERRORLEVEL%" == "3"  (GOTO SCR_MNU_XC)                            
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_AV & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_CL & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (CALL :_BD & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_BL & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (CALL :_FO & GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (GOTO SCR_MNU_XC)
     IF /i "%ERRORLEVEL%" == "10" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "11" (GOTO MODE_SELECT_MENU)

REM ----------------------------------------------------------------------------
EXIT /B
REM ----------------------------------------------------------------------------


:_SCR_D
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.amazon.ftv.screensaver/.app.services.ScreensaverService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_FWA% GEQ 8100 SET "TT=AMBIENT" & SET "FF=_UPD\" & SET "FL=*ftvambient*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_CL
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*clock*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                                                           
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'systems.sieber.fsclock/systems.sieber.fsclock.FullscreenDream' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*klock*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_CO
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*constellations*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                                                            
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.screensavers_store.constellationstvlivewallpaper/com.screensavers_store.constellationstvlivewallpaper.daydream.WaveDaydreamService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*konstellations*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_DO
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*ShiningDots*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                                                            
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.screensavers_store.shiningdotslivewallpaper/com.screensavers_store.shiningdotslivewallpaper.daydream.WaveDaydreamService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*zhiningDots*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_AE
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*Aerial_Dream*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                                      
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.codingbuffalo.aerialdream/com.codingbuffalo.aerialdream.AerialDream' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*oerialDream*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_AV
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*Aerial_Views*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                    
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.neilturner.aerialviews/com.neilturner.aerialviews.ui.screensaver.DreamActivity' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*oerialViews*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_BD
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*backdrop*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------                                                                                                                                                          
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.google.android.backdrop/com.google.android.backdrop.Backdrop' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_BL
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*blaze*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.pirinel.blaze/com.pirinel.blaze.MyDream' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_FO
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*fotoo*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.bo.fotoo/com.bo.fotoo.ui.dream.FTDreamService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_MA
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*marine*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.acrodea.fish/com.prolific.marineaquarium.daydream.MarineAquariumDayDream' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B

:_MX
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*matrix*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.acrodea.fish/com.prolific.marineaquarium.daydream.MarineAquariumDayDream' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30 IF %_FWA% GTR 8100 SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\LNK\" & SET "FL=*natrix*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B

:_WV
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*wave_2d*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'wave.paperworld.wallpaper/wave.paperworld.daydream.WaveDaydreamService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_W3
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*wave_3d*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "settings put secure screensaver_components 'com.paperworldcreation.wave2/com.paperworldcreation.wave2.daydream.WaveDreamService' ; settings put secure screensaver_default_component 'com.amazon.ftv.screensaver/.app.services.ScreensaverService'" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_SCR_SET
REM ============================================================================
EXIT /B


:_SCR_MAN
REM ============================================================================
     SET "TT=SCREEN SAVER'S" & SET "FF=_APP\_SCR\" & SET "FL=*ss_manager*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================                                                                                                 
EXIT /B                                                                                                                                                                                
                                                                                                                                                                                        
                                                                                                                                                                                        
:_SCR_SET                                                                                                                                                                               
REM ============================================================================                                                                                                       
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell " settings put secure screensaver_enabled 1 ; settings put secure screensaver_activate_on_dock 1 ; settings put secure screensaver_activate_on_sleep 1 " >NUL 2>&1
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell " settings put secure lock_screen_allow_private_notifications 1 ; settings put secure lock_screen_owner_info_enabled 0 ; settings put secure lock_screen_show_notifications 1 ; settings put secure lockscreen.disabled 1 ; smart_home_lock_screen_access 0 " >NUL 2>&1
REM ----------------------------------------------------------------------------                                                                                                                                                                               
REM  строчка "Put device to sleep" в настройках системы
REM  параметр "sleep_timeout" в "settings secure":
REM ----------------------------------------------------------------------------  
REM  - "-1" - "NEVER", DEFAULT - ATV [TIVO]                                                                                                                                                       
REM  - "1200000" - 20 MIN, DEFAULT - AMAZON KARAT 8100 
REM ----------------------------------------------------------------------------                                                                                                                                                 
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell settings put secure sleep_timeout "1200000"     >NUL 2>&1                                   
REM ----------------------------------------------------------------------------
REM ----------------------------------------------------------------------------                                                                                                                                                                               
REM  строчка "When to start" в настройках системы
REM  параметр "screen_off_timeout" в "settings system":
REM ----------------------------------------------------------------------------
REM  - "900000" - "After 15 minutes of inactivity", DEFAULT - ATV [TIVO]
REM  - "2147483647" - "After of inactivity", DEFAULT - ATV [SHIELD]
REM  - "300000" - 5 MIN, DEFAULT - AMAZON KARAT 8100                                                                                                                                               
REM ----------------------------------------------------------------------------                                                                                                                                                  
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell settings put system screen_off_timeout "300000" >NUL 2>&1                                   
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell settings put system dim_screen "1"        >NUL 2>&1
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell settings put secure adaptive_sleep "null" >NUL 2>&1
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell " chmod 0777 /data/local/tmp/scr.sh; sh /data/local/tmp/scr.sh " >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:RAD_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - INET RADIO -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_rad_mnu!:
     "!CE!"  !str_mnu_rad_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_rad_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_rad_fmp!"
     SET "PAR05=   !str_mnu_rad_tun!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_rad_all!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%" 

     IF /i "%ERRORLEVEL%" == "1"  (GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_RAD_D & GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_RAD_FMP & GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_RAD_TUN & GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_RAD_A & GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO RAD_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_RAD_D
REM ============================================================================
     SET "TT=INET RADIO" & SET "FF=_APP\_RAD\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_RAD_FMP
REM ============================================================================
     SET "TT=INET RADIO" & SET "FF=_APP\_RAD\" & SET "FL=*fmplay*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_RAD_TUN
REM ============================================================================
     SET "TT=INET RADIO" & SET "FF=_APP\_RAD\" & SET "FL=*tunein*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_RAD_A
REM ============================================================================
     SET "TT=INET RADIO" & SET "FF=_APP\_RAD\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:CNM_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     IF %_SDK% EQU 22 EXIT /B

     COLOR 02
     TITLE - CINEMA -

     CLS
     
     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_cnm_mnu!:
     "!CE!"  !str_mnu_cnm_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_cnm_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_cnm_me!"
     SET "PAR05=   !str_mnu_cnm_kn!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_cnm_all!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_CNM_D & GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_CNM_ME & GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_CNM_KN & GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_CNM_A & GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO CNM_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_CNM_D
REM ============================================================================
     SET "TT=CINEMA" & SET "FF=_APP\_CNM\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_CNM_KN
REM ============================================================================
     SET "TT=CINEMA" & SET "FF=_APP\_CNM\" & SET "FL=*kion*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_CNM_ME
REM ============================================================================
     SET "TT=CINEMA" & SET "FF=_APP\_CNM\" & SET "FL=*megogo*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_CNM_A
REM ============================================================================
     SET "TT=CINEMA" & SET "FF=_APP\_CNM\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:DLN_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - MIRACAST ^& DLNA -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_dln_mnu!:
     "!CE!"  !str_mnu_dln_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_dln_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_dln_air!"
     SET "PAR05=   !str_mnu_dln_ais!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07=   !str_mnu_dln_all!"
     SET "PAR08=    --------------------------------------------"
     SET "PAR09= !str_pre!"
     SET "PAR10= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%" "%PAR10%"

     IF /i "%ERRORLEVEL%" == "1"  (GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2"  (CALL :_DLN_D & GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3"  (GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4"  (CALL :_DLN_AIR & GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5"  (CALL :_DLN_AIS & GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6"  (GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7"  (CALL :_DLN_A & GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8"  (GOTO DLN_MNU_XC)
     IF /i "%ERRORLEVEL%" == "9"  (EXIT /B)
     IF /i "%ERRORLEVEL%" == "10" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_DLN_D
REM ============================================================================
     SET "TT=MIRACAST & DLNA" & SET "FF=_APP\_DLN\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_DLN_AIR
REM ============================================================================
     SET "TT=MIRACAST & DLNA" & SET "FF=_APP\_DLN\" & SET "FL=*receiver*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_DLN_AIS
REM ============================================================================
     SET "TT=MIRACAST & DLNA" & SET "FF=_APP\_DLN\" & SET "FL=*screen*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:_DLN_A
REM ============================================================================
     SET "TT=MIRACAST & DLNA" & SET "FF=_APP\_DLN\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:-----------------------------


:STT_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - SETTING'S -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_stt_mnu!:
     "!CE!"  !str_mnu_stt_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_stt_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_stt_tsy!"
     SET "PAR05=   !str_mnu_stt_nol!"
     SET "PAR06=   !str_mnu_stt_min!"
     SET "PAR07=    --------------------------------------------"
     SET "PAR08= !str_pre!"
     SET "PAR09= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%" "%PAR09%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_STT_D & CALL :_RES_LAU & GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3" (GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4" (CALL :_STT_TSY & CALL :_RES_LAU & GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5" (CALL :_STT_NOL & CALL :_RES_LAU & GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6" (CALL :_STT_MIN & CALL :_RES_LAU & GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7" (GOTO STT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "8" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "9" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_STT_D
REM ============================================================================
     SET "TT=SETTING'S" & SET "FF=_APP\_STT\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_STT_TSY
REM ============================================================================
     SET "TT=SETTING'S" & SET "FF=_APP\_STT\" & SET "FL=*TSY*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_STT_TSY_THM
REM ============================================================================
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm uninstall com.amazon.tv.launcher" >NUL 2>&1
REM ----------------------------------------------------------------------------
     SET "TT=SETTING'S" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*TSY*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_STT_NOL
REM ============================================================================
     SET "TT=SETTING'S" & SET "FF=_APP\_STT\" & SET "FL=*NOL*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_STT_NOL_THM
REM ============================================================================
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm uninstall com.amazon.tv.launcher" >NUL 2>&1
REM ----------------------------------------------------------------------------
     SET "TT=SETTING'S" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*NOL*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_STT_MIN
REM ============================================================================
     SET "TT=SETTING'S" & SET "FF=_APP\_STT\" & SET "FL=*MIN*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
REM ============================================================================
EXIT /B





:-----------------------------


:_UPD
REM ============================================================================

     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22                    SET "TT=UPDATE" & SET "FF=_UPD\5N\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 22 IF %_FWA% GEQ 5281 SET "TT=UPDATE" & SET "FF=_UPD\5U\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 

     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 25                    SET "TT=UPDATE" & SET "FF=_UPD\6N\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 25 IF %_FWA% GEQ 6281 SET "TT=UPDATE" & SET "FF=_UPD\6U\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 

     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 28                    SET "TT=UPDATE" & SET "FF=_UPD\7\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% EQU 30                    SET "TT=UPDATE" & SET "FF=_UPD\8\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK
 
     IF /i "%_MNF%"=="AMAZON" IF %_SDK% GEQ 25                    SET "TT=UPDATE" & SET "FF=_UPD\678\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 

REM ----------------------------------------------------------------------------
REM     REM ПРОВЕРЯЕМ, ЧТО СТОК ЛОНЧЕР ВКЛЮЧЁН - ЕСЛИ НЕТ, ПРОПУСКАЕМ
REM     _BIN\ADB.EXE -s "%_NFF_I%" shell pm list packages -d -s | FINDSTR "com.amazon.tv.launcher" >NUL 2>&1
REM     IF %ERRORLEVEL% EQU 0 EXIT /B
REM ----------------------------------------------------------------------------

REM ----------------------------------------------------------------------------
     CALL :_RES_LAU  
REM ============================================================================
EXIT /B


:-----------------------------


:DRW_MNU_XN_
:_DRW_XN
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - APP'S DRAWER -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_drw_mnu!:
     "!CE!"  !str_mnu_drw_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_drw_dsh!"
     SET "PAR03=   !str_mnu_drw_drw!"
     SET "PAR04=    --------------------------------------------"
     SET "PAR05= !str_ski!"
     SET "PAR06= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO DRW_MNU_XN)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_DRW_DSH & CALL :_RES_LAU)
     IF /i "%ERRORLEVEL%" == "3" (CALL :_DRW_DRW & CALL :_RES_LAU)
     IF /i "%ERRORLEVEL%" == "4" (GOTO DRW_MNU_XN)
     IF /i "%ERRORLEVEL%" == "5" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "6" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:DRW_MNU_XC
:_DRW_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - APP'S DRAWER -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_drw_mnu!:
     "!CE!"  !str_mnu_drw_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_drw_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_drw_dsh!"
     SET "PAR05=   !str_mnu_drw_drw!"
     SET "PAR06=    --------------------------------------------"
     SET "PAR07= !str_pre!"
     SET "PAR08= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%" "%PAR08%"
REM  "!MU!" 0660 "    ---------------------------------------" "   !str_mnu_drw_del!" "    ---------------------------------------" "   !str_mnu_drw_dsh!" "   !str_mnu_drw_drw!" "    ---------------------------------------" " !str_pre!" " !str_exi!"

     IF /i "%ERRORLEVEL%" == "1" (GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_DRW_D & CALL :_RES_LAU & GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3" (GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4" (CALL :_DRW_DSH & CALL :_RES_LAU & GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5" (CALL :_DRW_DRW & CALL :_RES_LAU & GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6" (GOTO DRW_MNU_XC)
     IF /i "%ERRORLEVEL%" == "7" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "8" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_DRW_D
REM ============================================================================
     SET "TT=APP'S DRAWER" & SET "FF=_APP\_DRW\" & SET "FL=*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK
REM ============================================================================
EXIT /B


:_DRW_DRW
REM ============================================================================
     SET "TT=APP'S DRAWER" & SET "FF=_APP\_DRW\" & SET "FL=*TVA*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ============================================================================
EXIT /B


:_DRW_DRW_THM
REM ============================================================================
     SET "TT=APP'S DRAWER" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*TVA*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ============================================================================
EXIT /B


:_DRW_DSH
REM ============================================================================
     SET "TT=APP'S DRAWER" & SET "FF=_APP\_DRW\" & SET "FL=*DSH*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ============================================================================
EXIT /B


:_DRW_DSH_THM
REM ============================================================================
     SET "TT=APP'S DRAWER" & SET "FF=_THM\%THM_NAM%\" & SET "FL=*DSH*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK  
REM ============================================================================
EXIT /B


:-----------------------------


:_RUN
REM ============================================================================
     SET "TT=STARTUP MANAGER" & SET "FF=_APP\_RUN\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ============================================================================
EXIT /B


:-----------------------------


:-----------------------------


:KAT_MNU_XC
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     COLOR 02
     TITLE - KATNISS -

     CLS

     ECHO.
     ECHO                                                                 #NFF - VER 0.9
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO   !str_mnu_kat_mnu!:
     "!CE!"  !str_mnu_kat_inf!  
     ECHO.

     SET "PAR01=    --------------------------------------------"
     SET "PAR02=   !str_mnu_kat_del!"
     SET "PAR03=    --------------------------------------------"
     SET "PAR04=   !str_mnu_kat_add!"
     SET "PAR05=    --------------------------------------------"
     SET "PAR06= !str_pre!"
     SET "PAR07= !str_exi!"

     "!MU!" 0660 "%PAR01%" "%PAR02%" "%PAR03%" "%PAR04%" "%PAR05%" "%PAR06%" "%PAR07%"

     IF /i "%ERRORLEVEL%" == "1" (GOTO KAT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "2" (CALL :_KAT_D & GOTO KAT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "3" (GOTO KAT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "4" (CALL :_KAT & GOTO KAT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "5" (GOTO KAT_MNU_XC)
     IF /i "%ERRORLEVEL%" == "6" (EXIT /B)
     IF /i "%ERRORLEVEL%" == "7" (GOTO MODE_SELECT_MENU)

REM ============================================================================
EXIT /B


:_KAT_D
REM ============================================================================
     SET "TT=KATNISS" & SET "FF=_APP\_KAT\" & SET "*.APK" & SET "II=0" & SET "SS=1" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm enable com.amazon.vizzini" >NUL 2>&1                                                     
REM ============================================================================
EXIT /B


:_KAT
REM ============================================================================
     SET "TT=KATNISS" & SET "FF=_APP\_KAT\" & SET "FL=*.APK" & SET "II=1" & SET "SS=0" & CALL :_UIC_APK 
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm disable-user com.amazon.vizzini" >NUL 2>&1                                                     
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant com.google.android.katniss android.permission.SYSTEM_ALERT_WINDOW ; pm grant com.google.android.katniss android.permission.RECORD_AUDIO" >NUL 2>&1  
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant org.liskovsoft.androidtv.rukeyboard android.permission.RECORD_AUDIO ; pm grant com.liskovsoft.leankeyboard android.permission.RECORD_AUDIO" >NUL 2>&1
REM ----------------------------------------------------------------------------
     CALL :_GRA
REM ============================================================================
EXIT /B


:-----------------------------


:_GRA
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------
     SET "title_text=PLEASE, WAIT" & CALL :_WAI
REM ----------------------------------------------------------------------------
REM      FOR /f "tokens=*" %%a IN ('ADB.EXE -s "%_NFF_I%" shell pm list packages -3 ') DO (
REM          SET "package=%%a"
REM          SET "package=!package:package:=!"
REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !package! android.permission.ACCESS_COARSE_LOCATION" >NUL 2>&1
REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !package! android.permission.CHANGE_CONFIGURATION"   >NUL 2>&1
REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !package! android.permission.RECORD_AUDIO"           >NUL 2>&1
REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !package! android.permission.SYSTEM_ALERT_WINDOW"    >NUL 2>&1
REM          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !package! android.permission.WRITE_SECURE_SETTINGS"  >NUL 2>&1
REM      )
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE -s "%_NFF_I%" shell " pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; pm grant $ID android.permission.RECORD_AUDIO ; pm grant $ID android.permission.CHANGE_CONFIGURATION ; pm grant $ID android.permission.WRITE_SECURE_SETTINGS ; pm grant $ID android.permission.SYSTEM_ALERT_WINDOW ; pm grant $ID android.permission.ACCESS_COARSE_LOCATION ; pm grant $ID android.permission.READ_LOGS ; done " >NUL 2>&1
     _BIN\ADB.EXE -s "%_NFF_I%" shell " chmod 0777 /data/local/tmp/gra.sh; sh /data/local/tmp/gra.sh " >NUL 2>&1
REM ============================================================================
EXIT /B

:-----------------------------


:_ENQ
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     TITLE - COMPLETE -
     COLOR 08

     CLS

     ECHO. 
     "!CE!"                                                                 {4F}#NFF{#} {07}- VER 0.9{#}{\n}
     ECHO.                        
     ECHO. 
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.     
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                              !str_sta_enq!
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

REM ----------------------------------------------------------------------------
     ::REM CONH "%NFF_A%" shell jobs -p | "%NFF_H%XARGS.EXE" kill -9
     ::REM CONH "%NFF_A%" shell jobs -p | "%NFF_A%" shell xargs kill -SIGKILL $$ 
     ::REM CONH "%NFF_A%" shell jobs -p | "%NFF_H%XARGS.EXE" kill -2
     ::REM CONH "%NFF_A%" shell jobs -p | "%NFF_A%" shell xargs kill -SIGINT $$
REM ----------------------------------------------------------------------------
     _BIN\ADB.EXE -s "%_NFF_I%" shell reboot
REM ----------------------------------------------------------------------------
     SET "_NFF_I="
REM ----------------------------------------------------------------------------
     DEL /S /F /Q *.TMP *.SER *.MOR >NUL 2>&1
REM ----------------------------------------------------------------------------
REM  _BIN\ADB.EXE kill-server >NUL 2>&1                                        
     TASKKILL /F /IM ADB.EXE  >NUL 2>&1
REM ----------------------------------------------------------------------------
     PING -n 10 127.0.0.1 > NUL
REM ----------------------------------------------------------------------------
     CALL :_LAT
REM ============================================================================
EXIT /B


:-----------------------------


:_LAT
REM ============================================================================
     MODE CON:COLS=80 LINES=29
REM ----------------------------------------------------------------------------

     TITLE - COMPLETE -
     COLOR 07

     CLS

     ECHO. 
     ECHO.
     ECHO.                        
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

     "!CE!"            !str_lat_1!
     "!CE!"            !str_lat_2!
     ECHO.
     "!CE!"            !str_lat_3!
     ECHO.
     "!CE!"            !str_lat_4!
     ECHO.
     "!CE!"            !str_lat_5!
     ECHO.
     "!CE!"            !str_lat_6!
     ECHO.
     ECHO.
     ECHO.

     ECHO.
     "!CE!"      {06}paypal.me/VadimRogach{\n}{#}
     ECHO.
     "!CE!"      {06}yoomoney.ru/to/410011399723731{\n}{#}
     "!CE!"                                                 !str_enter_con_a!{\n}
     "!CE!"                                                 !str_enter_con_b!{\n}

REM ----------------------------------------------------------------------------
     PAUSE                                                           >NUL 2>&1
REM ============================================================================
EXIT /B


:-----------------------------


:_UIC_APK
REM ==================================================================================
REM  SET "TT=!str_ply_ttl!" & SET "FF=_APP\_BSE\" & SET "FL=*TV*.APK" & SET "II=1" & SET "SS=1" & CALL :_UIC_APK
REM -----------------------------------------------------------------------------
     CHCP 65001>NUL
REM -----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM -----------------------------------------------------------------------------

     setlocal

     COLOR 04
     TITLE - !TT! -

     CLS
     
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                    !str_sta_wai!{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

:_STA_UIC

     FOR /R "%FF%" %%f IN (%FL%) DO (

          CALL :UPPERCASE "%%~xnf" "apk_NAME"

          FOR /F "tokens=2 delims=: " %%j IN ('!AP! dump badging "%%f" ^| FINDSTR /r /c:"^package: name="') DO FOR /f "tokens=2 delims=='" %%k IN ("%%j") DO SET "pkg_NAME=%%k"

          FOR /F "tokens=2 delims=:'" %%g IN ('!AP! dump badging "%%f" ^| FINDSTR /c:"application-label:"') DO SET "label_EN=%%g"
          CALL :UPPERCASE "!label_EN!" "label_EN"

          FOR /F "tokens=6 delims=='" %%g IN ('!AP! dump badging "%%f" ^| FINDSTR /c:"versionName"') DO SET "app_VER=%%g"
          CALL :UPPERCASE "!app_VER!" "app_VER"

          COLOR 04
          TITLE - !TT! -

          CLS
          
          "!CE!" {\n}

          IF "%II%"=="1" (
               "!CE!" {20} {00} {20} INSTALL {#}{\n}
          ) ELSE (
               "!CE!" {40} {00} {40} CLEAN {#}{\n}
          )

          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!"                    !str_sta_wai!{\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}
          "!CE!" {\n}

          IF "%SS%"=="1" (
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
               "!CE!" {\n}
          )
          
          IF "%II%"=="1" IF "%SS%"=="0" (
               "!CE!" {00} {06} NAM: {08}!label_EN!{\n}
               "!CE!" {00} {06} VER: {08}!app_VER!{\n}
               "!CE!" {00} {06} PKG: {08}!pkg_NAME!{\n}
               "!CE!" {00} {06} APK: {08}!apk_NAME!{\n}
          )
     
          IF "%II%"=="0" IF "%SS%"=="0" (
               "!CE!" {\n}
               "!CE!" {00} {06} NAM: {08}!label_EN!{\n}
               "!CE!" {00} {06} VER: {08}!app_VER!{\n}
               "!CE!" {00} {06} PKG: {08}!pkg_NAME!{\n}
          )
     
          _BIN\ADB.EXE -s "%_NFF_I%" shell "pm uninstall !pkg_NAME!" >NUL 2>&1

          IF "%II%"=="1" (

               _BIN\ADB.EXE -s "%_NFF_I%" install %INS_OPT% "%%f" >NUL 2>&1

               REM _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !pkg_NAME! android.permission.RECORD_AUDIO ; pm grant !pkg_NAME! android.permission.WRITE_SECURE_SETTINGS ; pm grant !pkg_NAME! android.permission.CHANGE_CONFIGURATION" >NUL 2>&1
               REM _BIN\ADB.EXE -s "%_NFF_I%" shell "pm grant !pkg_NAME! android.permission.ACCESS_COARSE_LOCATION ; pm grant !pkg_NAME! android.permission.SYSTEM_ALERT_WINDOW ; pm grant !pkg_NAME! android.permission.READ_LOGS" >NUL 2>&1
               REM _BIN\ADB.EXE -s "%_NFF_I%" shell "pm list packages -3 | while read -r PKG; do ID=${PKG##*:}; pm grant $ID android.permission.RECORD_AUDIO ; pm grant $ID android.permission.CHANGE_CONFIGURATION ; pm grant $ID android.permission.WRITE_SECURE_SETTINGS ; pm grant $ID android.permission.SYSTEM_ALERT_WINDOW ; pm grant $ID android.permission.ACCESS_COARSE_LOCATION ; pm grant $ID android.permission.READ_LOGS ; done " >NUL 2>&1

               _BIN\ADB.EXE -s "%_NFF_I%" shell " chmod 0777 /data/local/tmp/gra_c.sh; sh /data/local/tmp/gra_c.sh !pkg_NAME! " >NUL 2>&1

          )

     )

:_END_UIC

REM -----------------------------------------------------------------------------
     CHCP 1251>NUL
REM -----------------------------------------------------------------------------
     MODE CON:COLS=80 LINES=29
REM -----------------------------------------------------------------------------

     COLOR 04
     TITLE - !TT! -

     CLS
     
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     "!CE!"                    !str_sta_wai!{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

     endlocal

REM ==================================================================================
EXIT /B


:-----------------------------
:-----------------------------
:-----------------------------
:-----------------------------
:-----------------------------
:-----------------------------


:---------------------------------------
:---_LANGUAGE_---
:---------------------------------------


:setlanguage


REM ----------------------------------------------------------------------------                                                                                                        
     MODE CON:COLS=80 LINES=27                                                                                                                                                         
REM ----------------------------------------------------------------------------

     COLOR 0F
     TITLE - LANG - 

     CLS

     ECHO. 
     "!CE!"                                                                 {4F}#NFF{#} {0F}- VER 0.9{#}{\n}
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.
     ECHO.

     "!CE!" ^|  {0A}MENU LANG:{# #}{\n}
     ECHO.

     "!MU!" 0660 "|  ENGLISH" "|  RUSSIAN"

     IF /i "%ERRORLEVEL%" == "1" (SET language=english)
     IF /i "%ERRORLEVEL%" == "2" (SET language=russian)
     ECHO language=!language!>_LNG\lang


:__language


        CHCP 1252>NUL
        REM команда читает файл _LNG\english.lng и преобразует каждую строку в пару ключ-значение, которые затем сохраняются в переменных окружения. Переменные получают префикс str_
        REM игнорирует строки, начинающиеся с ;
        FOR /F "EOL=; TOKENS=1* DELIMS==" %%a IN ('TYPE "_LNG\english.lng"') DO SET str_%%a=%%b


        REM если выбранный язык - английский, прекращают дальнейшую обработку
        IF "!language!"=="english" GOTO:EOF


        REM команда обрабатывает файл .lng, игнорирует строки, начинающиеся с ;
        FOR /F "EOL=; TOKENS=1* DELIMS==" %%a IN ('TYPE "_LNG\!language!.lng"') DO @(
           REM проверяет, начинается ли каждая строка со слова "codepage". если это так, то она меняет кодовую страницу командной строки на значение, следующее после "codepage"
           IF "%%a"=="codepage" CHCP %%b>NUL
        )


        REM команда читает файл _LNG\!language!.lng и преобразует каждую строку в пару ключ-значение, которые затем сохраняются в переменных окружения. Переменные получают префикс str_
        REM игнорирует строки, начинающиеся с ;
        FOR /F "EOL=; TOKENS=1* DELIMS==" %%a IN ('TYPE "_LNG\!language!.lng"') DO SET str_%%a=%%b
        GOTO:EOF


:---------------------------------------


:---------------------------------------
:---_UPPERCASE_---
:---------------------------------------


REM ============================================================================
:UCA
REM ============================================================================
SET %~1=!%~1:a=A!
SET %~1=!%~1:b=B!
SET %~1=!%~1:c=C!
SET %~1=!%~1:d=D!
SET %~1=!%~1:e=E!
SET %~1=!%~1:f=F!
SET %~1=!%~1:g=G!
SET %~1=!%~1:h=H!
SET %~1=!%~1:i=I!
SET %~1=!%~1:j=J!
SET %~1=!%~1:k=K!
SET %~1=!%~1:l=L!
SET %~1=!%~1:m=M!
SET %~1=!%~1:n=N!
SET %~1=!%~1:o=O!
SET %~1=!%~1:p=P!
SET %~1=!%~1:q=Q!
SET %~1=!%~1:r=R!
SET %~1=!%~1:s=S!
SET %~1=!%~1:t=T!
SET %~1=!%~1:u=U!
SET %~1=!%~1:v=V!
SET %~1=!%~1:w=W!
SET %~1=!%~1:x=X!
SET %~1=!%~1:y=Y!
SET %~1=!%~1:z=Z!
SET %~1=!%~1:а=А!
SET %~1=!%~1:б=Б!
SET %~1=!%~1:в=В!
SET %~1=!%~1:г=Г!
SET %~1=!%~1:д=Д!
SET %~1=!%~1:е=Е!
SET %~1=!%~1:ё=Ё!
SET %~1=!%~1:ж=Ж!
SET %~1=!%~1:з=З!
SET %~1=!%~1:и=И!
SET %~1=!%~1:й=Й!
SET %~1=!%~1:к=К!
SET %~1=!%~1:л=Л!
SET %~1=!%~1:м=М!
SET %~1=!%~1:н=Н!
SET %~1=!%~1:о=О!
SET %~1=!%~1:п=П!
SET %~1=!%~1:р=Р!
SET %~1=!%~1:с=С!
SET %~1=!%~1:т=Т!
SET %~1=!%~1:у=У!
SET %~1=!%~1:ф=Ф!
SET %~1=!%~1:х=Х!
SET %~1=!%~1:ш=Ш!
SET %~1=!%~1:щ=Щ!
SET %~1=!%~1:ь=Ь!
SET %~1=!%~1:ъ=Ъ!
SET %~1=!%~1:э=Э!
SET %~1=!%~1:ю=Ю!
SET %~1=!%~1:я=Я!
REM ============================================================================
EXIT /B


:---------------------------------------


REM ============================================================================
:UCB
REM ============================================================================
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z" "а=А" "б=Б" "в=В" "г=Г" "д=Д" "е=Е" "ё=Ё" "ж=Ж" "з=З" "и=И" "й=Й" "к=К" "л=Л" "м=М" "н=Н" "о=О" "п=П" "р=Р" "с=С" "т=Т" "у=У" "ф=Ф" "х=Х" "ш=Ш" "щ=Щ" "ь=Ь" "ъ=Ъ" "э=Э" "ю=Ю" "я=Я") DO CALL SET "%1=%%%1:%%~i%%"
REM ============================================================================
EXIT /B


:---------------------------------------


REM ============================================================================
REM ПРОЦЕДУРА UPPERCASE
REM 
REM %1 : СТРОКА ТЕКСТА
REM %2 : ИМЯ ПЕРЕМЕННОЙ ДЛЯ ВОЗВРАТА ТРАНСЛИРОВАННОГО ЗНАЧЕНИЯ
REM ============================================================================


REM ============================================================================
:UPPERCASE
REM ============================================================================
     SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
    
     CALL :TRANSLATE "%~1" "U" "strTempString"
    
     ENDLOCAL & SET %~2=%strTempString%
REM ============================================================================
EXIT /B 0


REM ============================================================================
:TRANSLATE
REM ============================================================================
     SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
    
     SET strTempString=%~1
    
     FOR /f "tokens=2,3" %%i IN ('findstr.exe /b /l "# " "%~f0"') DO (
          IF /i "%~2" EQU "L" (
               SET strTempString=!strTempString:%%~i=%%~j!
          ) ELSE IF /i "%~2" EQU "U" (
               SET strTempString=!strTempString:%%~j=%%~i!
          )
     )
    
     ENDLOCAL & SET %~3=%strTempString%
REM ============================================================================
EXIT /B 0


REM ============================================================================
REM  ТАБЛИЦА ТРАНСЛЯЦИИ СИМВОЛОВ
REM ============================================================================
#    
# A a
# B b
# C c
# D d
# E e
# F f
# G g
# H h
# I i
# J j
# K k
# L l
# M m
# N n
# O o
# P p
# Q q
# R r
# S s
# T t
# U u
# V v
# W w
# X x
# Y y
# Z z
# А а
# Б б
# В в
# Г г
# Д д
# Е е
# Ё ё
# Ж ж
# З з
# И и
# Й й
# К к
# Л л
# М м
# Н н
# О о
# П п
# Р р
# С с
# Т т
# У у
# Ф ф
# Х х
# Ц ц
# Ч ч
# Ш ш
# Щ щ
# Ъ ъ
# Ы ы
# Ь ь
# Э э
# Ю ю
# Я я
REM ============================================================================