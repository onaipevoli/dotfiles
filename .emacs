(when (eq window-system 'w32)
;;;;;;;;;;;; Only For Windows Start ;;;;;;;;;;;;;;
  ;;;; Setups for subprograms with Cygwin;;;;
  (setq exec-path '("c:cygwin64/bin" "c:/emacs-24.2-20121208/bin/"))
  (setenv "PATH" "/cygdrive/c/cygwin64/bin/:/cygdrive/c/emacs-24.2-20121208/bin/:")
  (setq eshell-path-env "c:cygwin64/bin;c:/emacs-24.2-20121208/bin/")

  (setenv "LANG" "C")
  (setenv "LC_CTYPE" "ja_JP.utf8")

  ;;IME Configuration
  (setq default-input-method "W32-IME")
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (w32-ime-initialize)

  ;;Hide mouse cursole on the Emacs window
  (setq w32-hide-mouse-on-key t)
  (setq w32-hide-mouse-timeout 5000)

  ;;Don't display Tool bar
  (tool-bar-mode -1)
  (menu-bar-mode 0)

  ;;Display japanese inline with isearch
  (defun w32-isearch-update ()
    (interactive)
    (isearch-update))
  (define-key isearch-mode-map [compend] 'w32-isearch-update)
  (define-key isearch-mode-map [kanji] 'isearch-toggle-input-method)

  (add-hook 'isearch-mode-hook
            (lambda () (setq w32-ime-composition-window (minibuffer-window))))
  (add-hook 'isearch-mode-end-hook
            (lambda () (setq w32-ime-composition-window nil)))
  ;;;; Initial frame ;;;;
  (setq default-frame-alist
        (append (list '(foreground-color . "black")
                      '(background-color . "LemonChiffon")
                      '(background-color . "gray")
                      '(border-color . "black")
                      '(mouse-color . "white")
                      '(cursor-color . "black")
                      '(width . 84)
                      '(height . 43)
                      '(top . 0)
                      '(left . 640))
                default-frame-alist)))

;;;; Load Path ;;;;
(setq load-path (append (list (expand-file-name "~/elisp/")) load-path))


;;Shell
(setq explicit-shell-file-name "bash")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

(setq ispell-grep-command "grep")

; Grep mode to use /dev/null instead of nul
(setq null-device "/dev/null")


;;;; Key configuratoin ;;;;
(load "term/bobcat")
(terminal-init-bobcat)

(global-unset-key [\C-backspace])
(global-unset-key "\C-x\C-c")
(global-set-key "\C-x\C-c\C-c" `save-buffers-kill-terminal)

;; One line scroll
(global-set-key "\M-n" (lambda() (interactive) (scroll-up 1) (next-line 1)))
(global-set-key "\M-p" (lambda() (interactive) (scroll-down 1) (previous-line 1)))

;; Follow link without question
(setq vc-follow-symlinks t)

;;;; font-lock ;;;;
;; (when (fboundp 'global-font-lock-mode)
;;   (global-font-lock-mode t))
;;Colors for black background
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-string-face "purple")
(set-face-foreground 'font-lock-variable-name-face "magenta")

;;;; Verilog-mode ;;;;
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))
(setq verilog-indent-level 2)
(setq verilog-indent-level-module 2)
(setq verilog-indent-level-declaration 2)
(setq verilog-indent-level-behavioral 2)
(setq verilog-auto-endcomments nil)
(setq verilog-auto-newline nil)
;;(setq verilog-tab-always-indent nil)
(setq verilog-tab-always-indent t)
(setq verilog-auto-indent-on-newline nil)
(setq verilog-linter "make")

;;;; vhdl-mode ;;;;
(add-to-list `auto-mode-alist '("\\.vhdm" . vhdl-mode))
(setq vhdl-end-comment-column 300)
(setq vhdl-electric-mode nil)
(setq vhdl-stutter-mode nil)
(setq vhdl-intelligent-tab nil)

;;EDIFF
(setq ediff-ignore-similar-regions t)

;;Color whitespaces
;;Only tabs are colored
;(global-whitespace-mode 1)
(setq whitespace-style '(face tabs trailing))
;(setq whitespace-style '(face tabs))



;;;; Shorten vc-annotate output ;;;;;
(defadvice vc-git-annotate-command (around vc-git-annotate-command activate)
  "suppress relative path of file from git blame output"
  (let ((name (file-relative-name file)))
    (vc-git-command buf 'async nil "blame" "--date=iso" rev "--" name)))


;;;; Packge System ;;;;
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;;; Recentf ;;;;;
(setq recentf-max-saved-items 100)

;;;; Anything ;;;;
(require 'anything-startup)


;;;; Process escape sequence ;;;;
(require `ansi-color)
(defun display-ansi-color ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))


;;;; MISC ;;;;
;;Don't automaticaly split buffer vertical. Disable the feature from EMACS 23
(setq split-width-threshold nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tcl-indent-level 2)
(setq tcl-continued-indent-level 2)
(setq-default indent-tabs-mode nil)
(setq ring-bell-function 'ignore)
(setq trancate-lines nil)
(setq make-backup-files nil)
(setq grep-command "grep -nHi -e ")
(setq completion-ignore-case t)
(setq diff-switches "-u")
(put 'narrow-to-region 'disabled nil)
(setq next-line-add-newlines nil)
(setq-default indent-tabs-mode nil)
(show-paren-mode t)
(put 'set-goal-column 'disabled nil)
(setq large-file-warning-threshold 100000000)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anything-ff-file ((t (:foreground "blue" :underline nil))))
 '(compilation-info ((t (:foreground "green")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
