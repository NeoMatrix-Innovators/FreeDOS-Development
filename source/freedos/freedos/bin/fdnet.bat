@ECHO OFF

REM FreeDOS 1.3+ Basic Networking Support Package.
REM Based on Rugxulo's MetaDOS CONNECT.BAT
REM GNU General Public License, version 1 or later
REM Copyright 2016-2021 Jerome Shide.

set _FDNET.ERR=1
set _FDNET.DIR=
set _FDNET.LANG=
set _FDNET.NOTES=

pushd %DOSDIR%
cd \

if "%DOSDIR%" == "" goto NoDOSDIR

REM Set configuration environment variables.
if "%MTCPCFG%" == "" SET MTCPCFG=%dosdir%\MTCP.CFG
if "%WATTCP.CFG%" == "" SET WATTCP.CFG=%dosdir%
if "%EMAIL%" == "" SET EMAIL=anonymous@freedos.org

set _FDNET.LANG=%NLSPATH%\FDNET.%LANG%
if not exist %_FDNET.LANG% set _FDNET.LANG=%NLSPATH%\FDNET.EN
if not exist %_FDNET.LANG% set _FDNET.LANG=%DOSDIR%\BIN\FDNET.BAT
if exist %_FDNET.LANG% goto FindBINS
vecho /fLightRed Could not initialize language text for FDNET. /fGrey
goto End

:NoDOSDIR
vecho /fLightRed Environment variable DOSDIR is not set. /fGrey
goto End

:FindBINS
set _FDNET.DIR=\NETWORK\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=\NET\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\NETWORK\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\NET\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\BIN\NETWORK\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\BIN\NET\FDNET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\BIN\NETWORK
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
set _FDNET.DIR=%DOSDIR%\BIN\NET
if exist %_FDNET.DIR%\DHCP.EXE goto FoundBINS
:NoBinaries
vecho /t %_FDNET.LANG% ERROR.NOBINS
goto End

:FoundBINS
cd %_FDNET.DIR%
REM Install default configuration files.
if exist %MTCPCFG% goto HasMTCP
copy MTCP.CFG %MTCPCFG%>NUL
:HasMTCP
if exist %WATTCP.CFG%\WATTCP.CFG goto HasWATTCP
copy WATTCP.CFG %WATTCP.CFG%\WATTCP.CFG>NUL
:HasWATTCP

if /I "%1" == "TRY" goto Start
if "%1" == "" goto Start
goto %1
goto End

REM Built in English NLS Strings
INTRO=
ERROR.NOBINS=/fLightRed Could not locate network drivers. /fGrey /p
ERROR.HARDWARE=/fLightRed Physical hardware networking is not supported at this time. /fGrey /p
ERROR.DOSBOX=/fLightRed DOSBox networking is not supported at this time. /fGrey /p
FOUND.QEMU=/fLightGreen QEMU network detected. /fGrey /p
FOUND.VIRTUALBOX=/fLightGreen VirtualBOX network detected. /fGrey /p
NOTES.VIRTUALBOX=/p /fLightGreen Please note that you may need to adjust your VirtualBOX network settings. /fGrey /p
FOUND.VMWARE=/fLightGreen VMware network detected. /fGrey /p
NOTES.VMWARE=/p /fLightGreen Please note you may need to configure VMware for /fYellow Bridged /fLightGreen mode. /fGrey /p
NO.NETWORK=/fLightRed 'Network is unreachable/unavailable.' /fGray
USER.FDNETPD=/fLightGreen Using custom packet driver settings in /fWhite FDNETPD.BAT /fGrey /p
USER.DRIVER=/fLightGreen Using custom packet driver /fWhite %1 /fGrey /p
NO.HELP=Unable to locate help files.

:Start
vecho /t %_FDNET.LANG% INTRO
REM if custom Packet Driver batch exists then don't test and just use it!
if exist FDNETPD.BAT goto CustomPD

if /I "%1" == "TRY" goto TryAnyway
REM Detect Virtual Machine Platform
vinfo /m
rem if errorlevel 200 goto vmGeneric
if errorlevel 105 goto NoAutoHardware
if errorlevel 104 goto vmVMware
if errorlevel 103 goto vmVirtualBox
if errorlevel 102 goto NoAutoQEMU
if errorlevel 101 goto vmDOSBox

