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
    gitconfig-mode
    gitignore-mode
    git-gutter
    helm
    helm-swoop
    helm-migemo
    helm-ag
    helm-cmd-t
    howdoi
    hiwin
    haskell-mode
    jedi
    lispxmp
    magit
    markdown-mode
    migemo
    mwim
    neotree
    open-junk-file
    popwin
    powerline
    powerline-evil
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
(load "~/.emacs.d/site-lisp-path.el")

(load "~/.emacs.d/inits/any-setting.el")
(load "~/.emacs.d/inits/auto-complete-setting.el")
(load "~/.emacs.d/inits/common.el")
(load "~/.emacs.d/inits/direx-setting.el")
(load "~/.emacs.d/inits/git-setting.el")
(load "~/.emacs.d/inits/helm-setting.el")
(load "~/.emacs.d/inits/insert-setting.el")
(load "~/.emacs.d/inits/markdown-setting.el")
(load "~/.emacs.d/inits/python-setting.el")
(load "~/.emacs.d/inits/powerline-setting.el")
(load "~/.emacs.d/inits/quickrun-setting.el")
;;(load "~/.emacs.d/inits/ruby-setting.el")
(load "~/.emacs.d/inits/server-setting.el")
(load "~/.emacs.d/inits/tools.el")
(load "~/.emacs.d/inits/trr-setting.el")
;;(load "~/.emacs.d/inits/tab-setting.el")
(load "~/.emacs.d/inits/utility.el")
(load "~/.emacs.d/inits/yasnippet-setting.el")

;; using ROS on Ubuntu
(when (eq system-type 'gnu/linux)
  (load "~/.emacs.d/inits/ros-setting.el")
  (load "~/.emacs.d/inits/mozc-setting.el"))
