;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq display-line-numbers-type t)

(setq doom-theme 'doom-one)

(setq org-directory "~/Dropbox/org/")

(setq reftex-default-bibliography "~/Dropbox/crews-econbib/crews_econbib.bib")

(setq +latex-viewers '(zathura))
