@echo off

SET DOSDIR=\FREEDOS
SET BIN=%DOSDIR%\BIN
SET NLSPATH=%DOSDIR%\NLS
SET PATH=\;%BIN%
SET FDILANG=ask

if not exist %dosdir%\bin\uhdd.sys goto NoUHDD
DEVLOAD /H %dosdir%\bin\uhdd.sys /s5 /h
:NoUHDD

echo.
call CDROM.BAT
echo.

if "%CDROM%" == "" goto NoCDROM

set PACKAGES=%CDROM%
if exist %CDROM%\PACKAGES\BASE\KERNEL.ZIP set PACKAGES=%CDROM%\PACKAGES

vinfo /m
if errorlevel 103 goto NotQEMU
if errorlevel 102 goto QEMU
goto NotQEMU

:QEMU
if exist %DOSDIR%\BIN\LBACACHE.COM LBACACHE.COM 1024 buf 20 flop

:NotQEMU
rem Creating a RAM drive of 512Mib or larger, seems encounter errors on reboot
rem if "%FDRAMDRV%" == "" call FDRAMDRV 1024M 128
rem if "%FDRAMDRV%" == "" call FDRAMDRV 768M 64
rem if "%FDRAMDRV%" == "" call FDRAMDRV 512M 64
if "%FDRAMDRV%" == "" call FDRAMDRV 384M 64
if "%FDRAMDRV%" == "" call FDRAMDRV 320M 64
if "%FDRAMDRV%" == "" call FDRAMDRV 256M 32
if "%FDRAMDRV%" == "" call FDRAMDRV 224M 32
if "%FDRAMDRV%" == "" call FDRAMDRV 192M 32
if "%FDRAMDRV%" == "" call FDRAMDRV 128M 32
if "%FDRAMDRV%" == "" call FDRAMDRV 96M 16
if "%FDRAMDRV%" == "" call FDRAMDRV 64M 8
if "%FDRAMDRV%" == "" call FDRAMDRV 48M 6
if "%FDRAMDRV%" == "" call FDRAMDRV 32M 4
if "%FDRAMDRV%" == "" call FDRAMDRV 16M 2

if "%FDRAMDRV%" == "" goto NoRAMDriveYet

:Activate
mkdir %FDRAMDRV%\FREEDOS >NUL
mkdir %FDRAMDRV%\FREEDOS\BIN >NUL
mkdir %FDRAMDRV%\FREEDOS\TEMP >NUL
mkdir %FDRAMDRV%\FREEDOS\LINKS >NUL
set DOSDRV=%FDRAMDRV%

copy /Y *.* %FDRAMDRV% >NUL
copy /Y %FDRAMDRV%\COMMAND.COM %FDRAMDRV%\FREEDOS\BIN\ >NUL
copy /Y \FREEDOS\BIN\FDLIVE.BAT %FDRAMDRV%\FREEDOS\BIN\ >NUL
copy /Y \FREEDOS\BIN\SYS.COM %FDRAMDRV%\FREEDOS\BIN\ >NUL
copy /Y \FREEDOS\BIN\FDRAMDRV.BAT %FDRAMDRV%\FREEDOS\BIN\ >NUL
copy /Y \FREEDOS\BIN\*.LST %FDRAMDRV%\FREEDOS\BIN\ >NUL
copy /Y \FREEDOS\BIN\*.CFG %FDRAMDRV%\FREEDOS\BIN\ >NUL
rem xcopy /Y /S /H /Q \FREEDOS\SETUP %FDRAMDRV%\FREEDOS\SETUP\

set COMSPEC=%FDRAMDRV%\COMMAND.COM
set DOSDIR=%FDRAMDRV%\FREEDOS
set TEMP=%FDRAMDRV%\FREEDOS\TEMP
set TMP=%TEMP%

echo OS_NAME=FreeDOS>%DOSDIR%\version.fdi
echo OS_VERSION=1.3>>%DOSDIR%\version.fdi
set FDNPKG.CFG=%DOSDIR%\BIN\FDLIVE.CFG
fdinst install %PACKAGES%\util\fdnpkg.zip >NUL
set FDNPKG.CFG=
copy /Y %BIN%\FDLIVE.CFG %DOSDIR%\BIN\FDNPKG.CFG >NUL
fdinst install %PACKAGES%\util\v8power.zip >NUL
copy /Y %BIN%\FDLIVE.CFG %DOSDIR%\BIN\ >NUL
fdinst install \freedos\setup.zip >NUL
del %DOSDIR%\APPINFO\SETUP.LSM >NUL
del %DOSDIR%\PACKAGES\SETUP.LST >NUL

set BIN=
set PATH=%FDRAMDRV%\
%FDRAMDRV%
CD \
CALL %DOSDIR%\BIN\FDLIVE.BAT
goto Done

:NoCDROM
set BIN=
vecho /p /fLightRed ERROR: Unable to initialize CD-ROM drive. /fGrey
goto Done

:NoRAMDriveYet
set COMSPEC=%CDROM%\COMMAND.COM
set DOSDIR=%CDROM%\FREEDOS

if "%FDRAMDRV%" == "" call FDRAMDRV 8M 2
if "%FDRAMDRV%" == "" call FDRAMDRV 4M 1
if "%FDRAMDRV%" == "" call FDRAMDRV 3M 1
if "%FDRAMDRV%" == "" call FDRAMDRV 2M 1
if "%FDRAMDRV%" == "" call FDRAMDRV 1M 0
if "%FDRAMDRV%" == "" call FDRAMDRV LAST CHANCE

if "%FDRAMDRV%" == "" goto NoRAMDriveAtAll

vecho /p /fYellow WARNING: Limited RAM drive space. /fLightGreen Falling back to CD-ROM filesystem. /fGrey
mkdir %FDRAMDRV%\TEMP
set TEMP=%FDRAMDRV%\TEMP
set TMP=%TEMP%
goto FinishCDMode

:NoRAMDriveAtAll
vecho /p /fLightRed ERROR: Unable to initialize RAM drive. /fYellow Falling back to CD-ROM only. /fGrey
set TEMP=%CDROM%\FREEDOS\TEMP
set TMP=%TEMP%

:FinishCDMode
set DOSDRV=%CDROM%
set BIN=
set PATH=%CDROM%\
%CDROM%
CD \
CALL %DOSDIR%\BIN\FDLIVE.BAT RAMSKIP
if "%FDRAMDRV%" == "" goto WarnReadOnly
vecho /fLightGreen Temporary RAM drive present. /fGrey The LiveCD is a read-only filesystem. /fGrey /p
goto Done
:WarnReadOnly
vecho /fLightRed No RAM drive found. /fYellow The LiveCD is a read-only filesystem. /fGrey /p

:Done
set PACKAGES=
