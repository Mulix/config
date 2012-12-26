" Plein de défauts bien pratiques (à garder en début de fichier)
set nocompatible

" Coloration syntaxique, indispensable pour ne pas se perdre dans les longs fichiers
syntax on

" Le complément du précédent, devine tout seul la couleur du fond (clair sur foncé ou le contraire)
set background&

" Si c'est pas déjà fait, affiche la position du curseur
set ruler

" Recherche en minuscule -> indépendante de la casse, une majuscule -> stricte
set smartcase

" Ne jamais respecter la casse (attention totalement indépendant du précédent mais de priorité plus faible)
set ignorecase

" Affiche le nombre de lignes sélectionnées en mode visuel ou la touche/commande qu'on vient de taper en mode commande
set showcmd

" Indiquer le nombre de modification lorsqu'il y en a plus de 0 suite à une commande
set report=0

" Laisse les lignes déborder de l'écran si besoin
set nowrap

" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
"" indentation automatique
"set autoindent
" autoindent n'est spécifique à aucun langage et fonctionne en général moins bien
set noautoindent
filetype plugin indent on
filetype indent on
" Largeur de l'autoindentation
set shiftwidth=4
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=4
" Largeur de l'indentation de la touche tab
set softtabstop=4
" Remplace les tab par des expaces
set expandtab
" Utilise shiftwidth à la place de tabstop en début de ligne (et backspace supprime d'un coup si ce sont des espaces)
set smarttab

" On peut passer rapidement du mode paste au mode nopaste avec un raccourcis,
set pastetoggle=<F5>

" Toujours laisser des lignes visibles (içi 3) au dessus/en dessous du curseur quand on
" atteint le début ou la fin de l'écran :
set scrolloff=3

" Afficher en permanence la barre d'état (en plus de la barre de commande) :
set laststatus=2

" Format de la barre d'état (tronquée au début, fichier, flags,  :
set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%

" Permettre l'utilisation de la touche backspace dans tous les cas :
set backspace=2

" Envoyer le curseur sur la ligne suivante/précédente après usage des flèches droite/gauche en bout de ligne :
set whichwrap=<,>,[,]

" Tenter de rester toujours sur la même colonne lors de changements de lignes :
set nostartofline

" Nombre de commandes maximale dans l'historique :
set history=500

" shebang automatique lors de l'ouverture nouveau
" d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
au BufNewFile *.sh,*.bash 0put =\"#!/bin/zsh\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
au BufNewFile *.py 0put=\"#!/usr/bin/env python2\"|1put=\"# -*- coding: utf-8 -*-\<nl>\<nl>\"|$

au BufNewFile,BufRead *.mako set ft=html
au BufNewFile,BufRead *.rst set tw=80 | set wrap

" Récupération de la position du curseur entre 2 ouvertures de fichiers
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif

" donner des droits d'exécution si le fichier commence par #! et contient /bin/ dans son chemin
function ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x <afile>
    endif
  endif
endfunction
au BufWritePost * call ModeChange()

" enlève trailing blanks à la fin des lignes pour les programmes
autocmd FileType python,rst,sas,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
