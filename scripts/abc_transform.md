# script _abc-transform_
script en _bash_, réalisé sur système Linux-Debian


À partir d'un fichier _abc_ :

* affiche la sortie _eps_ 
* permet la création d'un _pdf_
* permet la création d'un _mp3_
* permet la transpostion en fichier _abc_, avec _pdf_ et _mp3_ 
* permet une sortie tablature _tin whistle_ avec _pdf_ et _mp3_


Programmes utilisés :

*  _zenity_ pour les fenêtres de dialogues
*  _abcm2ps_ (fichier _eps_)
*  _abc2abc_ (transposition avec le fichier _flute.fmt_ dans le répertoire de travail)
*  _abc2midi_ (création du fichier _mid_)
*  _timidity_ + _lame_ (modification en _mp3_)
*  _ps2pdf_ (_eps_ to _pdf_)
*  _evince_ pour l'affichage

 Variables du script :

* NOM (fichier _.abc_ ouvert)
* choix (menu choisi)
* TONALITE (facteur de transposition)
* TIN (choix du Tin Whistle)

Les fichiers résultats sont enregistrés dans le répertoire d'origine du fichier _.abc_

## Script

1. fichier à ouvrir

2. Menu au choix :
```
    PDF
    MP3
    Transpose+PDF+MP3
    Whistle+PDF+MP3
```
Le script tourne avec le fichier _abc_ ouvert en 1. tant qu'on reste dans le menu. _Annuler_ renvoie à l'ouverture d'un (autre) fichier. _Annuler_ à ce niveau fait quitter le script.


### PDF
En sortie :

* création du _pdf_
* affichage du _pdf_

### MP3
En sortie :

* création du fichier _midi_ 
* Création du fichier _mp3_. 
* Pas d'ouverture de fichier (à faire)

> processus via un fichier _wav_ qui est supprimé à la fin

### Transpose+PDF+MP3

En entrée :

* facteur de transposition par demi-tons (en positif la transposition se fait en montant, en négatif en descendant)

En sortie :

* création d'un nouveau fichier (_NOM\_transpose.abc_)
* création du_mp3_ correspondant (_NOM\_transpose.mp3_)
* création et affichage du fichier _NOM\_transpose.pdf_

Note : 

Si l'on souhaite utiliser le script pour ce nouveau fichier, il convient de l'ouvrir.

### Whistle+MP3+PDF
Intègre la tablature _tin whistle_ en sortie visuelle

En entrée :

* tonalité du _Tin Whistle_ (3 tonalités proposées D, C et G, voir le fichier _flute.fmt_ pour un autre choix)

En sortie :

* création et affichage du fichier _NOM\_tin.pdf_  
* le fichier _abc_ reste inchangé, le fichier _mp3_ est le même qu'en 1.



## TO DO
* ouvrir le fichier avec un éditeur de texte pour d'éventuels changements.
* filtrer l'ouverture des fichiers aux seuls _.abc_
* gestion des erreurs
* _pdfcrop_ pour des _pdf_ tronqués à la seule partition
