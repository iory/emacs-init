;; git setting
(require 'magit)
(global-set-key (kbd "M-m") 'magit-status)
(global-set-key (kbd "C-x m") 'magit-status) ;; don't use email on emacs
(global-set-key (kbd "C-x v d") 'magit-status)
(global-set-key (kbd "C-x v l") 'magit-key-mode-popup-logging)

;; git gutter setting
(require 'git-gutter)

;; If you enable global minor mode
(global-git-gutter-mode t)

;; If you would like to use git-gutter.el and linum-mode
(git-gutter:linum-setup)

;; If you enable git-gutter-mode for some modes
(add-hook 'ruby-mode-hook 'git-gutter-mode)

(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x C-p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x C-n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(setq magit-last-seen-setup-instructions "1.4.0")

;; github-browse-file
(require 'github-browse-file)
(setq github-browse-file-show-line-at-point t)

(provide 'git-setting)
