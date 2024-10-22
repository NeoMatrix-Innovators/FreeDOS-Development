#!/bin/bash
# build_freedos.sh


reset;

echo -e "Console > FreeDOS Build-Script started!"



function get_vars() {
	echo -e "Console > Just enter the variables needed for build, asked below!"
	read -p "FREEDOS-PATH > " fdos_path
	read -p "OUTPUT-IMAGE > " out
	read -p "ISOLINUX-BIN PATH > " isolinux
	read -p "BOOT.CAT PATH > " bootcat
}


function mkisofs_build1() {
	echo -e "Console > Trying to build with native settings!"
	get_vars;
	sudo mkisofs -o $out.iso -b ./$isolinux -c ./$bootcat -no-emul-boot -boot-load-size 4 -boot-info-table $fdos_path

}

function mkisofs_build2() {
	echo -e "Console > Trying to build with native settings!"
	get_vars;
	sudo mkisofs -o $out.iso -b ./$isolinux/isolinux.bin -c ./$bootcat/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table $fdos_path

}



function build3() {
	echo "Console > Build3"
}
function build4() {
	echo "Console > Build4"
}


while true;
do

echo "========================================================"
echo "== FREEDOS BUILD SYSTEM | (c) hexzhen3x7 		    =="
echo "========================================================"
echo "== 1: Native Build          | 2: Normal Build         =="
echo "== 3: GrubRsc-Build(Native) | 4: GrubRsc-Build Normal =="
echo "========================================================"
echo "== Enter q|Q to quit! or STRG+C !                     =="
echo "========================================================"

read -p "Console > " x
case $x in
		1) mkisofs_build1; continue;;
		2) mkisofs_build2; continue;;
		3) build3; continue;;
		4) build4; continue;;
		q|Q) echo -e "Console > Exiting!"; exit;;
		*) echo -e "Console > Invalid Input!"; continue;
esac
done

