;; popwin
(require 'popwin)
(setq special-display-function 'popwin:special-display-popup-window)

;; direx-el
;;(use popwin-el devloper ver.)
(require 'direx)
(setq direx:leaf-icon "  "
      direx:open-icon "\&#9662; "
      direx:closed-icon "&#9654; ")

(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-;") 'neotree)
