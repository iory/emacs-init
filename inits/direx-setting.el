;;popwin
(require 'popwin)
;;(popwin-mode 1)
;;(setq display-buffer-function 'popwin:display-buffer)
(setq special-display-function 'popwin:special-display-popup-window)

;; direx-el
;;(use popwin-el devloper ver.)
;; https://github.com/m2ym/direx-el
(require 'direx)
(setq direx:leaf-icon "  "
      direx:open-icon "▾ "
      direx:closed-icon "▸ ")

(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-;") 'neotree)
1
