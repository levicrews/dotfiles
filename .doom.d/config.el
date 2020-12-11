;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(setq doom-font (font-spec :family "Cascadia Mono PL" :size 13 :weight 'Regular)
      doom-big-font (font-spec :family "Cascadia Mono PL" :size 19 :weight 'SemiBold))

(setq display-line-numbers-type t)

(setq doom-theme 'doom-zenburn)
;;(setq doom-theme 'doom-palenight)

(after! org
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

(after! org
  (setq org-directory "~/Dropbox/org/"
        org-roam-directory "~/Dropbox/org/roam"
        org-hide-leading-stars t
        org-fontify-done-headline nil
        auto-save-default nil
        make-backup-files nil
        org-log-done t
        org-log-into-drawer nil
        org-clock-into-drawer t
        org-agenda-window-setup 'current-window
        org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d)" "KILL(k)")
            (sequence "INSPECT(i)" "UNDERSTAND(u!)" "EVAL(e!)" "|" "READ(r)" "KILL(k)"))))
