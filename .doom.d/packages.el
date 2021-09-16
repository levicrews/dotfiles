;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! emojify)
(package! org-super-agenda)
(package! org-pdftools)
(package! org-noter-pdftools)
(package! org-ref)
(package! bibtex-completion :pin "1bb81d77e08296a50de7ebfe5cf5b0c715b7f3d6")
(when (featurep! :completion ivy)
  (package! ivy-bibtex :pin "1bb81d77e08296a50de7ebfe5cf5b0c715b7f3d6"))
(when (featurep! :completion helm)
  (package! helm-bibtex :pin "1bb81d77e08296a50de7ebfe5cf5b0c715b7f3d6"))
(unpin! org-roam)
(package! org-roam-bibtex :pin "80a86980801ff233d7c12ae9efef589ffa53df67"
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-roam-server :recipe (:host github :repo "org-roam/org-roam-server" :files ("*")))
(package! company-org-roam :recipe (:host github :repo "org-roam/company-org-roam"))
;; (unpin! deft) ;; package cl is deprecated
(package! org-analyzer)
(package! insert-esv)
(package! magit-section) ;; temporary: https://github.com/hlissner/doom-emacs/issues/2415
(package! sword-to-org
  :recipe (:host github :repo "alphapapa/sword-to-org"
           :files ("sword-to-org.el")))
(package! org-appear :recipe (:host github :repo "awth13/org-appear")
  :pin "148aa124901ae598f69320e3dcada6325cdc2cf0")
(package! org-ref-prettify)
