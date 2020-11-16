#!/bin/bash

   while zenity  --width=450 height=450 --question --title="abcnotation transform" --ok-label="Ouvrir" --cancel-label="Quitter" --text="Ouvrir un fichier abc ?"
	do
		#choisir un fichier
		FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`
		NOM=${FILE:0:${#FILE}-4}

		#menu
		choix="$(zenity --width=300 --height=300 \
		--list --column "Choix" --radiolist \
		--title="Que voulez-vous faire ?" \
		--column="Action" \
		FALSE MP3+PDF \
		FALSE Transpose+MP3+PDF \
		FALSE Whistle+MP3+PDF)" 2>/dev/null

##---- Transpose + mp3 + pdf
	if [ $choix = "Transpose+MP3+PDF" ] ; then
	FICHIER=$NOM"_transpose"
	##transposition
		# entrez la transpo par demi-tons
		TRANSPO=$(zenity --entry --title="Transposition" --text="Nombre demi-tons ?")
		#transposition
		abc2abc $NOM.abc -t $TRANSPO > $FICHIER.abc
		#transformation en eps
		abcm2ps $FICHIER.abc -O $FICHIER.eps
		NOM=$FICHIER
##--- mp3 + pdf				
	elif [ $choix = "MP3+PDF" ] ; then
		FICHIER=$NOM
		abcm2ps $FICHIER.abc -O $FICHIER.eps
		# eps
## Tin+mp3+pdf						
	elif [ $choix = "Whistle+MP3+PDF" ] ; then
	FICHIER=$NOM"_tin"
	##tin
		TIN=$(zenity --entry --title="Entrer la tonalité" --text="1 pour D, 2 pour C, 6 pour G ?")
		#eps
		abcm2ps $NOM.abc -F flute.fmt -T$TIN -O $FICHIER.eps
	fi
##mp3+pdf
	#midi to mp3 via wav
		abc2midi $NOM.abc -o $FICHIER.mid
		timidity -Ow $FICHIER.mid && lame $FICHIER.wav $FICHIER.mp3
	#suppression du wav
		rm $FICHIER.wav
	##pdf crop
		ps2pdf $FICHIER.eps $FICHIER.pdf
		pdfcrop $FICHIER.pdf
	done
exit
