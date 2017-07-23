;;; Setting of package manager
(require 'package)
;; Add MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Add MELPA-stable
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Add Marmalade
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Add Org
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; Initialize
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 1)
 '(package-selected-packages
   (quote
    (js3-mode apib-mode flycheck-rust rust-mode company-quickhelp company smooth-scrolling man-commands markdown-mode git-gutter magit helm jedi go-mode flymake-jslint flycheck buffer-move yascroll elscreen popwin pos-tip fuzzy auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; open new buffer as elip mode
(setq default-major-mode 'lisp-interaction-mode)


;;; Toogle Truncate Line
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;;; Disabling menu bar and tool bar
(menu-bar-mode 0)
(tool-bar-mode 0)
;;; Disabling backup file
(setq make-backup-files nil)

;;; color theme
(load-theme 'deeper-blue t)

;;; Window Transparency
(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))
(set-alpha 85)

;;; smooth-scrolling
(smooth-scrolling-mode t)

;;; mouse setting
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;;; Golang settings
(setenv "GOPATH" "/Users/satoshi/go")
(add-to-list 'exec-path (expand-file-name "/Users/satoshi/go/bin"))

(use-package go-mode
  :config
  (bind-keys :map go-mode-map
	     ("C-c j" . godef-jump)
	     ("C-c o" . godef-jump-other-window)
	     ("M-," . pop-tag-mark))
  (add-hook 'go-mode-hook '(lambda () (setq tab-width 2)))
  (add-hook 'go-mode-hook 'flycheck-mode)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package go-eldoc
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))


;;; Markdwon preview setting
;; linking markdown mode (gfm-mode Github flavor markdown mode) with file suffix
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(defun markdown-custom ()
  "markdown-mode-hook"
  (setq markdown-command-needs-filename t)
  )
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))

;; Insert current time on the current buffer
(defun insert-current-time()
  (interactive)
  (insert (format-time-string "%Y-%m-%d(%a) %H:%M:%S" (current-time))))
(define-key global-map "\C-cd" `insert-current-time)

;; Company (auto complete) mode setting
;; Ref: 
;;     - http://qiita.com/syohex/items/8d21d7422f14e9b53b17
;;     - http://qiita.com/sune2/items/b73037f9e85962f5afb7
(global-company-mode 1)

(setq company-idle-delay 0) ; default 0.5
(setq company-minimum-prefix-length 2) ; default 4
(setq company-selection-wrap-around t)

;;; color setting of company mode
(set-face-attribute 'company-tooltip nil :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil :background "orange")
(set-face-attribute 'company-scrollbar-bg nil :background "gray40")
;;; key binding of company mode
(global-set-key (kbd "C-M-i") 'company-complete)
;;;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
;;;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
;;;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
;;;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
;;;; quick help
(company-quickhelp-mode +1)
