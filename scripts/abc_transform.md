#script abc-transform
script en _bash_, réalisé sur système Linux-Debian

Permet, à partir d'un fichier _abc_, d'obtenir :

* une sortie normale du fichier d'origine (_eps_, _midi_, _mp3_, _pdf_) 
* une sortie transposée du fichier d'origine (_eps_, _abc_, _midi_, _mp3_, _pdf_)
* une sortie avec tablature _tin whistle_ (_eps_, _midi_, _mp3_, _pdf_)

> Le ficher _pdf_ est, de plus, "croppé", c'est-à-dire tronqué au minimum (utile pour un affichage écran ou pour insertion dans _Latex_ par exemple.)

Programmes utilisés :

*  _zenity_ pour les fenêtres de dialogues
*  _abcm2ps_ (fichier _eps_)
*  _abc2abc_ (transposition avec le fichier _flute.fmt_ dans le répertoire de travail)
*  _abc2midi_ (création du fichier _mid_)
*  _timidity_ + _lame_ (modification en _mp3_)
*  _ps2pdf_ (_eps_ to _pdf_)
*  _pdfcrop_ (crop du _pdf_)

 Variables du script :

* NOM (fichier _.abc_ ouvert)
* choix (menu choisi)
* FICHIER (nom de fichier temporaire)
* TRANSPO (facteur de transposition)
* TIN (tonalité du Tin Whistle)

Les fichiers résultats sont enregistrés dans le répertoire d'origine du fichier _.abc_

##Script

Le script tourne tant que _quitter_ n'a pas été demandé.

L'autre choix est l'ouverture d'un fichier _abc_.

En entrée :

* le fichier _abc_ 

Un menu au choix est alors proposé :

* MP3+PDF
* Transpose+MP3+PDF
* Whistle+MP3+PDF

### MP3+PDF
Action minimale commune au 3 choix !

En sortie : 

* un fichier _NOM.mp3_
*  un fichier _NOM.pdf_ en A4
* un fichier _NOM-crop.pdf_

###Transpose+MP3+PDF
Transpose le fichier _abc_ 

En entrée :

* facteur de transposition par demi-tons (en positif la transposition se fait en montant, en négatif en descendant)

En sortie :

* un fichier _NOM\_transpose.abc_
* un fichier _NOM\_transpose.mp3_
*  un fichier _NOM\_transpose.pdf_ en A4
*  un fichier _NOM\_transpose-crop.pdf_

###Whistle+MP3+PDF
Intègre la tablature _tin whistle_ en sortie visuelle

En entrée :

* tonalité du _Tin Whistle_ (3 tonalités proposées D, C eg G, voir le fichier _flute.fmt_ pour un autre choix)

En sortie :

*  un fichier _NOM\_transpose.pdf_ en a4 
*  un fichier _NOM\_transpose-crop.pdf_

Le fichier _abc_ reste inchangé, le fichier _mp3_ est le même qu'en 1.

##TO DO
* ouvrir le fichier avec _nano_ pour d'éventuels changements.
* filtrer l'ouverture des fichiers aux seuls _.abc_
* gestion des erreurs
* sortie du script
