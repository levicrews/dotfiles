;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(remove-hook 'org-mode-hook #'+literate-enable-recompile-h) ;; don't tangle on save

(defadvice! fixed-do-after-load-evaluation (abs-file)
  :override #'do-after-load-evaluation
  (dolist (a-l-element after-load-alist)
    (when (and (stringp (car a-l-element))
               (string-match-p (car a-l-element) abs-file))
      (mapc #'funcall (cdr a-l-element))))
  (run-hook-with-args 'after-load-functions abs-file))

(setq user-full-name "Levi Crews"
      user-mail-address "levigcrews@gmail.com")

(setq auto-save-visited-mode t
      auto-revert-mode t
      auto-save-default nil
      make-backup-files nil)

(setq doom-themes-enable-italic t)
(load-theme 'doom-zenburn t)
(custom-theme-set-faces! 'doom-zenburn
  `(org-document-info-keyword :foreground ,(doom-lighten 'fg-1 0.2))
  `(org-done :foreground ,(doom-lighten 'fg-1 0.05))
  `(org-ellipsis :foreground ,(doom-lighten 'fg-1 0.2)))

(setq frame-resize-pixelwise t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq doom-font (font-spec :family "Cascadia Mono PL" :size 13 :weight 'regular)
      doom-big-font (font-spec :family "Cascadia Mono PL" :size 20 :weight 'bold))

(setq display-line-numbers-type t)

(setq global-visual-line-mode t)

(delete-selection-mode 1)                               ; Replace selection when inserting text
(global-subword-mode 1)                                 ; Iterate through CamelCase words
(global-set-key (kbd "C-c d") 'define-word-at-point)
(global-set-key (kbd "C-c D") 'define-word)

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

(setq org-dir (concat (getenv "HOME") "/Dropbox/org/")
      crewsbib-dir (concat (getenv "HOME") "/Dropbox/crewsbib/")
      crewsbib (concat crewsbib-dir "crewsbib.bib")
      org-directory org-dir
      deft-directory (concat org-dir "roam/")
      org-roam-directory (concat org-dir "roam/")
      org-roam-dailies-directory (concat org-dir "roam/journal/")
      reftex-default-bibliography (list crewsbib))

(defun lgc/insert-right-arrow ()
  "Insert → (U+2192)."
  (interactive)
  (insert ?\u2192))

(after! org
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c i r") #'lgc/insert-right-arrow)
  ;; Use Org’s S-<arrow> actions (don’t do shift-selection in Org buffers)
  (setq org-support-shift-select nil))

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

(defface lgc/org-link-internal
  '((t :inherit org-link))
  "Internal Org links keep org-link styling but in citation color.")

(with-eval-after-load 'org
  (dolist (type '("file" "id"))
    (org-link-set-parameters type :face 'lgc/org-link-internal)))

(with-eval-after-load 'org-ref
  (let ((c (face-foreground 'org-ref-cite-face nil 'default)))
    (when c (set-face-attribute 'lgc/org-link-internal nil :foreground c))))

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
    (sequence "SPEC(i)" "KNOW(u!)" "EVAL(e!)" "|" "READ(r)")
    (sequence "FILL(f)" "LINK(l)" "|" "DONE(d)"))))

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
        org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
        org-agenda-breadcrumbs-separator " ❱ "
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-remove-tags t
        org-agenda-prefix-format
        '((agenda . "  %-20:c%?-12t% s")
          (todo . "  %-20:c")
          (tags . "  %-20:c")
          (search . "  %-20:c")))
  (setq org-agenda-custom-commands
        '(("c" "The Mill"
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
                          '((:name "Research pipeline"
                             :file-path ("roam/projects/"))
                            (:name "Teaching + Service + Career"
                             :file-path ("roam/teaching/" "service\\.org" "career\\.org"))
                            (:name "Referee"
                             :file-path ("referee\\.org"))
                            (:name "SysAdmin"
                             :file-path ("roam/system.*\\.org"))
                            (:name "Home + Church"
                             :file-path ("home\\.org" "church\\.org"))))))
            (tags-todo "+PRIORITY=\"A\"+TODO=\"SPEC\"|+PRIORITY=\"A\"+TODO=\"KNOW\"|+PRIORITY=\"A\"+TODO=\"EVAL\"|+PRIORITY=\"A\"+TODO=\"FILL\"|+PRIORITY=\"A\"+TODO=\"LINK\"" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Reading inbox"
                             :file-path ("[^a-z0-9]p-[a-z0-9]*\\.org" "roam/projects/" "roam/reading-inbox\\.org"))
                            (:name "Writing inbox"
                             :file-path "roam/writing-inbox\\.org")
                            (:discard (:anything t))))))
            ))))
  :config
  (org-super-agenda-mode))

(defun research-pipelines ()
    (append (file-expand-wildcards "~/Dropbox/org/p-*")
            (file-expand-wildcards "~/Dropbox/org/roam/projects/*")))

;; Set preferred highlight color for PDF annotations
(after! pdf-tools
  (setq pdf-annot-default-markup-annotation-properties '((color . "orange"))))

;; Make Org links to PDFs open in pdf-tools
(after! org
  (add-hook 'org-mode-hook #'org-pdftools-setup-link))

;; org-noter integration with pdf-tools
(after! org-noter
  (require 'org-noter-pdftools)
  (setq org-noter-hide-other nil)
  ;; When you activate an annotation in a PDF, jump to its note
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions
              #'org-noter-pdftools-jump-to-note)))

(use-package! bibtex-completion
    :defer t
    :init
    (setq bibtex-completion-bibliography crewsbib
          bibtex-completion-library-path (concat crewsbib-dir "pdf/")
          bibtex-completion-pdf-field nil
          bibtex-completion-find-additional-pdfs nil
          bibtex-completion-notes-path (concat org-roam-directory "refs/")
          bibtex-completion-notes-extension ".org"
          bibtex-completion-cache-file (expand-file-name "bibtex-completion-cache" doom-cache-dir)
          bibtex-completion-pdf-symbol "■";; "󰈦" Hex #f0226
          bibtex-completion-notes-symbol "✎";;"󰏫" Hex #f03eb
          bibtex-completion-display-formats
          '((article       . "${=has-pdf=:1} ${=has-note=:1} ${=type=:4} ${year:4} ${author:36} ${title:*} ${journal:24}")
          (inproceedings . "${=has-pdf=:1} ${=has-note=:1} ${=type=:4} ${year:4} ${author:36} ${title:*} ${booktitle:24}")
          (book          . "${=has-pdf=:1} ${=has-note=:1} ${=type=:4} ${year:4} ${author:36} ${title:*}")
          (t             . "${=has-pdf=:1} ${=has-note=:1} ${=type=:4} ${year:4} ${author:36} ${title:*}"))
          ))

(use-package! ivy-bibtex
    :when (featurep! :completion ivy)
    :config
    (global-set-key (kbd "C-c n b") #'ivy-bibtex)
    (add-to-list 'ivy-re-builders-alist '(ivy-bibtex . ivy--regex-plus))
    (setq ivy-bibtex-default-action #'ivy-bibtex-edit-notes))

(use-package! org-ref
    :defer t
    :init
    (setq org-ref-completion-library 'org-ref-ivy-cite)
    :config
    (setq org-ref-default-bibliography (list crewsbib)
          org-ref-notes-function 'orb-edit-notes
          org-ref-pdf-directory (concat crewsbib-dir "pdf/")))

(after! org-ref
  (defun lgc/org-ref--strip-leading-&-when-single ()
    "If cite link at point has a single key like `cite:&KEY`, drop the `&`."
    (when (derived-mode-p 'org-mode)
      (let ((el (org-element-context)))
        (when (eq (org-element-type el) 'link)
          (let* ((type (org-element-property :type el)))
            (when (and type (string-prefix-p "cite" type))
              (let* ((beg (org-element-property :begin el))
                     (end (org-element-property :end el))
                     (txt (and beg end (buffer-substring-no-properties beg end))))
                ;; Only fix if it doesn't contain the multi-key separator ";&"
                (when (and txt (not (string-match-p ";&" txt))
                           (string-match-p "cite:&" txt))
                  (save-excursion
                    (goto-char beg)
                    (when (re-search-forward "cite:&" end t)
                      (replace-match "cite:" nil nil)))))))))))

  (defun lgc/advice-org-ref-insert-cite-link (orig &rest args)
    (apply orig args)
    (lgc/org-ref--strip-leading-&-when-single))

  (advice-add 'org-ref-insert-cite-link :around
              #'lgc/advice-org-ref-insert-cite-link))

;; insert a cite:<refkey> link via org-ref
(after! org
  (map! :map org-mode-map
        :desc "Insert citation (org-ref)"
        "C-c ) i" #'org-ref-insert-cite-link))

(after! org-roam
  (org-roam-db-autosync-mode 1) ;; keep the DB in sync automatically
  (setq org-roam-tag-sources '(prop last-directory) ;; tag if in subdirectory
        org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  ;; ---- Capture templates ----
  (setq org-roam-capture-templates
        '(("n" "note" plain "* %?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              ":PROPERTIES:\n:ROAM_ALIASES: %^{aliases}\n:END:\n#+title: ${title}\n#+created: %U\n#+last_modified: %U\n#+filetags:\n\n")
           :immediate-finish t
           :unnarrowed t)
          ("d" "data" plain "* %?"
           :if-new (file+head "refs/${slug}.org"
                              ":PROPERTIES:\n:ROAM_REFS: %^{url}\n:ROAM_ALIASES: %^{aliases}\n:END:\n#+title: ${title}\n#+created: %U\n#+last_modified: %U\n#+filetags: :data:refs:\n\n* overview\n* specifications\n* construction\n* access\n")
           :immediate-finish t
           :unnarrowed t)
          ("r" "resource" plain "* %?"
           :if-new (file+head "refs/${slug}.org"
                              ":PROPERTIES:\n:ROAM_REFS: %^{url}\n:ROAM_ALIASES: %^{aliases}\n:END:\n#+title: ${title}\n#+created: %U\n#+last_modified: %U\n#+filetags: :refs:\n\n")
           :immediate-finish t
           :unnarrowed t)
          ))

  ;; ---- Dailies with custom templates ----
  (setq org-roam-dailies-directory "journal/"
        org-roam-dailies-capture-templates
        '(("t" "today" plain
           (file "~/Dropbox/org/templates/daily.template")
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%d-%B-%Y>\n"))
          ("w" "weekly review" plain
           (file "~/Dropbox/org/templates/review-week.template")
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%d-%B-%Y>\n"))
          ))

  ;; ---- Custom function to refile headline to file ----
  
  ;; ---- Better capture from the browser ----
  (require 'org-roam-protocol)

  ;; ---- Better export support ----
  (require 'org-roam-export)

  ;; ---- Restore v1 keybindings ----
  (map! :map org-mode-map
        "C-c n r r" #'org-roam-buffer-toggle     ; show backlinks
        "C-c n r f" #'org-roam-node-find
        "C-c n r i" #'org-roam-node-insert
        "C-c n r d" #'org-roam-dailies-capture-today
        "C-c n r a" #'org-roam-alias-add
        "C-c n r g" #'org-roam-graph
        ))

(use-package! org-roam-bibtex
  :after (org-roam bibtex-completion)
  :config
  (org-roam-bibtex-mode +1)

  (setq orb-autokey-format "%A[5]%y"
        orb-preformat-keywords
        '("citekey" "title" "url" "doi" "year" "journal" "author-or-editor" "keywords" "file")
        orb-process-file-keyword t
        orb-file-field-extensions '("pdf")
        orb-insert-interface 'ivy-bibtex
        orb-note-actions-interface 'hydra
        orb-roam-ref-format 'org-ref-v2
        orb-insert-link-description 'citation-org-ref-2)

  ;; ---- Roam buffer ----
  (setq org-roam-mode-section-functions
      (list #'orb-section-reference
            #'orb-section-abstract
            ;;#'orb-section-file
            #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;;#'org-roam-unlinked-references-section
            ))

  (setq org-roam-capture-templates
        (append org-roam-capture-templates
        `(("p" "ref + physical" plain
           "\n\n* summary :physical:\n%?"
           :target (file+head "refs/${citekey}.org"
                              "#+title: ${author-or-editor} (${year}). ${title}.\n#+created: %U\n#+last_modified: %U\n#+filetags: ${keywords}\n")
           :unnarrowed t)
          ("a" "ref + annotate" plain
           "\n\n* annotations :noter:\n:PROPERTIES:\n:noter_document: %^{file}\n:noter_page:\n:author: %^{author-or-editor}\n:journal: %^{journal}\n:year: %^{year}\n:doi: %^{doi}\n:END:\n* RAP+M\n** Position\n** Research question\n** Method\n*** data\n*** model\n** Answer\n* lit fit + tidbits\n* picking nits\n%?"
           :target (file+head "refs/${citekey}.org"
                              "#+title: ${author-or-editor} (${year}). ${title}.\n#+created: %U\n#+last_modified: %U\n#+filetags: ${keywords}\n")
           :unnarrowed t)
          ("u" "ref + url" plain
           "\n\n* summary\n:PROPERTIES:\n:author: %^{author-or-editor}\n:year: %^{year}\n:url: %^{url}\n:END:\n\n%?"
           :target (file+head "refs/${citekey}.org"
                              "#+title: ${author-or-editor} (${year}). ${title}.\n#+created: %U\n#+last_modified: %U\n#+filetags: ${keywords}\n")
           :unnarrowed t)
          )))

  (setq orb-pdf-scrapper-group-references t
        orb-pdf-scrapper-list-style 'unordered-hyphen
        orb-pdf-scrapper-citekey-format "cite:%s")

  (setq orb-pdf-scrapper-export-options
      '((org
         ;; Export citation links to specified header
         (heading "references"
                     :property-drawer ("PDF_SCRAPPER_TYPE"
                                       "PDF_SCRAPPER_SOURCE"
                                       "PDF_SCRAPPER_DATE")))
        (bib
         ;; Export BibTeX entries to the file CITEKEY.bib in specified directory
         (path crewsbib-dir
               :placement prepend
              ;; Include only the references that are not in the target file
              ;; *and* the file(s) specified in bibtex-completion-bibliography
               :filter-bib-entries bibtex-completion-bibliography))))

  )

(after! deft

  (defun lgc/deft-parse-title (file contents)
    "Parse the given FILE and CONTENTS and determine the title.
     If `deft-use-filename-as-title' is nil, the title is taken to
     be the first non-empty line of the FILE.  Else the base name of the FILE is
     used as title."
      (let ((begin (string-match "^#\\+[tT][iI][tT][lL][eE]: .*$" contents)))
	(if begin
	    (string-trim (substring contents begin (match-end 0)) "#\\+[tT][iI][tT][lL][eE]: *" "[\n\t ]+")
	  (deft-base-filename file))))

  (advice-add 'deft-parse-title :override #'lgc/deft-parse-title)

  (setq deft-directory org-roam-directory
        deft-recursive t
        deft-extensions '("org")
        deft-use-filename-as-title nil
        ;; deft-use-filter-string-for-filename t
        ;; Use Org's #+title: instead
        deft-strip-summary-regexp
	  (concat "\\("
		  "[\n\t]" ;; blank
		  "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
		  "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
		  "\\)")))

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
