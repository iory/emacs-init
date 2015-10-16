;; .emacs.d/init.el

(require 'cl)
(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.milkbox.net/packages/")
         ;; '("melpa-stable" . "http://stable.melpa.org/packages/")
         '("marmalade" ."http://marmalade-repo.org/packages/")
         )

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
    ac-cider ;; for clojure
    ac-etags
    ac-haskell-process
    anzu
    cmake-project
    cmake-mode
    clojure-mode ;; for clojure
    cider ;; for clojure
    clojure-cheatsheet ;; for clojure
    direx
    dired-k
    dired-toggle
    dropdown-list
    exec-path-from-shell
    evil
    flymake
    ;; flymake-checkers
    flylisp
    flymake-cppcheck
    flycheck
    flycheck-google-cpplint
    ;; fullscreen-mode
    gitconfig-mode
    gitignore-mode
    git-gutter
    github-browse-file
    go-mode
    go-autocomplete
    helm
    helm-swoop
    helm-migemo
    helm-ag
    helm-cmd-t
    helm-projectile
    helm-gtags
    howdoi
    hiwin
    haskell-mode
    ido-occasional
    ido-vertical-mode
    imenu
    imenus
    ;; ipython
    jedi
    jedi-direx
    lispxmp
    magit
    markdown-mode
    migemo
    mozc
    mwim
    mykie
    open-junk-file
    pcre2el
    popwin
    powerline
    powerline-evil
    projectile
    python-mode
    quickrun
    rainbow-delimiters
    redo+
    save-load-path
    sequential-command
    shell-pop
    smartparens
    smart-newline
    slamhound ;; for clojure
    tabbar
    undo-tree
    undohist
    use-package
    volatile-highlights
    visual-regexp-steroids
    yaml-mode
    dash
    s
    f
    ))

(when (>= emacs-major-version 24)
  (when (>= emacs-minor-version 5)
    (setq installing-package-list
          (append
           installing-package-list
           '(
             w3m
             )))
    )
  )

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
(require 'byte-compile-setting)
(require 'auto-complete-setting)
(require 'common)
(require 'c-setting)
(require 'clojure-setting)
(require 'clipboard-setting)
(require 'direx-setting)
(require 'ediff-setting)
(require 'git-setting)
(require 'go-setting)
;; (require 'haskell-setting)
(require 'helm-setting)
(require 'indent-setting)
(require 'insert-setting)
(require 'markdown-setting)
(require 'python-setting)
(require 'powerline-setting)
(require 'quickrun-setting)
;; (require 'ruby-setting)
(require 'roseus-setting)
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

;; (fullscreen-mode t)
(global-set-key (kbd "C-x m") 'magit-status) ;; don't use email on emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(helm-ff-auto-update-initial-value nil)
 '(safe-local-variable-values (quote ((eval sh-set-shell "zsh") (require-final-newline) (clmemo-mode . t)))))
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (setq shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
(setq shell-pop-shell-type '("shell" "*shell*" (lambda () (shell))))
;; (setq shell-pop-shell-type '("terminal" "*terminal*" (lambda () (term shell-pop-term-shell))))
;; (setq shell-pop-shell-type '("ansi-term" "*ansi-term*" (lambda () (ansi-term shell-pop-term-shell))))
(global-set-key (kbd "C-c s") 'shell-pop)

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
