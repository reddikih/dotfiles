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

;; Update package information
(package-refresh-contents)
;; Packages to install
(defvar my/favorite-packages
  '(
    auto-complete
    fuzzy
    popup
    pos-tip
    popwin
    elscreen
    yascroll
    buffer-move
    flycheck
    flymake-jslint
    jedi
    helm
    magit
    git-gutter
    markdown-mode
    man-commands
    go-mode
    go-eldoc
    use-package
    smooth-scrolling
    nurumacs
    company
    company-quickhelp
    rust-mode
    flycheck-rust
    apib-mode
    js3-mode
    ))

;; my/favorite-packagesからインストールしていないパッケージをインストール
;; Install packages which is not installed speficied in my/favorite-packages
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

