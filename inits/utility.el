;; Makefile-mode
(setq auto-mode-alist
      (append '(("Makefile\\..*$" . makefile-gmake-mode)
		("Makefile_.*$" . makefile-gmake-mode)
		) auto-mode-alist))
;; cmake
;; (require 'cmake-project)

;; cmake-mode
(require 'cmake-mode)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)

(setq auto-mode-alist
      (cons (cons "\\.launch" 'xml-mode) auto-mode-alist))

;; C++ style
(defun add-c++-mode-conf ()
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0)
  (show-paren-mode t))
(add-hook 'c++-mode-hook 'add-c++-mode-conf)

;; C style
(defun add-c-mode-common-conf ()
  (c-set-style "stroustrup")
  (show-paren-mode t)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'arglist-close 0))
(add-hook 'c-mode-common-hook 'add-c-mode-common-conf)

(provide 'utility)
