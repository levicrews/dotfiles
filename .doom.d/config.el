;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq display-line-numbers-type t)

(setq doom-theme 'doom-zenburn)
;;(setq doom-theme 'doom-palenight)

(after! org
  (setq org-directory "~/Dropbox/org/"
        org-roam-directory "~/Dropbox/org/roam"
        org-hide-leading-stars t
        org-fontify-done-headline nil
        auto-save-default nil
        make-backup-files nil
        org-log-done t
        org-log-into-drawer t
        org-clock-into-drawer t
        org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d)" "KILL(k)")
            (sequence "INSPECT(i)" "UNDERSTAND(u!)" "EVAL(e!)" "|" "READ(r)" "KILL(k)"))))
