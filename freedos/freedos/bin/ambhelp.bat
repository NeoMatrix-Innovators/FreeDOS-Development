@ECHO OFF

if not exist %DOSDIR%\BIN\AMB.COM goto MissingAMB

if not exist %DOSDIR%\DOC\AMBHELP\FDHELP%LANG%.AMB goto TryEnglish

AMB.COM %DOSDIR%\DOC\AMBHELP\FDHELP%LANG%.AMB %1 %2 %3

goto Done

:TryEnglish

if not exist %DOSDIR%\DOC\AMBHELP\FDHELPEN.AMB goto NoEnglish

AMB.COM %DOSDIR%\DOC\AMBHELP\FDHELPEN.AMB %1 %2 %3

:NoEnglish

echo ERROR: Could not locate English help files.
goto Done

:MissingAMB

echo ERROR: Could not locate AMB reader.

:Done