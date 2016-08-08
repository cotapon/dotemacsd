((ac-anything status "required" recipe nil)
 (anything status "installed" recipe
           (:name anything :after nil :features
                  (anything)
                  :website "http://www.emacswiki.org/emacs/Anything" :description "Open anything / QuickSilver-like candidate-selection framework" :type git :url "http://repo.or.cz/r/anything-config.git" :shallow nil :load-path
                  ("." "extensions" "contrib")))
 (anything-complete status "installed" recipe
                    (:name anything-complete :after nil :depends
                           (anything)
                           :description "completion with anything" :type emacswiki :feature anything-complete))
 (anything-with-everything status "required" recipe nil)
 (anything-with-everything\.el status "required" recipe nil)
 (auto-complete status "installed" recipe
                (:name auto-complete :after nil :features
                       (auto-complete-config)
                       :depends
                       (fuzzy popup)
                       :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :post-init
                       (progn
                         (add-to-list 'ac-dictionary-directories
                                      (expand-file-name "dict" default-directory))
                         (ac-config-default))))
 (cl-lib status "installed" recipe
         (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (coffee-mode status "installed" recipe
              (:name coffee-mode :type github :pkgname "defunkt/coffee-mode" :after nil :features
                     (coffee-mode)))
 (company status "installed" recipe
          (:name company :type elpa :after nil))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
                ("el-get.*\\.el$" "methods/")
                :features el-get :post-init
                (when
                    (memq 'el-get
                          (bound-and-true-p package-activated-list))
                  (message "Deleting melpa bootstrap el-get")
                  (unless package--initialized
                    (package-initialize t))
                  (when
                      (package-installed-p 'el-get)
                    (let
                        ((feats
                          (delete-dups
                           (el-get-package-features
                            (el-get-elpa-package-directory 'el-get)))))
                      (el-get-elpa-delete-package 'el-get)
                      (dolist
                          (feat feats)
                        (unload-feature feat t))))
                  (require 'el-get))))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (flycheck status "installed" recipe
           (:name flycheck :type github :pkgname "flycheck/flycheck" :after nil :depends
                  (seq let-alist pkg-info dash)))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (helm status "installed" recipe
       (:name helm :after nil :features
              ("helm-config")
              :description "Emacs incremental completion and narrowing framework" :type github :pkgname "emacs-helm/helm" :autoloads "helm-autoloads" :build
              (("make"))
              :build/darwin
              `(("make" ,(format "EMACS_COMMAND=%s" el-get-emacs)))
              :build/windows-nt
              (let
                  ((generated-autoload-file
                    (expand-file-name "helm-autoloads.el"))
                   \
                   (backup-inhibited t))
              (update-directory-autoloads default-directory)
              nil)
       :post-init
       (helm-mode)))
(helm-ag status "installed" recipe
(:name helm-ag :after nil :depends
(helm)
:description "The silver search with helm interface." :type github :pkgname "syohex/emacs-helm-ag"))
(jade-mode status "installed" recipe
(:name jade-mode :description "Emacs major mode for jade template highlighting." :type github :pkgname "brianc/jade-mode"))
(js2-mode status "installed" recipe
(:name js2-mode :after nil :website "https://github.com/mooz/js2-mode#readme" :description "An improved JavaScript editing mode" :type github :pkgname "mooz/js2-mode" :prepare
(autoload 'js2-mode "js2-mode" nil t)))
(json-mode status "installed" recipe
(:name json-mode :after nil :depends
(json-reformat json-snatcher)
:description "Major mode for editing JSON files, extends the builtin js-mode to add better syntax highlighting for JSON." :type github :pkgname "joshwnj/json-mode"))
(json-reformat status "installed" recipe
(:name json-reformat :description "Reformatting tool for JSON." :type github :pkgname "gongo/json-reformat"))
(json-snatcher status "installed" recipe
(:name json-snatcher :description "Find the path to a value in JSON" :type github :pkgname "Sterlingg/json-snatcher"))
(less-css-mode status "installed" recipe
(:name less-css-mode :after nil :description "Emacs mode for LESS CSS (lesscss.org), with support for compile-on-save" :type github :pkgname "purcell/less-css-mode"))
(let-alist status "installed" recipe
(:name let-alist :description "Easily let-bind values of an assoc-list by their names." :builtin "25.0.50" :type elpa :url "https://elpa.gnu.org/packages/let-alist.html"))
(markdown-mode status "installed" recipe
(:name markdown-mode :after nil :description "Major mode to edit Markdown files in Emacs" :website "http://jblevins.org/projects/markdown-mode/" :type github :pkgname "jrblevin/markdown-mode" :prepare
(add-to-list 'auto-mode-alist
'("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
(package status "installed" recipe
(:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
(progn
(let
((old-package-user-dir
(expand-file-name
(convert-standard-filename
(concat
(file-name-as-directory default-directory)
"elpa")))))
(when
(file-directory-p old-package-user-dir)
(add-to-list 'package-directory-list old-package-user-dir)))
(setq package-archives
(bound-and-true-p package-archives))
(mapc
(lambda
(pa)
(add-to-list 'package-archives pa 'append))
'(("ELPA" . "http://tromey.com/elpa/")
("melpa" . "http://melpa.org/packages/")
("gnu" . "http://elpa.gnu.org/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
(pkg-info status "installed" recipe
(:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
(dash epl)))
(popup status "installed" recipe
(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :depends cl-lib :pkgname "auto-complete/popup-el"))
(seq status "installed" recipe
(:name seq :description "Sequence manipulation library for Emacs" :builtin "25" :type github :pkgname "NicolasPetton/seq.el"))
(stylus-mode status "installed" recipe
(:name stylus-mode :type elpa :after nil))
(tide status "installed" recipe
(:name tide :type github :pkgname "ananthakumaran/tide" :after nil :depends
(dash flycheck typescript-mode)))
(typescript-mode status "installed" recipe
(:name typescript-mode :description "TypeScript mode" :type github :pkgname "ananthakumaran/typescript.el"))
(typescript\.el status "installed" recipe
(:name typescript\.el :type github :pkgname "ananthakumaran/typescript.el" :after nil))
(undo-tree status "installed" recipe
(:name undo-tree :after nil :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
(uniquify status "required" recipe nil))
