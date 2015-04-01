;; helm
(add-to-list 'load-path "~/.emacs.d/site-lisp/helm")
(require 'helm)
(require 'helm-config)
(require 'helm-command)
(require 'helm-mode)
(require 'helm-ls-git)
(require 'helm-config)
(require 'helm-files)
(require 'helm-ag)
;;(require 'helm-descbinds)

;;; key bind
(global-set-key (kbd "C-;") 'helm-for-files)

(defun my-helm ()
  (interactive)
  (helm :sources '(
                   helm-c-source-buffers-list
                   helm-c-source-recentf
                   helm-c-source-files-in-current-dir
                   helm-c-source-mac-spotlight
                   helm-c-source-buffer-not-found)
        :buffer "*my helm*"))
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-samewindow nil)
(push '("*helm-M-x*") popwin:special-display-config)

(global-set-key (kbd "M-y")'helm-show-kill-ring)
(define-key helm-map (kbd "C-j") 'helm-maybe-exit-minibuffer)
;; (define-key helm-map (kbd "M-j") 'helm-select-3rd-action)
;; (global-set-key (kbd "C-c y") 'helm-show-kill-ring)

(helm-mode 1)
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
(add-to-list 'helm-completing-read-handlers-alist '(find-file-at-point . nil))
(add-to-list 'helm-completing-read-handlers-alist '(write-file . nil))
(add-to-list 'helm-completing-read-handlers-alist '(helm-c-yas-complete . nil))
(add-to-list 'helm-completing-read-handlers-alist '(dired-do-copy . nil))
(add-to-list 'helm-completing-read-handlers-alist '(dired-do-rename . nil))
(add-to-list 'helm-completing-read-handlers-alist '(dired-create-directory . nil))

;; maximum candidate number
(setq helm-candidate-number-limit 99999)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; ag
(setq helm-ag-base-command "ag --nocolor --nogroup -n")
(global-set-key (kbd "C-,") 'helm-ag)

;; Emulate `kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

;; helm-recentf
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; helm-git-ls
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

(require 'helm-C-x-b)
(global-set-key (kbd "C-x b") 'helm-C-x-b)


(provide 'helm-setting)
