;; .emacs.d/init.el

(require 'cl)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; (global-set-key (kbd "C-x C-c") 'open-junk-file)
;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
(package-initialize)

(defvar installing-package-list
  '(
    ;; package list to use
    auto-async-byte-compile
    auto-complete
    auto-complete-c-headers
    arduino-mode
    ace-isearch
    anzu
    cmake-project
    cmake-mode
    direx
    dropdown-list
    exec-path-from-shell
    evil
    flymake
    flymake-checkers
    flylisp
    flymake-cppcheck
    flycheck
    flycheck-google-cpplint
    fullscreen-mode
    gitconfig-mode
    gitignore-mode
    git-gutter
    github-browse-file
    helm
    helm-swoop
    helm-migemo
    helm-ag
    helm-cmd-t
    helm-projectile
    howdoi
    hiwin
    haskell-mode
    ipython
    jedi
    lispxmp
    magit
    markdown-mode
    migemo
    mwim
    mykie
    neotree
    open-junk-file
    popwin
    powerline
    powerline-evil
    projectile
    python-mode
    quickrun
    redo+
    save-load-path
    sequential-command
    smartparens
    smart-newline
    tabbar
    undo-tree
    undohist
    use-package
    volatile-highlights
    yaml-mode

    dash
    s
    f
    ))

;; automatically install
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

;; path setting
(exec-path-from-shell-initialize)

;; avoid strange character on shell
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
            ))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/inits/")
(load "~/.emacs.d/site-lisp-path.el")

(require 'tools)

(require 'any-setting)
;; (require 'byte-compile-setting)
(require 'auto-complete-setting)
(require 'common)
(require 'c-setting)
(require 'direx-setting)
(require 'ediff-setting)
(require 'git-setting)
(require 'helm-setting)
(require 'indent-setting)
(require 'insert-setting)
(require 'markdown-setting)
(require 'python-setting)
(require 'powerline-setting)
(require 'quickrun-setting)
;; (require 'ruby-setting)
(require 'server-setting)
(require 'sh-setting)
(require 'tex-setting)
(require 'trr-setting)
;; (require 'tab-setting)
(require 'utility)
(require 'yasnippet-setting)

;; using ROS on Ubuntu
(when (eq system-type 'gnu/linux)
  (require 'ros-setting)
  (require 'mozc-setting))

(fullscreen-mode t)
(global-set-key (kbd "C-x m") 'magit-status) ;; don't use email on emacs
