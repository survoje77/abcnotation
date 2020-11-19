#!/bin/bash


while zenity --question --title="Question." --ok-label="Oui" --cancel-label="Non" --text="Ouvrir fichier .abc ?";

do
#ouverture et affichage fichier abc
	if FILE=`zenity --file-selection= --title="Sélectionnez un fichier"`; then
		NOM=${FILE:0:${#FILE}-4};
		abcm2ps $NOM.abc -O $NOM.eps
		evince $NOM.eps &

		while choix="$(zenity --width=300 --height=300 \
		--list --column "Choix" --radiolist \
		--title="Que voulez-vous faire ?" \
		--column="Action" \
		FALSE PDF \
		FALSE MP3 \
		FALSE Transpose+PDF+MP3 \
		FALSE Whistle+PDF+MP3)" 2>/dev/null;
		do
		##PDF
		if [ $choix = "PDF" ] ; then
		#eps
			abcm2ps $NOM.abc -O $NOM.eps
		#affichage
			ps2pdf $NOM.eps $NOM.pdf
				evince $NOM.pdf &
		#---------------------------------------	
		##MP3
		elif [ $choix = "MP3" ] ; then			
		#midi
			abc2midi $NOM.abc -o $NOM.mid
		#midi to mp3;
			timidity -Ow $NOM.mid && lame $NOM.wav $NOM.mp3
		#suppression du wav
			rm $NOM.wav	
		#-------------------------------------------		
		##Transpose + PDF + MP3
		elif [ $choix = "Transpose+PDF+MP3" ] ; then
		##transposition
		# entrez la transpo par demi-tons
			TONALITE=$(zenity --entry --title="Tonalité" --text="facteur t ?")
		#transposition
			abc2abc $NOM.abc -t $TONALITE > $NOM"_transpose".abc
		#transformation en eps
			abcm2ps $NOM"_transpose".abc -O $NOM"_transpose".eps
		#PDF
			ps2pdf $NOM"_transpose".eps $NOM"_transpose".pdf
			evince $NOM"_transpose".pdf	&		
		#mp3			
			#midi
			abc2midi $NOM"_transpose".abc -o $NOM"_transpose".mid
			#midi to mp3;
			timidity -Ow $NOM"_transpose".mid && lame $NOM"_transpose".wav $NOM"_transpose".mp3
			#suppression du wav
			rm $NOM"_transpose".wav		
		#----------------------------------------
		##TIN + MP3				
		elif [ $choix = "Whistle+PDF+MP3" ] ; then
		#Choix du TIN
			TIN=$(zenity --entry --title="Entrer la tonalité" --text="1 pour D, 2 pour C, 6 pour G ?")
		#eps
			abcm2ps $NOM.abc -F flute.fmt -T$TIN -O $NOM"_tin".eps
		#affichage
			ps2pdf $NOM"_tin".eps $NOM"_tin".pdf
			evince $NOM"_tin".pdf &
		#mp3			
			#midi
			abc2midi $NOM"_tin".abc -o $NOM"_tin".mid
		#midi to mp3;
			timidity -Ow $NOM"_tin".mid && lame $NOM"_tin".wav $NOM"_tin".mp3
		#suppression du wav
			rm $NOM"_tin".wav				
		fi
		done
		#sortie du while choix
	fi
done
#sortie du while ouvrir fichier
exit
