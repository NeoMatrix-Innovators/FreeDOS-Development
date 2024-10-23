Description

ListPCI is a PCI device listing utility which scans the PCI bus of the system on which its running and displays data on all PCI devices it finds. It provides more verbose data than other comparable applications and is more flexible in its command line options. Using these, you may filter the devices reported to only those of a specified vendor ID or of a specified class. ListPCI can also return the number of matching devices in the DOS system variable ERRORLEVEL, making it easy to integrate into batch scripts.





Building from source

Building ListPCI requires Watcom C; versions 1.9 and 2.0 were both tested. For convenience, the source code is contained in a single source file. If building under DOS, you can run the ListPCI.bat script or, if building under Linux, run the ListPCI.sh script instead.





Options

/C n    Shows only devices of the specified class n.

/N      Returns the number of matching devices in the ERRORLEVEL variable.

/V n    Shows only devices by the specified vendor n.

Numbers for all options may be entered in decimal, hexadecimal, or octal.

Options may be combined. For example, LISTPCI /C 2 /V 0x8086 would list only network controllers made by Intel.





Version History

1.02
- Added email address to application banner.

1.01
- Added ListPCI.bat and ListPCI.sh to package.
- Added this readme to package.
- Minor tweak to the way things are printed to the screen.
- Optimized handling of strings in DeviceDescriptionStringPrint().

1.00
Initial release.
