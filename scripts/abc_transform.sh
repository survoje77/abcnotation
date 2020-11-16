#!/bin/bash

#entrée du fichier abc
FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`
NOM=${FILE:0:${#FILE}-4} 

choix="$(zenity --width=300 --height=300 \
	--list --column "Choix" --radiolist \
	--title="Que voulez-vous faire ?" \
    --column="Action" \
    FALSE abc2abc \
    FALSE abc2mp3 \
    FALSE abc2png \
    FALSE abc2pdf \
    FALSE abc2tin)" 2>/dev/null

if [ $choix = "abc2abc" ] ; then
    # entrez la transpo par demi-tons (pas de signe en positif, et -X pour le négatif
    TONALITE=$(zenity --entry --title="Tonalité" --text="facteur t ?");
    #transposition
    abc2abc $NOM.abc -t $TONALITE > $NOM"_transpose".abc;
elif [ $choix = "abc2mp3" ] ; then
	#création du fichier midi
	abc2midi $NOM.abc -o $NOM.mid;
	#transformation en mp3;
	timidity -Ow $NOM.mid && lame $NOM.wav $NOM.mp3;
	#suppression du wav
	rm $NOM.wav;
elif [ $choix = "abc2png" ] ; then
	#transformation en eps
	abcm2ps $NOM.abc -O $NOM.eps;
	#convertit eps à 800 de large(pour le site)
	convert $NOM.eps $NOM.png;
elif [ $choix = "abc2pdf" ]; then
	#choix du TIN
	TONALITE=$(zenity --entry --title="Tonalité" --text="T1 (D) T2 (C), T6 (G) ?")
	#transformation en eps
	#abcm2ps $NOM.abc -O $NOM.eps
	abcm2ps $NOM.abc -F flute.fmt -E -O $NOM.eps

	#l'image à 800 de large(pour le site)
	#convert -density 300 -resize 800x $NOM.eps $NOM.png
	#convert $NOM.png $NOM.pdf
	convert -density 300 -resize 800x $NOM"001".eps $NOM.png
fi   


exit

