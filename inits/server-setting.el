(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'server-setting)
