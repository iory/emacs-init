;; auto-complete setting

(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-modes (append ac-modes '(objc-mode)))

(require 'auto-complete-clang-async)
(require 'auto-complete-c-headers)

(add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))

(defun ac-cc-mode-setup ()
  ;; (setq ac-auto-start t)
  (setq ac-clang-complete-executable (expand-file-name "~/.emacs.d/bin/clang-complete"))
  (setq ac-sources (append '(ac-source-clang-async) ac-sources))
  (setq ac-clang-cflags (append '("-std=c++1y") ac-clang-cflags))
  (ac-clang-launch-completion-process))
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)

(global-set-key "\M-/" 'ac-start)
;; C-n/C-p で候補を選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; add C-v in ac-complete-mode-map
(defun ac-next-page ()
  "Select next candidate."
  (interactive)
  (when (ac-menu-live-p)
    (when (popup-hidden-p ac-menu)
      (ac-show-menu))
    (dotimes (i 10) (popup-next ac-menu))
    (if (eq this-command 'ac-next)
        (setq ac-dwim-enable t))))

(defun ac-previous-page ()
  "Select previous candidate."
  (interactive)
  (when (ac-menu-live-p)
    (when (popup-hidden-p ac-menu)
      (ac-show-menu))
    (dotimes (i 10) (popup-previous ac-menu))
    (if (eq this-command 'ac-previous)
        (setq ac-dwim-enable t))))

(define-key ac-complete-mode-map "\C-v" 'ac-next-page)
(define-key ac-complete-mode-map "\M-v" 'ac-previous-page)

(setq ac-quick-help-delay 0.1)
(setq ac-auto-show-menu 0.2)
(global-auto-complete-mode t)


(provide 'auto-complete-setting)
