;;; poewrline setting
(require 'powerline)
(set-face-attribute 'mode-line nil
                    :foreground "#000"
                    :background "#99FF33"
                    :box nil)

(set-face-attribute 'powerline-active1 nil
                    :foreground "#fff"
                    :background "#222222"
                    :inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
                    :foreground "#fff"
                    :background "#555555"
                    :inherit 'mode-line)

(powerline-default-theme)

(provide 'powerline-setting)
