#!/bin/bash
# Interface zenity pour lancer le bon script a la demande.

############ FONCTION ################
zenity(){
    /usr/bin/zenity "$@" 2>/dev/null
}

#### INTERFACE GRAPHIQUE
choix="$(zenity --width=300 --height=300 \
	--list --column "Choix" --radiolist \
	--title="Que voulez-vous faire ?" \
    --column="Action" \
    FALSE abc2abc. \
    FALSE abc2mp3. \
    FALSE abc2png. \
    FALSE abc2tin.)" 2>/dev/null

##### abc2abc
abc2abc ()

if zenity --width=250 --height=200 --question --text="Format abc vers abc.\nContinuer ?"
	then
		source ./AbcToAbc.sh | tee >(zenity --progress --pulsate)
	else
		exit 0
fi


##### abc2mp3
abc2mp3 ()
if zenity --width=250 --height=200 --question --text="Convertir en mp3.\nContinuer ?"
	then
		source ./AbcToMp3.sh | tee >(zenity --progress --pulsate)
	else
		exit 0
fi

##### abc2png
abc2mp3 ()
if zenity --width=250 --height=200 --question --text="Transformer en png.\nContinuer ?"
	then
		source ./AbcToPNG.sh | tee >(zenity --progress --pulsate)
	else
		exit 0
fi

##### abc2tin
abc2tin ()
if zenity --width=250 --height=200 --question --text="Convertir en tablature.\nContinuer ?"
	then
		source ./AbcToTin.sh | tee >(zenity --progress --pulsate)
	else
		exit 0
fi


### MAIN MENU   ####################
# ------------------------
if [ $choix = "abc2abc." ] ; then
	abc2abc
elif [ $choix = "abc2mp3." ] ; then
	abc2mp3
elif [ $choix = "abc2png." ] ; then
  abc2png
elif [ $choix = "abc2tin. " ]; then
  abc2tin
fi
