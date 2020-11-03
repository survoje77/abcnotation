#!/bin/bash

#sélection fichier
FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`
NOM=${FILE:0:${#FILE}-4} 

#transformation en eps
abcm2ps $NOM.abc -O $NOM.eps

#l'image à 800 de large(pour le site)
convert -density 300 -resize 800x $NOM.eps $NOM.png

#création du fichier midi
abc2midi $NOM.abc -o $NOM.mid

#transformation en mp3
timidity -Ow $NOM.mid && lame $NOM.wav $NOM.mp3
#suppression du wav
rm $NOM.wav

#affichage du pdf lancement du mp3
#evince $NOM.pdf && gnome-mplayer $NOM.mp3
exit

