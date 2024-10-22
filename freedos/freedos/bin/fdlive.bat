@echo off

if not "%1" == "" goto %1
if not "%1" == "" goto Error

:RAMSKIP

set AUTOFILE=%PATH%FDAUTO.BAT
set CFGFILE=%PATH%FDCONFIG.SYS
set PATH=%PATH%;%DOSDIR%\BIN;%DOSDIR%\LINKS
set DIRCMD=/P /OGN /Y
set COPYCMD=/-Y
set LANG=EN
set TZ=EST

set NLSPATH=%dosdir%\NLS
set HELPPATH=%dosdir%\HELP

rem SET BLASTER=A220 I5 D1 H5 P330

set OS_NAME=FreeDOS
set OS_VERSION=1.3

alias reboot=fdapm warmboot
alias reset=fdisk /reboot
alias halt=fdapm poweroff
alias shutdown=fdapm poweroff

rem alias cfg=edit %cfgfile%
rem alias auto=edit %0

goto SkipOverSection

***** Language specific text data.
English (EN)
FDLIVE_ERROR=/p /fYellow Unable to load all %1 packages -- /fDarkGray (probably) /fYellow Add more RAM! /fGrey
FDLIVE_NOCD=/p /fYellow Unable to locate %1 CD-ROM filesystem. /fGrey /p
FDLIVE_INST=Installing additional /fGreen %1 /fGray packages for live system.
FDLIVE_WRAPUP=/p Done processing startup files /fCyan %1 /a7 and /fCyan %2 /a7/p
FDLIVE_MORE=To browse or activate additional packages type /fWhite %1 /fGray
FDLIVE_SETUP=To install %1 on your hard drive type /fWhite %2 /fGray
FDLIVE_HELP=Type /fWhite %1 /fGray to get support on commands and navigation.
FDLIVE_WELCOME=Welcome to the /fGreen %1 /fCyan %2 /fGray operating system ( /s- /fYellow "%3" /fGray )
FDLIVE_LANG=/fGray /p Default language is /fLightGreen %1 /fGray

:Error
vecho /fRed unknown option /fYellow %1 /fGrey for /fWhite %0 /fGrey
goto Done

:Install
if not exist %TEMP%\fdlive.dat goto Done
if not exist %PACKAGES%\%2.zip goto Done
REM Skip Kernel and FreeCOM, transfered by SYS and don't really need them
if /I "%2" == "base\kernel" goto Done
if /I "%2" == "base\freecom" goto Done
if /I "%2" == "base\command" goto Done
echo %2| vstr /f \ 2 | set /p PKG=
REM if  out of space or general pipe failure
if "%PKG%" == "" goto SysError
vfdutil /r 1M /m %DOSDIR% >NUL
if errorlevel 1 goto LowError
vecho /n Bring /fWhite %2 /fGrey package online.
if exist %DOSDIR%\PACKAGES\%PKG%.lst goto Skipped
fdinst install %PACKAGES%\%2.zip >NUL
if errorlevel 1 goto InsError
vecho "  " /fLightGreen OK /fGrey
goto Done

:LowError
vecho /p /c32 /c32 /fLightRed RAM drive is low on free space, stopped. /fGrey
vinfo /m
if errorlevel 105 goto ErrorDone
if not errorlevel 103 goto ErrorDone
REM Increasing RAM will is only known to help with VMware and VirtualBox
vecho /c32 /c32 /fDarkGray To run %OS_NAME% complelely from RAM, /fGray
vecho /c32 /c32 /fDarkGray increase the memory allocated to the Virtual Machine. /fGrey
goto ErrorDone
:SysError
vecho /p /c32 /c32 /fLightRed Error activating packages on RAM drive. /fGrey
vecho /c32 /c32 /fLightRed Probably caused by insufficient free space. /fGrey
goto ErrorDone
:InsError
vecho "  " /fLightRed Failed /fGrey /s- , /s+ extraction error
fdinst remove %PKG% >NUL
goto ErrorDone
:Skipped
vecho "  " /fGreen Skipped /fGrey
goto Done

:ErrorDone
del %TEMP%\fdlive.dat>NUL
goto Done

:SkipOverSection
set LANGFILE=%NLSPATH%\FDLIVE.%LANG%
if not exist %LANGFILE% SET LANGFILE=%0

if "%CDROM%" == "" goto NoCDROM
if "%FDRAMDRV%" == "" goto NoRAMDrive
if "%1" == "RAMSKIP" goto NoRAMDrive
echo. >%TEMP%\fdlive.dat
:SkipTest
vecho /t %LANGFILE% FDLIVE_INST %OS_NAME%
veach /f %DOSDIR%\BIN\FDLIVE.LST /x %0 Install *
if not exist %TEMP%\fdlive.dat vdelay 1000

:NoRAMDrive
if exist %dosdir%\bin\fdassist.bat call %dosdir%\bin\fdassist.bat

if not exist %dosdir%\bin\cdrom.bat goto NoCDStatus
echo.
call %dosdir%\bin\cdrom.bat status
:NoCDStatus

REM Remove this goto to automatically start FDNet when present on some VMs
goto NoAutoFDNet
if not exist %dosdir%\bin\fdnet.bat goto WrapUp
rem Only Start FDNET on VirtualBox and vmWare
vinfo /m
if errorlevel 105 goto WrapUp
if not errorlevel 103 goto WrapUp
vdelay 1000
call %dosdir%\bin\fdnet.bat start
goto WrapUp

:NoAutoFDNet
if not exist %dosdir%\bin\fdnet.bat goto WrapUp
rem Inform about Start FDNET on VirtualBox and vmWare
vinfo /m
if errorlevel 105 goto WrapUp
if not errorlevel 103 goto WrapUp
vecho /p Type /fWhite FDNET /fGray to enable networking support.
goto WrapUp

:NoCDROM
vecho /p /t %LANGFILE% FDLIVE_NOCD %OS_NAME% %OS_VERSION%
rem if exist %DOSDIR%\BIN\FDAPM.COM FDAPM.COM
goto FinalMessages

:WrapUp
rem if exist %DOSDIR%\BIN\FDAPM.COM FDAPM.COM
if exist %DOSDIR%\BIN\CTMOUSE.EXE CTMOUSE.EXE

if exist %TEMP%\fdlive.dat goto CompletelyLoaded
:Incomplete
set PATH=%PATH%;%CDROM%\FREEDOS\BIN;%CDROM%\FREEDOS\LINKS
vecho /t %LANGFILE% FDLIVE_ERROR %OS_NAME% %OS_VERSION%
goto FinalMessages

:CompletelyLoaded
del %TEMP%\fdlive.dat>NUL

:FinalMessages

vecho /t %LANGFILE% FDLIVE_LANG %LANG%
vecho /t %LANGFILE% FDLIVE_WRAPUP FDCONFIG.SYS FDLIVE.BAT
vecho /t %LANGFILE% FDLIVE_MORE FDIMPLES
if exist SETUP.BAT vecho /t %LANGFILE% FDLIVE_SETUP %OS_NAME% SETUP.BAT
if not exist %DOSDIR%\BIN\HELP.BAT goto NoHelp
vecho /t %LANGFILE% FDLIVE_HELP HELP
vecho

:NoHelp
vecho /t %LANGFILE% FDLIVE_WELCOME %OS_NAME% %OS_VERSION% http://www.freedos.org
vecho
set LANGFILE=

:Done
set PKG=