REM Detect Supported Hardware CPU Level
if errorlevel 6 goto hw686
if errorlevel 5 goto hw586
if errorlevel 4 goto hw486
if errorlevel 3 goto hw386
if errorlevel 2 goto hw286
if errorlevel 1 goto hw186
goto hw086

:NoAutoQEMU
if /i "%1" == "start" goto NoStartQEMU
goto vmQEMU
:NoStartQEMU
vecho /t %_FDNET.LANG% FOUND.QEMU
goto NoHardware

:NoAutoHardware
if /i "%1" == "start" goto NoStartHardware
goto vmGeneric
:NoStartHardware
vecho /t %_FDNET.LANG% FOUND.QEMU
goto NoHardware

:hw086
:hw186
:hw286
:hw386
:hw486
:hw586
:hw686
:NoHardware
vecho /t %_FDNET.LANG% ERROR.HARDWARE
goto End

:CustomPD
vecho /t %_FDNET.LANG% USER.FDNETPD
call FDNETPD.BAT
if errorlevel 1 goto Failed
goto DHCP

:vmDOSBox
vecho /t %_FDNET.LANG% ERROR.DOSBOX
goto End

:vmQEMU
vecho /t %_FDNET.LANG% FOUND.QEMU
goto vmGeneric

:vmVirtualBox
vecho /t %_FDNET.LANG% FOUND.VIRTUALBOX
SET _FDNET.NOTES=VIRTUALBOX
goto vmGeneric

:vmVMware
vecho /t %_FDNET.LANG% FOUND.VMWARE
SET _FDNET.NOTES=VMWARE
goto vmGeneric

:TryAnyway
:vmGeneric
REM ---------------------------------------------------------------------------
REM Cut and Paste from CONNECT.BAT
REM ---------------------------------------------------------------------------

berndpci 10222000
if errorlevel 1 goto pcntpk
berndpci 10ec8139
if errorlevel 1 goto rtspkt

goto qemu13

REM ... tested under Windows 7 64-bit Home Premium (no VT-X) ...
REM ... tested successfully with VirtualBox 4.3.6 ...
REM ... (also) qemu -net nic,model=pcnet -net user ...
:amdpd
:pcnet
:pcntpk
pcntpk.com int=0x60
goto finish

REM ... tested natively on Pentium 4 (Dell Dimension) ...
REM ... (sigh) no sources found, so not included here ...
:realtek
:rtl8139
:rtspkt
rtspkt.com 0x60
goto finish

REM ... tested successfully with QEMU 0.9.0 ...
REM qemu -L . -fda /rugxulo/tmp/metados.img -boot a \
REM   -net nic,model=ne2k_isa -net user
REM
:qemu090
:qemu09
:qemu90
:qemu9
ne2000.com -u
ne2000.com 0x60
goto finish

REM ... tested successfully with QEMU 0.13.0 ...
REM qemu -L bios -fda /rugxulo/tmp/metados.img -boot a \
REM   -netdev user,id=usernet -device ne2k_isa,irq=5,netdev=usernet
REM
:qemu0130
:qemu013
:qemu130
:qemu13
ne2000.com -u
ne2000.com 0x60 0x5 0x300
goto finish

:finish
REM ---------------------------------------------------------------------------
REM End of Cut and Paste
REM ---------------------------------------------------------------------------

:DHCP
if errorlevel 1 goto Failed
DHCP.EXE
if errorlevel 1 goto Failed
set _FDNET.ERR=0

if "%_FDNET.NOTES%" == "" goto End
vecho /t %_FDNET.LANG% NOTES.%_FDNET.NOTES%
goto End

:Failed
set _FDNET.ERR=1
vecho /t %_FDNET.LANG% NO.NETWORK

:End
popd
verrlvl %_FDNET.ERR%
set _FDNET.ERR=
set _FDNET.DIR=
set _FDNET.LANG=
set _FDNET.NOTES=
