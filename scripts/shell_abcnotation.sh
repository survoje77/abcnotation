#!/bin/bash

# le script a été réalisé sous GNU/Linux Debian
# le script doit être placé dans le répertoire de travail où se trouve fichier.abc
# le script produit par défaut fichier.eps (test fichier.abc sans erreur)
# le script produit à la demande fichier.mid, fichier.mp3, fichier.png, fichier.log fichier.latex

#variables utilisées
# FICHIER_ABC : nom du fichier abc

jour=$(date +%d"-"%m"-"%Y)
heure=$(date +%H"h"%M)
editeur=nano
FICHIER_ABC=""

##
# Variables couleurs
##
green='\e[32m' # color green
blue='\e[34m'  # color blue
clear='\e[0m'  # back 2 color system
red='\e[0;31m'  # color red

# Color Functions
ColorGreen(){
	echo -ne $green $1 $clear
}
ColorBlue(){
	echo -ne $blue $1 $clear
}
ColorRed(){
	echo -ne $red $1 $clear
}

#function test abcm2ps pour contrôler la validité du fichier.abc
function test_abcm2ps()
{
abcm2ps -q $FICHIER_ABC.abc -O $FICHIER_ABC.eps
if [ "$?" -eq 0 ]; then
	echo "* Fichier $FICHIER_ABC.eps" #>> $FICHIER_ABC.log
  	else
		echo "* Erreur dans le fichier $FICHIER_ABC.abc"
		echo $(ColorRed  "Erreur dans le fichier ")
		echo "Merci d'y remédier !"
		sleep 5
fi
}

#-----entrée du fichier à traiter, test de présence, compile en eps
function ouvrir_abc()
{
read -p 'Fichier abc (sans extension) : ' FICHIER_ABC
if [ -e $FICHIER_ABC".abc" ]
	then
		echo "Traitement du fichier $FICHIER_ABC.abc"
		echo "# Traitement de $FICHIER_ABC.abc    " > $FICHIER_ABC.log
		echo " le $jour à $heure     " >> $FICHIER_ABC.log
		echo "   " >> $FICHIER_ABC.log
		test_abcm2ps
	else echo $(ColorRed "Le fichier n'existe pas")
	sleep 5
fi
}

#======fonctions de traitements
#---- créer un fichier abc avec pré-saisie
function creer_abc()
{
read -p 'nom du fichier abc (sans extension, sans espace) : ' FICHIER_ABC
touch $FICHIER_ABC.abc
echo "X:1" >> $FICHIER_ABC.abc
echo "T:Titre" >> $FICHIER_ABC.abc
echo "O:Country" >> $FICHIER_ABC.abc
echo "M:3/4" >> $FICHIER_ABC.abc
echo "L:1/8" >> $FICHIER_ABC.abc
echo "Q:1/4=80" >> $FICHIER_ABC.abc
echo "K:C" >> $FICHIER_ABC.abc
echo "C2E2G2|GF ED C2 |] " >> $FICHIER_ABC.abc
echo "w: a dap ter à vot' goût mer ci" >> $FICHIER_ABC.abc
test_abcm2ps
echo " Création $FICHIER_ABC.abc" > $FICHIER_ABC.log
echo " le $jour à $heure     " >> $FICHIER_ABC.log
echo "   " >> $FICHIER_ABC.log
echo $(ColorGreen "Création du fichier $FICHIER_ABC.abc ok")
sleep 3
}

#-----ouvrir le fichier abc (éditeur nano)
function editer_abc()
{
if [ -z "$FICHIER_ABC" ]
	then
		echo $(ColorRed "Vous n'avez pas ouvert de fichier abc")
			sleep 5
	else 
		$editeur $FICHIER_ABC.abc
		test_abcm2ps
fi
}

#----ouvrir le fichier log (éditeur nano)
function editer_log()
{
if [  -z "$FICHIER_ABC" ]
	then
		echo $(ColorRed "Vous n'avez pas ouvert de fichier abc")
			sleep 5
	else 
		$editeur $FICHIER_ABC.log
fi
}

#------tranposition
function abc_to_transpose()
{
read -p 'Entrez avec + ou - les demi-tons de transposition : ' TONALITE
abc2abc $FICHIER_ABC.abc -t $TONALITE > $FICHIER_ABC"_transpose".abc
echo " Transposition $FICHIER_ABC.abc" >> $FICHIER_ABC.log
echo $(ColorGreen "Fichier $FICHIER_ABC"_transpose".abc OK")
sleep 3
}

#-----produire un png (le png est "croppé" cf -trim)
# nécessite convert (imagemagick)
function abc_to_png()
{
convert $FICHIER_ABC.eps -colorspace RGB -trim $FICHIER_ABC.png 
echo $(ColorGreen "Fichier $FICHIER_ABC.png")
echo " Fichier $FICHIER_ABC.png OK" >> $FICHIER_ABC.log
sleep 3
}

