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
    dropdown-list
    slime
    smart-newline
    use-package
    helm-swoop
    helm-migemo
    migemo
    evil
    powerline
    powerline-evil
    save-load-path
    mwim
    howdoi
    hiwin
    neotree
    ))

;; automatically install
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))


;; language-setting
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)
(define-key global-map (kbd "C-\\") 'mozc-mode)

(add-to-list 'load-path "~/.emacs.d/elpa/")
(load "~/.emacs.d/site-lisp-path.el")

(load "~/.emacs.d/inits/any-setting.el")
(load "~/.emacs.d/inits/auto-complete-setting.el")
(load "~/.emacs.d/inits/common.el")
(load "~/.emacs.d/inits/direx-setting.el")
(load "~/.emacs.d/inits/git-setting.el")
(load "~/.emacs.d/inits/helm-setting.el")
(load "~/.emacs.d/inits/insert-setting.el")
(load "~/.emacs.d/inits/python-setting.el")
(load "~/.emacs.d/inits/powerline-setting.el")
(load "~/.emacs.d/inits/quickrun-setting.el")
;;(load "~/.emacs.d/inits/ruby-setting.el")
(load "~/.emacs.d/inits/server-setting.el")
(load "~/.emacs.d/inits/trr-setting.el")
;;(load "~/.emacs.d/inits/tab-setting.el")
(load "~/.emacs.d/inits/utility.el")
(load "~/.emacs.d/inits/yasnippet-setting.el")
