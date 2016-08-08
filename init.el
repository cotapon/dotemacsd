;;-----------------------------------------------------------------
;; el-get
;;-----------------------------------------------------------------
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;-----------------------------------------------------------------
;; el-get bundles
;;-----------------------------------------------------------------
(el-get-bundle ananthakumaran/typescript.el)
(el-get-bundle ananthakumaran/tide)
(el-get-bundle company)
(el-get-bundle dash)
(el-get-bundle flycheck/flycheck)

;;-----------------------------------------------------------------
;; packages
;;-----------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;-----------------------------------------------------------------
;; setting
;;-----------------------------------------------------------------

;; load path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/conf")

;; cratchバッファの初期メーッセージを非表示
(setq initial-scratch-message "")

;; バックアップファイルを作らない
(setq auto-save-default nil)
(setq make-backup-files nil)

;; .#xxxファイルを作らない
(setq create-lockfiles nil)

;; デバッグには入らない
(setq debug-on-error nil)

;; ファイル名の末尾に「〜」がつくバックアップファイルを作らない設定。
(setq make-backup-files nil) ;; fileを作成しない

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;; 起動時から global-auto-revert-mode を有効にする
(global-auto-revert-mode 1)

;; Tabはspace x 2
(setq-default tab-width 2 indent-tabs-mode nil)

;; 次の行を自動でインデント
(defun set-c-mode-common-conf ()
  (c-toggle-auto-newline 1)
  )

;; C-o open-line したあとにインデント
(defun open-line-and-indent (&optional n)
  "Open line and indent."
  (interactive "p")
  (open-line n)
  (indent-according-to-mode))

