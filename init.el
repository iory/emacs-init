;; .emacs.d/init.el

(require 'cl)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(global-set-key (kbd "C-x C-c") 'open-junk-file)
;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
(package-initialize)

(defvar installing-package-list
  '(
    ;; package list to use
    auto-complete
    auto-complete-clang-async
    ace-isearch
    anzu
    cmake-project
    cmake-mode
    open-junk-file
    tabbar
    helm
    undo-tree
    smartparens
    popwin
    helm-ag
    redo+
    nav
    volatile-highlights
    lispxmp
    haskell-mode
    yaml-mode
    jedi
    flymake
    flymake-checkers
    flylisp
    flymake-cppcheck
    flycheck
    flycheck-google-cpplint
    direx
    helm-cmd-t
    magit
    git-gutter
    quickrun
    yasnippet
    dropdown-list
    slime
    smart-newline
    powerline
    use-package
    helm-swoop
    helm-migemo
    migemo
    evil
    powerline-evil
    save-load-path
    mwim
    howdoi
    hiwin
    ))

;; automatically install
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/elpa/")

(load "~/.emacs.d/inits/common.el")
(load "~/.emacs.d/inits/tab-setting.el")
(load "~/.emacs.d/inits/direx-setting.el")
(load "~/.emacs.d/inits/helm-setting.el")
(load "~/.emacs.d/inits/server-setting.el")
(load "~/.emacs.d/inits/git-setting.el")
(load "~/.emacs.d/inits/utility.el")
(load "~/.emacs.d/inits/gauche-setting.el")
(load "~/.emacs.d/inits/quickrun-setting.el")
(load "~/.emacs.d/inits/python-setting.el")
;;(load "~/.emacs.d/inits/ruby-setting.el")
(load "~/.emacs.d/inits/auto-complete-setting.el")
(load "~/.emacs.d/inits/any-setting.el")
(load "~/.emacs.d/inits/trr-setting.el")

;; font-setting
;; (set-face-attribute 'default nil
;;                     :family "Ricty"
;;                     :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0212
;;                   (cons "Ricty Discord" "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'katakana-jisx0201
;;                   (cons "Ricty Discord" "iso10646-1"))
