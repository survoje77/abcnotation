#!/bin/bash

#sélection du fichier .abc
FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`
NOM=${FILE:0:${#FILE}-4} 

#transformation en eps
abcm2ps $NOM.abc -F flute.fmt -E -O $NOM.eps

#l'image à 800 de large(pour le site)
convert -density 300 -resize 800x $NOM"001".eps $NOM.png

exit

