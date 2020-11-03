#!/bin/bash
#export PATH=/home/gerard/TRAVAIL/ABC/:$PATH
#nom du fichier abc
#read -p 'Fichier abc : ' nom
FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`
NOM=${FILE:0:${#FILE}-4} 

# lignes pour le TIN
#TIN=${FILE:0:${#FILE}-4}
#TONALITE=$(zenity --entry --title="Tonalité" --text="T1 (D) T2 (C), T6 (G) ?")

#transformation en eps
#abcm2ps $NOM.abc -O $NOM.eps
abcm2ps $NOM.abc -F flute.fmt -E -O $NOM.eps

#l'image à 800 de large(pour le site)
#convert -density 300 -resize 800x $NOM.eps $NOM.png
#convert $NOM.png $NOM.pdf
convert -density 300 -resize 800x $NOM"001".eps $NOM.png

#création du fichier midi
#abcmidi $NOM.abc -o $NOM.mid
#transformation en mp3
#timidity -Ow $NOM.mid && lame $NOM.wav $NOM.mp3
#rm $NOM.wav

#affichage du pdf lancement du mp3
#evince $NOM.pdf && gnome-mplayer $NOM.mp3
exit

