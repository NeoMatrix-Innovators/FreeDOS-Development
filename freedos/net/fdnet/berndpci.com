��1���� u��PCu�u���	�!�S ������� f1�1ɬ<ar<zw, �t0<t,< t�</t�<-t�<	t�,0r<	v,<wf��f��f	�A���� t���	�!��L�!��f����1���QR�ZYr�� uF����
00��0u� �ģ��	���!��L�!BerndPCI, the simple PCI device counter
A Public Domain tool by Eric Auer 2007

Usage: BERNDPCI abcd1234

Returns the count of PCI devices which
have vendor ID abcd and device ID 1234
as errorlevel (or 255 on error)
$PCI BIOS mechanism 1 required
$PCI BIOS required
$?? match(es) found
$