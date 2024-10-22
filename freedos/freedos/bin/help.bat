@ECHO OFF

if not exist %DOSDIR%\DOC\AMBHELP\FDHELP%LANG%.AMB goto NoAMBLang
if not exist %DOSDIR%\BIN\AMB.COM goto NoAMBLang
%DOSDIR%\BIN\AMB.COM %DOSDIR%\DOC\AMBHELP\FDHELP%LANG%.AMB %1 %2 %3
goto Done

:NoAMBLang
if not exist %DOSDIR%\HELP\%LANG%\HELP.HTM goto TryAMBEn
if not exist %DOSDIR%\BIN\HTMLHELP.EXE goto TryAMBEn
%DOSDIR%\BIN\HTMLHELP.EXE %1 %2 %3
goto Done

:TryAMBEn
if not exist %DOSDIR%\DOC\AMBHELP\FDHELPEN.AMB goto NoAMBEn
if not exist %DOSDIR%\BIN\AMB.COM goto NoAMBEn
%DOSDIR%\BIN\AMB.COM %DOSDIR%\DOC\AMBHELP\FDHELPEN.AMB %1 %2 %3
goto Done

:NoAMBEn
set _PREV.HELP=%LANG%
set LANG=EN
if not exist %DOSDIR%\HELP\%LANG%\HELP.HTM goto NoEnglish
if not exist %DOSDIR%\BIN\HTMLHELP.EXE goto NoEnglish
%DOSDIR%\BIN\HTMLHELP.EXE %1 %2 %3
goto RestoreLang

:NoEnglish
echo ERROR: Could not locate help files and/or help viewer

:RestoreLang
set LANG=%_PREV.HELP%
set _PREV.HELP=

:Done