;; utf-8
(progn
  (set-language-environment 'Japanese)
  (set-terminal-coding-system 'utf-8)
  (setq file-name-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
;; For yatex mode
;; (setq coding-system-for-read 'mule-utf-8-unix)
  (prefer-coding-system 'utf-8)
 (set-default-coding-systems 'utf-8)
 (set-keyboard-coding-system 'utf-8)
 (set-buffer-file-coding-system 'utf-8-unix)
 )

;; 折り返し
(setq truncate-partial-width-windows nil)

;; file-cache
(file-cache-add-directory "./")

;; find-grepコマンドを変更
(setq grep-find-command "find . -type f -not -name '*log' -not -name '*svn-base' -not -name '*tmp' -print0 | xargs -0 grep -nH -e ")

;; 画面色設定
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 80)
   ))

;; 行番号
(global-linum-mode t)
(set-face-foreground 'linum "#666666")
(set-face-background 'linum "#000000")


;; indentにtabを使用しない
(setq-default c-basic-offset 2     ;;基本インデント量2
              ;; tab-width 2          ;;タブ幅2
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか


;; メニューバーを表示しない
(menu-bar-mode 0)

;; ツールバーを表示しない
(tool-bar-mode 0)

;; 前回編集していた場所を記憶
(load "saveplace")
(setq-default save-place t)

;; 括弧の対応をハイライト.
(show-paren-mode 1)

;; BS で選択範囲を消す
(delete-selection-mode 1)

;;モードラインにカーソルがある位置の文字数を表示
(column-number-mode t)
(line-number-mode t)

;; セーブ時に文字の後ろの空白を削除するように
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
;;(pc-selection-mode 1)

;; M-xでコマンドを入力するときに候補を表示する
(icomplete-mode 1)

;; 同一ファイル名を区別する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; find fileで候補を出す
(require 'ido)
(ido-mode t)

;; Smooth down key 1行スクロール
;; http://akio0911.net/archives/7050
(setq scroll-conservatively 200
  scroll-margin 0
  scroll-step 4)

;; CommandとOptionを入れ替える
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; 物理行単位で移動
(require 'physical-line)
(define-key global-map "\C-a" 'physical-line-beginning-of-line)
(define-key global-map "\C-e" 'physical-line-end-of-line)

;; Answer y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; 起動時から global-auto-revert-mode を有効にする
(global-auto-revert-mode 1)

;; emacs 最初の画面を非表示
(setq inhibit-startup-message t)

;; 現在開いてるバッファを再読込する
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
(global-set-key "\M-r" 'revert-buffer-no-confirm)


; 括弧クオート補完
(require 'smartparens-config)
(smartparens-global-mode t)

; undo redo で変わったところをハイライト
(require 'volatile-highlights)
(volatile-highlights-mode t)

; コマンドTで画面分割
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "M-t") 'other-window-or-split)

;;-----------------------------------------------------------------
; Font 設定(Mac)
;;-----------------------------------------------------------------
(if (eq window-system 'mac)
    (progn
      (setq my-font "-*-*-medium-r-normal--14-*-*-*-*-*-fontset-hiramaru")
      (setq fixed-width-use-QuickDraw-for-ascii t)
      (setq mac-allow-anti-aliasing t)
      (if (= emacs-major-version 22)
          (require 'carbon-font))
      (set-default-font my-font)
      (add-to-list 'default-frame-alist `(font . ,my-font))
      (when (= emacs-major-version 23)
        (set-fontset-font
         (frame-parameter nil 'font)
         'japanese-jisx0208
         '(".*Hiragino_Kaku_Gothic_ProN.*" . "iso10646-1"))
        (set-fontset-font
         (frame-parameter nil 'font)
         'katakana-jisx0201
         '(".*Hiragino_Kaku_Gothic_ProN.*" . "iso10646-1"))
        (set-fontset-font
         (frame-parameter nil 'font)
         'japanese-jisx0212
         '(".*Hiragino_Kaku_Gothic_ProN.*" . "iso10646-1"))
        (setq face-font-rescale-alist
              '(("^-apple-hiragino.*" . 1.2)
                (".*osaka-bold.*" . 1.2)
                (".*osaka-medium.*" . 1.2)
                (".*courier-bold-.*-mac-roman" . 1.0)
                (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                (".*monaco-bold-.*-mac-roman" . 0.9)
                ("-cdac$" . 1.3))))
    )
)

 ;; 英語
(if (eq window-system 'mac) (progn
  (set-face-attribute 'default nil
             :family "Source Code Pro")

  (create-fontset-from-ascii-font
        "源ノ角ゴシック Code JP:weight=normal:slant=normal"
        nil "codekakugo")
  (set-fontset-font "fontset-codekakugo"
                         'unicode
                         (font-spec :family "Hiragino Kaku Gothic Pro" :size 16)
                         nil
                         'append)
  (add-to-list 'default-frame-alist '(font . "fontset-codekakugo"))
  ))


;;-----------------------------------------------------------------
;; KEY BIND
;;-----------------------------------------------------------------
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-k" 'copy-line)
(global-set-key "\C-cr" 'comment-region)
(global-set-key "\C-cb" 'comment-box)
(global-set-key "\C-c\C-q" 'indent-region)
(global-set-key "\C-c\C-f" 'find-grep-dired)
(global-set-key "\C-c\C-c\C-f" 'find-grep)
(global-set-key "\C-x\C-j" 'dired-jump)
(global-set-key "\C-x\M-f" 'find-file-other-window)
(global-set-key "\C-cs" 'shell-pop)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)
(global-set-key "\M-v" 'scroll-down)


;;(setq grep-find-command "find . -type f -not -name '*log' -not -name '*svn-base' -not -name '*tmp' -print0 | xargs -0 grep -nH -e ")


;;-----------------------------------------------------------------
;; redo機能
;;-----------------------------------------------------------------
;; tree-undo
(el-get-bundle undo-tree)
(when (require 'undo-tree nil t)
 (global-undo-tree-mode))
(when (require 'redo nil t)
 (define-key ctl-x-map (if window-system "U" "r") 'redo)
 (define-key global-map [?\C-.] 'redo))

;;-----------------------------------------------------------------
;; anything
;;-----------------------------------------------------------------
;(el-get-bundle auto-complete)
;;;(el-get-bundle anything)
;;;(el-get-bundle anything-complete)
;(require 'anything-complete)
;(require 'anything-gtags)
;(require 'anything-config)
;(setq anything-sources
;      (list
;            anything-c-source-buffers
;            anything-c-source-file-name-history
;            anything-c-source-bookmarks
;            anything-c-source-man-pages
;            anything-c-source-info-pages
;            anything-c-source-calculation-result
;;;            anything-c-source-recentf
;            anything-c-source-locate))
;(define-key anything-map (kbd "C-p") 'anything-previous-line)
;(define-key anything-map (kbd "C-n") 'anything-next-line)
;(define-key anything-map (kbd "C-v") 'anything-next-source)
;(define-key anything-map (kbd "C-z") 'anything-previous-source)
;(global-set-key (kbd "C-x SPC") 'anything)
;(global-set-key (kbd "C-;") 'anything)
;
;;; ac-anything
;(require 'ac-anything)
;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)
;

;;-----------------------------------------------------------------
;; helm
;;-----------------------------------------------------------------
(el-get-bundle helm)
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               helm-source-emacs-commands-history
                               helm-source-emacs-commands
                               )))

(define-key global-map (kbd "C-;") 'helm-mini)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)


(el-get-bundle helm-ag)
(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogrou")
(global-set-key (kbd "C-c s") 'helm-ag)




;;-----------------------------------------------------------------
;; coffee-mode
;;-----------------------------------------------------------------
(el-get-bundle defunkt/coffee-mode)
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;;(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))


;;-----------------------------------------------------------------
;; javascript-mode
;;-----------------------------------------------------------------
(el-get-bundle js2-mode)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;-----------------------------------------------------------------
;; json-mode
;;-----------------------------------------------------------------
(el-get-bundle json-mode)


;====================================
;; jade and stylus
;====================================
(el-get-bundle jade-mode)
(el-get-bundle stylus-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))



;;(el-get-bundle less-css-mode)
;;(el-get-bundle markdown-mode)



;;-----------------------------------------------------------------
;; typescript-mode
;;-----------------------------------------------------------------
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tide)
(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode t)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode t)
            (company-mode-on)))

(require 'company)
            ;;; C-n, C-pで補完候補を選べるように
            (define-key company-active-map (kbd "M-n") nil)
            (define-key company-active-map (kbd "M-p") nil)
            (define-key company-active-map (kbd "C-n") 'company-select-next)
            (define-key company-active-map (kbd "C-p") 'company-select-previous)
            ;;; C-hがデフォルトでドキュメント表示にmapされているので、文字を消せるようにmapを外す
            (define-key company-active-map (kbd "C-h") nil)
            ;;; 1つしか候補がなかったらtabで補完、複数候補があればtabで次の候補へ行くように
            (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
            ;;; ドキュメント表示
            (define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)

            (setq company-minimum-prefix-length 1) ;; 1文字入力で補完されるように
             ;;; 候補の一番上でselect-previousしたら一番下に、一番下でselect-nextしたら一番上に行くように
            (setq company-selection-wrap-around t)

            ;;; 色の設定。出来るだけ奇抜にならないように
            (set-face-attribute 'company-tooltip nil
                                :foreground "black"
                                :background "lightgray")
            (set-face-attribute 'company-preview-common nil
                                :foreground "dark gray"
                                :background "black"
                                :underline t)
            (set-face-attribute 'company-tooltip-selection nil
                                :background "steelblue"
                                :foreground "white")
            (set-face-attribute 'company-tooltip-common nil
                                :foreground "black"
                                :underline t)
            (set-face-attribute 'company-tooltip-common-selection nil
                                :foreground "white"
                                :background "steelblue"
                                :underline t)
            (set-face-attribute 'company-tooltip-annotation nil
                                :foreground "red")
(put 'set-goal-column 'disabled nil)


;;-----------------------------------------------------------------
;; markdown-mode
;;-----------------------------------------------------------------
(el-get-bundle markdown-mode)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
