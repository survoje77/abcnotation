#!/bin/bash

#sélection du fichier
FILE=`zenity --file-selection= --title="Sélectionnez un fichier .abc"`
NOM=${FILE:0:${#FILE}-4} 

#transformation en eps
abcm2ps $NOM.abc -O $NOM.eps
#abcm2ps $NOM.abc -F flute.fmt -O $NOM.eps

#l'image à 800 de large(pour le site)
convert -density 300 -resize 800x $NOM.eps $NOM.png

exit

