�� U���>�>�t:�@ ��>�f .�&���t�t���t�Ö�t��M���M�� t���i��.��<u����.��.��� �Ȏ���� 1�.�G@= r�8 =? v�.�����	���.�� � ����t.$��F�t�.��<u��.�'C���r��S d4	2  ���������N ��ø� ��ø ��ÁÀ �� @r��?����.��<u��.�=G���r��  .��<u��.���(����(�.�G���r��>����( �� �t>�����P �� �b>��Z���>��>���P �_<tD���?>��]����( �� >��<t'ɻ� <t�_<t���>��`���� �@� �@�� t�����>��>��>��>����
>�����0>�&l� ��00>�j�
>�����0>�&{� ��00>�y.����t�1� .��u��� .��t�{ 1�1��� u� �O�� .��t.��P��������% ���.��(X��% �.����% = u�, A.;�r�1�� B.;�r��� .����t�g� �R����
���.�F�t�����0123456789ABCDEF%!PS-Adobe-2.0
%%Title: FreeDOS graphics screen shot
%%Creator: FreeDOS graphics
%%EndComments

/bufstr 500 string def

/xres 000 def
/yres 000 def

gsave
 24 54 translate
 90 rotate
713 535 scale
xres yres 8
[xres 0 0 0 yres sub 0 0]
{currentfile bufstr readhexstring pop} bind
image
 
grestore

showpage

 %-12345X@PJL JOB
@PJL ENTER LANGUAGE = POSTSCRIPT
 %%EOF%-12345X@PJL EOJ
%-12345X
 �.��t.�&��P��� X�p.���s ��>�>��� u]$>��>�� �<u�{�<t�<u�a�>�� �<u��<t�<u�i�<t�<t�<t�<u��>�� �
>�� �8 ��4 .�.�.��>��>�~>��>��>��>�6�>�>�>�.��>��>�~>��>��>��>�6�>�>�>�.�>���                  PS� ��[X�.��u-PSR.��� �.�&���)t.����$0<0u.��Z[X�S��%��������������É����������t��  1��.�>�u� Q��&������y��Y[�S��%��������������É��������t��  Q��̀�(� ���&���% Y�' � � S� �׉������˴ &��
 S�>�>��� �ô .���[Ð�>>      w    @( �  �     << U��.�, �I�!��� �<?tU</t�<-t�<	t�< t�rO<ar, �<Iu�&��״<Eu�&���<Bu&���<Cu&��<1r<3w	,1� ��릺��	�!�L�!�5�!>��>���%���!�X�	�!���������� 1�!Driver to make 'shift PrtScr' key work
even in CGA, EGA, VGA, MCGA graphics
modes loaded, in PostScript mode.
$Usage: GRAPHICS [/B] [/I] [/C] [/E] [/n]
 /B recognize non-black CGA color 0
 /I inverse printing (for dark images)
 /C compatibility mode (HP Laserjet)
 /E economy mode (only 50% density)
 /n Use LPTn (value: 1..3, default 1)
 /? show this help text, do not load

After loading the driver you can print
screenshots using 'shift PrintScreen'
even in graphics modes. This GRAPHICS
is for PostScript grayscale printers.
This is free software (GPL2 license).
Copyleft by Eric Auer 2003, 2008.
$