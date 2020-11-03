#!/bin/bash
#export PATH=/home/gerard/TRAVAIL/ABC/:$PATH
#nom du fichier abc
#read -p 'Fichier abc : ' nom
FILE=`zenity --filename=$HOME/Zcloud/Travail/ABC/ABC/MonTrad/MonCahier/clarinette/ --file-selection --title="Sélectionnez un fichier"`
NOM=${FILE:0:${#FILE}-4} 

# entrez la transpo par demi-tons (pas de signe en positif, et -X pour le négatif
TONALITE=$(zenity --entry --title="Tonalité" --text="facteur t ?")
#transposition
abc2abc $NOM.abc -t $TONALITE > $NOM"_transpose".abc

#transformation en eps
abcm2ps $NOM"_transpose".abc -O $NOM"_transpose".eps

#partion png 800px
convert -density 300 -resize 800x $NOM"_transpose".eps $NOM"_transpose".png

#création du fichier midi
abc2midi $NOM"_transpose".abc -o $NOM"_transpose".mid
#transformation en mp3
timidity -Ow $NOM"_transpose".mid && lame $NOM"_transpose".wav $NOM"_transpose".mp3
rm $NOM"_transpose".wav

exit

