;;; ros-setting.el --- for ROS on Ubuntu

;; Copyright (C) 2015  iori

;; Author: iori

(add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
(require 'rosemacs-config)
(invoke-rosemacs)

(global-set-key "\C-x\C-r" ros-keymap)

(provide 'ros-setting)
