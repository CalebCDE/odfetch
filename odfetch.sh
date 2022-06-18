#!/bin/sh
# Si no puedes hacerlo útil, al menos hazlo bonito.
# 
# VERY Simple System Info build for RG350 and other Opendingux Machines
# Yes, lot of programs do this ... but i can do in less than 5 kb what other
# programs do in more than 50 kb and i really enjoy scripting. :-D
# 
#----------------------
# _-Caleb-_
#----------------------
# Telegram: @calebintnf
#----------------------

#BOF
#/---------------------------------------------------------------------------------
# Let do some colors, or.. at least 2!
Naranja='\033[0;33m' # Orange
SC='\033[0m' # Default color
Azul='\033[0;36m' # Blue
Rojo='\033[0;31m' # Red
#/---------------------------------------------------------------------------------

#/---------------------------------------------------------------------------------
# Fetch OpenDingux Version: OD, ROGUE, etc.
# This portion of code is taked of pfetch (https://github.com/dylanaraps/pfetch/)
while IFS='=' read -r key val; do
	case $key in
		(PRETTY_NAME)
		distro=$val
	;;
	esac
done < /etc/os-release
# Some distros have "" or something like this in the String, this lines can parse
# and modify that ;)
distro=${distro##[\"\']}
distro=${distro%%[\"\']}                
# END OF COPYPASTED CODE ^_^ (Thank you guys!)
#/---------------------------------------------------------------------------------


#/---------------------------------------------------------------------------------
# Declare some other variables 
# Looking for external APPS directory, it looks Apps, APPS, apps or some other
# possible combination with the f**** word "APPS".
cd "/media/sdcard/"
appsdir=$(find -iname apps)

# ...it parse and modify the "." in the result of find. I.E. "./APPS" for "/APPS"
appsdir=${appsdir##[\.\.]}                
appsdir=${appsdir%%[\.\.]}               

# More variables
user=$(whoami)
host="$(hostname)"
kernel="$(uname -sr)"
uptime="$(uptime | awk -F, '{sub(".*up ",x,$1);print $1}' | sed -e 's/^[ \t]*//')" 
# ^^ Taked from some dark site of internet (I don't remember what site really)  ^^
shell="$(basename "${SHELL}")"
#/---------------------------------------------------------------------------------

#/---------------------------------------------------------------------------------
# Memory Avaliable / Total
memoriadisp=$(free -m | awk 'FNR == 2 {print $3}')
memoriatot=$(free -m | awk 'FNR == 2 {print $2}')

# Show my memory in MB please!
calcmtot=$(($memoriatot / 1024))
calcmdis=$(($memoriadisp / 1024))
#/---------------------------------------------------------------------------------

#/---------------------------------------------------------------------------------
# Packaging: Number of OPK packages installed
# Internal packages, no problem with that
paqint=$(ls /media/data/apps/ | wc -l)
# External packages, the $appsdir variable's magic (Thanks Shell_CLI_Bash_Scripting
# Telegram group!)
paqext=$(ls "/media/sdcard"$appsdir | wc -l)
#/---------------------------------------------------------------------------------

#/---------------------------------------------------------------------------------
# Show the info, great ASCII art of Opendingux logo (Please, help me with that! XD)
# NOPE, is not the USA MAP :-(
echo ""
echo -e "          "${Naranja}"user${Azul}@${Naranja}host "${Azul}$user${Naranja}"@"${Azul}$host${SC}
echo -e " / \__    "${Naranja}"version   "${Azul}$distro${SC}
echo -e "|     \_  "${Naranja}"kernel    "${Azul}$kernel${SC}
echo -e "|       ) "${Naranja}"uptime    "${Azul}$uptime${SC}
echo -e " \     /  "${Naranja}"shell     "${Azul}$shell ${SC}
echo -e "  \___/   "${Naranja}"packages  "${Azul}$paqint "Int.SD / "$paqext "Ext.SD"${SC}
echo -e "          "${Naranja}"memory    "${Azul}$calcmdis"Mb of "$calcmtot"Mb"${SC}
echo ""
echo -e "Press"${Rojo}" [START]"${SC} "to exit" && read -p ""
#/---------------------------------------------------------------------------------
#EOF