#-----produire un extrait latex (à inclure dans le source .tex avec \usepackage{abc} en préambule)
function abc_to_latex()
{
if [  -z "$FICHIER_ABC" ]
	then
		echo $(ColorRed "Vous n'avez pas ouvert de fichier abc")
			sleep 5
	else 
		echo "\index{$FICHIER_ABC }" > $FICHIER_ABC.latex
		echo "\begin{abc}[name=$FICHIER_ABC]" >> $FICHIER_ABC.latex
		cat $FICHIER_ABC.abc >> $FICHIER_ABC.latex
		echo "\end{abc}" >> $FICHIER_ABC.latex
		echo " Fichier $FICHIER_ABC.latex" >> $FICHIER_ABC.log
		echo $(ColorGreen "Fichier $FICHIER_ABC.latex OK")
		sleep 5
fi
}

#-----produire un mp3, via un midi et un wav, le wav est effacé à la fin
# necessite timidity et lame
function abc_to_mp3()
{
	#création du fichier midi
abc2midi $FICHIER_ABC.abc -o $FICHIER_ABC.mid #>> $FICHIER_ABC.log
	#transformation en mp3;
timidity -Ow $FICHIER_ABC.mid #>> $FICHIER_ABC.log
lame --quiet $FICHIER_ABC.wav $FICHIER_ABC.mp3 #>> $FICHIER_ABC.log
	#suppression du wav
rm $FICHIER_ABC.wav
echo " Fichiers $FICHIER_ABC.mid et $FICHIER_ABC.mp3" >> $FICHIER_ABC.log
echo $(ColorGreen "Fichiers $FICHIER_ABC.mid et $FICHIER_ABC.mp3 OK")
sleep 3
}

#---tablature tin-whistle (tonalité du Tin en entrée)
function abc_to_tin_whistle()
{
read -p 'Tonalité du tin whistle (1 pour D, 2 pour C, 6 pour G) : ' TIN
abcm2ps $FICHIER_ABC.abc -F flute.fmt -T$TIN -O $FICHIER_ABC"_tin".eps
}

#list les fichier *.abc du répertoire
function list_abc()
{
ls *.abc
}

#liste les fichiers *.abc contenant un motif
function list_motif() 
{
read -p 'Motif recherché : ' MOTIF
grep $MOTIF *.abc | cut -d: -f1 | more
}

#------fin du programme
function termine()
{
echo "Terminé à $heure" >> $FICHIER_ABC.log
echo "À bientôt avec la notation abc !"
sleep 5
}


function incorrect_selection() {
  echo $(ColorRed 'Incorrect_selection! Try again.')
}

function press_enter() {
  echo ""
  echo -n " Press Enter to continue "
  read
  clear
}

menu(){
echo -ne " Menu
	$(ColorGreen '1)') créer un fichier
	$(ColorGreen '2)') ouvrir un fichier
	$(ColorGreen '3)') lister les abc du répertoire
	$(ColorGreen '4)') lister les abc selon un motif de recherche
        $(ColorGreen '----------------')
        $(ColorGreen '5)') $(ColorGreen $FICHIER_ABC.abc) to midi-mp3
        $(ColorGreen '6)') $(ColorGreen $FICHIER_ABC.abc) to png
        $(ColorGreen '7)') transposition de $(ColorGreen $FICHIER_ABC.abc)
        $(ColorGreen '8)') tablature tin whistle de $(ColorGreen $FICHIER_ABC.abc)
        $(ColorGreen '----------------')
        $(ColorGreen '9)') éditer $(ColorGreen $FICHIER_ABC.abc)
        $(ColorGreen '10)') éditer $(ColorGreen $FICHIER_ABC.log)
        $(ColorGreen '11)') export LaTeX de $(ColorGreen $FICHIER_ABC.abc)
        $(ColorGreen '0)') Exit
        $(ColorBlue 'Sélectionner une option : ') "

        read a
        case $a in
		1) creer_abc ; clear ; menu ;;
		2) ouvrir_abc ; clear ; menu ;;
		3) list_abc ; menu ;;
		4) list_motif ; menu ;;
	    	5) abc_to_mp3 ;  clear; menu ;;
	    	6) abc_to_png ;  clear; menu ;;
	    	7) abc_to_transpose ; clear; menu ;;
	    	8) abc_to_tin_whistle ;  clear; second_menu ;;
	    	9) editer_abc ;  clear; menu ;;
	    	10) editer_log ;  clear; menu ;;
	   	11) abc_to_latex ; clear; menu ;;
		0) exit 0 ;;
          	* )  incorrect_selection ; press_enter ;;
        esac
}

#PROGRAMME PROPREMENT DIT
clear
until [ "$a" = "0" ]; do
    menu
done
termine
