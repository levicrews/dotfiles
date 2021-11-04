;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(remove-hook 'org-mode-hook #'+literate-enable-recompile-h)

(setq auto-save-visited-mode t
      auto-revert-mode t)

(setq doom-font (font-spec :family "Cascadia Mono PL" :size 13 :weight 'regular)
      doom-big-font (font-spec :family "Cascadia Mono PL" :size 20 :weight 'bold))

(setq display-line-numbers-type t)

(setq global-visual-line-mode t)

(global-set-key
    (kbd "C-z")
    (defhydra hydra-global-menu (:color red :hint nil)
   "
^Display^        ^Buffers^                    ^Actions^
^^^^^^^^^-----------------------------------------------------
_g_: zoom in     _d_: close all buffers       _u_: update all packages
_s_: zoom out    _o_: open buffer on desktop  _l_: display line numbers

_q_: quit this menu                         _r_: restart emacs
"
   ("g" text-scale-increase)
   ("s" text-scale-decrease)
   ("d" kill-all-buffers)
   ("l" global-display-line-numbers-mode)
   ("r" stop-and-restart-emacs)
   ("u" eds-straight-pull-or-prune)
   ("o" eds/open-buffer-on-desktop)
   ("q" nil)))

(setq auto-save-default nil
      make-backup-files nil)
(delete-selection-mode 1)                       ; Replace selection when inserting text
(global-subword-mode 1)                         ; Iterate through CamelCase words

(load-theme 'doom-zenburn t)
(custom-theme-set-faces! 'doom-zenburn
  `(org-document-info-keyword :foreground ,(doom-lighten 'fg-1 0.2))
  `(org-done :foreground ,(doom-lighten 'fg-1 0.05))
  `(org-ellipsis :foreground ,(doom-lighten 'fg-1 0.2)))

(global-set-key (kbd "C-c d") 'define-word-at-point)
(global-set-key (kbd "C-c D") 'define-word)

(setq org-dir (concat (getenv "HOME") "/Dropbox/org/")
      crewsbib-dir (concat (getenv "HOME") "/Dropbox/crewsbib/")
      crewsbib (concat crewsbib-dir "crewsbib.bib")
      org-directory org-dir
      deft-directory (concat org-dir "roam/")
      org-roam-directory (concat org-dir "roam/")
      org-roam-dailies-directory (concat org-dir "roam/journal/")
      reftex-default-bibliography (list crewsbib))

(after! org
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

(after! org
  (setq org-ellipsis " ▼" ;; …, ↴, ⬎
        org-hide-leading-stars t
        org-startup-indented t
        org-startup-folded t
        org-hide-emphasis-markers t
        org-fontify-done-headline nil))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

(add-hook 'org-mode-hook (lambda ()
  "Beautify Org Checkbox Symbol"
  (push '("[ ]" . "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode)))

;; This reformats the display of org-ref citations
;; but it makes the buffers too slow
;; (with-eval-after-load 'org
  ;; (add-hook 'org-mode-hook 'org-ref-prettify-mode))

(after! org
  (setq org-log-done t
        org-log-into-drawer t
        org-clock-into-drawer t))

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local time-stamp-active t
                        time-stamp-start "#\\+last_modified:[ \t]*"
                        time-stamp-end "$"
                        time-stamp-format "\[%Y-%02m-%02d %3a %02H:%02M\]")
            (add-hook 'before-save-hook 'time-stamp nil 'local)))

(after! org
  (setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "ONGO(o!)" "WAIT(w@/!)" "|" "DONE(d)" "KILL(k)")
    (sequence "INSPECT(i)" "UNDERSTAND(u!)" "EVAL(e!)" "|" "READ(r)" "KILL(k!)"))))

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
                             :file-path ("[^a-z0-9]p-[a-z0-9]*\\.org" "roam/projects/"))
                            (:name "Teaching + Service"
                             :file-path ("service-econ\\.org"))
                            (:name "Referee"
                             :file-path ("referee\\.org"))
                            (:name "SysAdmin"
                             :file-path ("foreman\\.org" "system.*\\.org"))
                            (:name "Home"
                             :file-path "home\\.org")))))))))
  :config
  (org-super-agenda-mode))

;; This will change the color of the annotation.
(setq pdf-annot-default-markup-annotation-properties
      '((color . "orange")))

(use-package! org-noter
  :config
  (require 'org-noter-pdftools)
  (setq org-noter-hide-other nil))

(use-package! org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package! org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freestyle-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
    With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package! org-ref
    :after org
    :defer t
    :init
    (setq org-ref-completion-library 'org-ref-ivy-cite)
    (let ((cache-dir (concat doom-cache-dir "org-ref")))
    (unless (file-exists-p cache-dir)
      (make-directory cache-dir t))
    (setq orhc-bibtex-cache-file (concat cache-dir "/orhc-bibtex-cache")))
    :config
    (setq org-ref-default-bibliography (list crewsbib)
          org-ref-default-citation-link "cite"
          org-ref-notes-directory (concat org-roam-directory "refs/")
          org-ref-notes-function 'orb-edit-notes
          org-ref-pdf-directory (concat crewsbib-dir "pdf/")
          org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex))

(use-package! bibtex-completion
  :defer t
  :config
  (setq bibtex-completion-bibliography crewsbib
        bibtex-completion-library-path (concat crewsbib-dir "pdf/")
        bibtex-completion-pdf-field nil ;; "file" ;; pulls PDF path from "File" field of JabRef
        bibtex-completion-find-additional-pdfs nil ;; t ;; will match all <citekey>-appendix.pdf
        bibtex-completion-notes-path (concat org-roam-directory "refs") ;; one note file per reference
        bibtex-completion-additional-search-fields '(keywords journal booktitle)
        bibtex-completion-display-formats
        '((article       . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*} ${journal:20}")
          (book          . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*}")
          (inbook        . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*} Chapter ${chapter:30}")
          (incollection  . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*} ${booktitle:30}")
          (inproceedings . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*} ${booktitle:30}")
          (t             . "${=has-pdf=:2}${=has-note=:2} ${=type=:4} ${year:4} ${author:36} ${title:*}"))
        bibtex-completion-pdf-symbol ""
        bibtex-completion-notes-symbol ""
        bibtex-completion-format-citation-functions
            '((org-mode      . bibtex-completion-format-citation-org-title-link-to-PDF)
              (latex-mode    . bibtex-completion-format-citation-cite)
              (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
              (default       . bibtex-completion-format-citation-default))
        ))

(use-package! ivy-bibtex
  :when (featurep! :completion ivy)
  :config
  (global-set-key (kbd "C-c n b") 'ivy-bibtex)
  (add-to-list 'ivy-re-builders-alist '(ivy-bibtex . ivy--regex-plus))
  (setq ivy-bibtex-default-action 'ivy-bibtex-edit-notes)
  ;;(ivy-set-display-transformer 'org-ref-ivy-insert-cite-link 'ivy-bibtex-display-transformer)

  (defun lgc/bibtex-random-ref (&optional arg local-bib)
  "Find a random BibTeX entry using ivy.
   With a prefix ARG the cache is invalidated and the bibliography
   reread. If LOCAL-BIB is non-nil, display that the BibTeX entries are read
   from the local bibliography.  This is set internally by `ivy-bibtex-with-local-bibliography'."
   (interactive "P")
   (when arg
     (bibtex-completion-clear-cache))
   (bibtex-completion-init)
   (let* ((candidates (bibtex-completion-candidates))
          (key (bibtex-completion-key-at-point))
          (preselect (and key
                         (cl-position-if (lambda (cand)
                                           (member (cons "=key=" key)
                                                   (cdr cand)))
                                         candidates)))) ;; ~candidates~ is a list

      (ivy-read (format "random BibTeX entry: " (if local-bib " (local)" ""))
                (list (nth (random (length candidates)) candidates)
                      (nth (random (length candidates)) candidates)
                      (nth (random (length candidates)) candidates))
                :preselect preselect
                :caller 'lgc/bibtex-random-ref
                ;;:history 'ivy-bibtex-history
                :action ivy-bibtex-default-action)))

  (global-set-key (kbd "C-c n p") 'lgc/bibtex-random-ref))

(use-package! deft
  :after org
  :init
  (setq deft-file-naming-rules
      '((noslash . "-")
        (nospace . "-")
        (case-fn . downcase)))
  :custom
  (deft-recursive t)
  (deft-use-filename-as-title nil)
  (deft-use-filter-string-for-filename t)
  (deft-extensions '("tex" "org"))
  (deft-default-extension "org"))

(after! org
  (map! ("C-c n d" #'org-roam-today)
         :map org-mode-map
         (("C-c n l" #'org-roam) ;; call this to show backlinks in side-buffer
          ("C-c n u" #'org-roam-update-buffer)
          ("C-c n i" #'org-roam-insert)
          ("C-c n c" #'org-roam-capture)
          ("C-c n g" #'org-roam-graph)
          ("C-c n r" #'org-roam-random-note)))
  (setq org-roam-tag-sources '(prop last-directory)
        org-roam-capture-templates
        '(("p" "plain" plain #'org-roam-capture--get-point "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: \n#+created: %U\n#+last_modified: %U\n\n"
         :unnarrowed t)
          ("d" "data" plain #'org-roam-capture--get-point "%?"
         :file-name "refs/${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: data refs\n#+created: %U\n#+last_modified: %U\n\n* Overview\n:PROPERTIES:\n:url: \n:END:\n* Specifications\n* Construction\n* Access\n"
         :unnarrowed t)
          ("r" "resource" plain #'org-roam-capture--get-point "%?"
         :file-name "refs/${slug}"
         :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: refs\n#+created: %U\n#+last_modified: %U\n\n* Overview\n:PROPERTIES:\n:url: \n:END:\n"
         :unnarrowed t))
        org-roam-dailies-capture-templates
        '(("d" "default" plain
           #'org-roam-capture--get-point
           "* %?"
           :file-name "journal/%<%Y-%m-%d>"
           :head "#+title: %<%d-%B-%Y>\n\n")
          ("t" "today" plain
           #'org-roam-capture--get-point
           "* %?"
           :file-name "journal/%<%Y-%m-%d>"
           :head "#+title: %<%d-%B-%Y>\n\n"
           %["~/Dropbox/org/templates/daily.template"])
          ("w" "weekly review" plain
           #'org-roam-capture--get-point
           "* %?"
           :file-name "journal/%<%Y-%m-%d>"
           :head "#+title: %<%d-%B-%Y>\n\n"
           %["~/Dropbox/org/templates/review-week.template"]))))

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-roam-bibtex-mode-map
         (("C-c n f" . orb-find-non-ref-file))
         :map org-mode-map
         (("C-c n t" . orb-insert-non-ref)
          ("C-c n a" . orb-note-actions)))
  :config
  (require 'org-ref)
  (require 'bibtex-completion)
  (require 'ivy-bibtex))

(setq orb-autokey-format "%A[5]%y"
      orb-preformat-keywords
      '("citekey" "title" "url" "doi" "year" "journal" "author-or-editor" "keywords" "file")
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf")
      orb-insert-interface 'ivy-bibtex
      orb-note-actions-interface 'ivy
      orb-insert-link-description 'citation)
(defvar orb-title-format "${author-or-editor} (${year}). ${title}."
  "Format of the title to use for `orb-templates'.")
(setq orb-templates
      `(("r" "ref" plain
      (function org-roam-capture--get-point)
      ""
      :file-name "refs/${citekey}"
      :head ,(s-join "\n"
                     (list
                      (concat "#+title: "
                              orb-title-format)
                      "#+roam_key: cite:${citekey}"
                      "#+roam_tags: ${keywords}"
                      "#+created: %U"
                      "#+last_modified: %U\n")))
     ("p" "ref + physical" plain
      (function org-roam-capture--get-point)
      ""
      :file-name "refs/${citekey}"
      :head ,(s-join "\n"
                     (list
                      (concat "#+title: "
                              orb-title-format)
                      "#+roam_key: cite:${citekey}"
                      "#+roam_tags: ${keywords}"
                      "#+created: %U"
                      "#+last_modified: %U\n"
                      "* Summary :physical:"
                      "* Coming to terms")))
     ("n" "ref + noter" plain
      (function org-roam-capture--get-point)
      ""
      :file-name "refs/${citekey}"
      :head ,(s-join "\n"
                     (list
                      (concat "#+title: "
                              orb-title-format)
                      "#+roam_key: cite:${citekey}"
                      "#+roam_tags: ${keywords}"
                      "#+created: %U"
                      "#+last_modified: %U\n"
                      "* Annotations :noter:"
                      ":PROPERTIES:"
                      ":noter_document: ${file}"
                      ":noter_page:"
                      ":author: ${author-or-editor}"
                      ":journal: ${journal}"
                      ":year: ${year}"
                      ":doi: ${doi}"
                      ":END:"
                      "* RAP+M"
                      "** Position"
                      "** Research question"
                      "** Method"
                      "*** data"
                      "*** model"
                      "** Answer"
                      "* Picking nits"
                      )))
     ("u" "ref + url" plain
      (function org-roam-capture--get-point)
      ""
      :file-name "refs/${citekey}"
      :head ,(s-join "\n"
                     (list
                      (concat "#+title: "
                              orb-title-format)
                      "#+roam_key: cite:${citekey}"
                      "#+roam_tags: ${keywords}"
                      "#+created: %U"
                      "#+last_modified: %U\n"
                      "* Summary"
                      ":PROPERTIES:"
                      ":author: ${author-or-editor}"
                      ":year: ${year}"
                      ":url: ${url}"
                      ":END:")))))

(after! org
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package! insert-esv
  :init
  (setq insert-esv-crossway-api-key "24c9430529b290c392e875b1563aac55e4210a7d")
  (setq insert-esv-include-short-copyright 'true)
  (setq insert-esv-include-headings 'false)
  (setq insert-esv-include-first-verse-numbers 'false)
  (setq insert-esv-include-footnotes 'false)
  (setq insert-esv-include-passage-horizontal-lines 'false)
  (setq insert-esv-line-length '65)
  (global-set-key (kbd "C-x i") 'insert-esv-passage))
