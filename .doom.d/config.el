;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(setq doom-font (font-spec :family "Cascadia Mono PL" :size 13 :weight 'Regular)
      doom-big-font (font-spec :family "Cascadia Mono PL" :size 19 :weight 'SemiBold))

(setq display-line-numbers-type t)

(setq doom-theme 'doom-zenburn)
(after! org
  (set-face-foreground 'org-hide (doom-color 'bg))
  (set-face-foreground 'org-document-info-keyword (doom-lighten 'fg-1 0.2))
  (set-face-foreground 'org-done (doom-lighten 'fg-1 0.05))
  (set-face-foreground 'org-ellipsis (doom-lighten 'fg-1 0.2)))
;;(setq doom-theme 'doom-palenight)

(setq org (concat (getenv "HOME") "/Dropbox/org/")
      jab_bib (concat (getenv "HOME") "/Dropbox/crews-econbib/crews_econbib.bib")
      org-directory org
      deft-directory (concat org "roam/")
      org-roam-directory (concat org "roam/")
      org-roam-dailies-directory (concat org "roam/journal/"))

(after! org
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

(after! org
  (setq org-ellipsis " ▼" ;; …, ↴, ⬎
        org-hide-leading-stars t
        org-startup-indented t
        org-startup-folded t
        org-fontify-done-headline nil
        auto-save-default nil
        make-backup-files nil
        org-log-done t
        org-log-into-drawer t
        org-clock-into-drawer t
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "ONGO(o!)" "WAIT(w@/!)" "|" "DONE(d)" "KILL(k)")
            (sequence "INSPECT(i)" "UNDERSTAND(u!)" "EVAL(e!)" "|" "READ(r)" "KILL(k)"))))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-restore-windows-after-quit t
        org-agenda-start-with-log-mode t ;; show clocked and closed tasks in agenda
        org-agenda-span 'week
        org-agenda-start-on-weekday 1 ;; 0 for Sunday, 1 for Monday
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-breadcrumbs-separator " ❱ "
        org-agenda-block-separator nil
        org-agenda-compact-blocks t)
  (setq org-agenda-custom-commands
        '(("c" "Super view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-start-day nil)
                        (org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "Lagging"
                            :scheduled past
                            :deadline past)
                           (:name "Today"
                            :time-grid t
                            :log t ;; clocked and closed
                            :date today ;; meetings
                            :scheduled today ;; DOs vs DUEs (deadlines)
                            :deadline today)
                           (:name "Upcoming"
                            :scheduled future
                            :deadline future)))))
            (todo "NEXT|ONGO" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Habits"
                             :habit t)
                            (:name "Research pipeline"
                             :file-path "[^a-z0-9]p-[a-z0-9]*\\.org")
                            (:name "Teaching + Service"
                             :file-path ("econ27000-intl\\.org" "bus33503-mfge\\.org" "service-econ\\.org"))
                            (:name "SysAdmin"
                             :file-path ("foreman\\.org" "system.*\\.org"))
                            (:name "Home"
                             :file-path "home\\.org")))))))))
  :config
  (org-super-agenda-mode))

(use-package! org-roam
  :after deft org
  :bind (("C-c n t" . org-roam-today)
         :map org-mode-map
         (("C-c n b" . org-roam) ;; call this to show backlinks in side-buffer
          ("C-c n u" . org-roam-update-buffer)
          ("C-c n l" . org-roam-get-linked-files)
          ("C-c n i" . org-roam-insert)
          ("C-c n r" . org-roam-random-note)))
  :custom
  (org-roam-tag-sources '(prop last-directory))
  (org-roam-dailies-capture-templates
      '(("d" "default" entry
         #'org-roam-capture--get-point
         "* %?"
         :file-name "journal/%<%Y-%m-%d>"
         :head "#+title: %<%d-%B-%Y>\n\n"))))

(use-package! deft
  :after org
  :bind
  ("C-c n d" . deft))
