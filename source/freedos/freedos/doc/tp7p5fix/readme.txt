
TP7/P5+ fix!

v1.04 (06-20-04)
written by Robert Riebisch (using TASM 2.01)
e-mail: rr@bttr-software.de

prior versions written by Marek Futrega / MAF
e-mail: marek.futrega@students.mimuw.edu.pl

---

This program enables you to run programs built with Turbo/Borland Pascal
7.0/7.01 on computers with processors like Intel Pentium 200, Pentium II, AMD
K6, K6-2, and faster ones.

Normally you'll get a "Runtime error 200 at..." message right after running a
program that uses the Crt unit, which has faulty code for processor speed
estimation.

This program doesn't make any changes in your executables - it's a TSR!
It's very useful when you have no possibility to rebuild a program.


This program may be freely distributed without prior permission.
We do not take any responsibility for damages caused by it.

The latest version can be always found at this URL:
http://rainbow.mimuw.edu.pl/~maf/tp7p5fix.zip

Feel free to e-mail us bug reports, comments, questions, etc.

---

TP7/P5+ fix! history:

version  what's new
...........................................................................

1.04     reduced memory usage by some optimizations (free environment, ...)
         added RTE200 demo program `tp7test'

1.03     possibility to disable/enable program

1.02     corrected tracing method
         (works fine with bigger TP7-compiled programs)

1.01     new way of tracing start of TP7-compiled program using int 21h;
         works fine inside TP7 IDE

1.00     first experimental version
         uses int 10h to trace start of TP7-compiled program
         doesn't work inside TP7 IDE
