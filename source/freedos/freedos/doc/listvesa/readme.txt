Description

ListVESA is a utility to report which VESA video modes are supported by the system's hardware. You can use command line options to tailor information listed to one specific mode, modes supporting a specific color bit depth, modes supporting linear frame buffer, or simply general information on the video adapter itself with no detailed screen mode data.





Building from source

Building ListVESA requires Watcom C; versions 1.9 and 2.0 were both tested. For convenience, the source code is contained in a single source file. If building under DOS, you can run the ListVESA.bat script or, if building under Linux, run the ListVESA.sh script instead.





Options

/A		Shows adapter info only, no data on specific modes.

/D n	Shows only modes of the specified color depth n.

/L		Shows only modes which support a linear frame buffer.

/M n	Shows info only for the specified mode n.

Numbers for all options may be entered in decimal, hexadecimal, or octal.

Options may be combined. For example, LISTVESA /D 8 /L would list only all screen modes with 8-bit color depth and which support a linear frame buffer.





Version History

1.01
- Added column and row figures for character widths and heights.
- Added email address to application banner.

1.00
Initial release.
