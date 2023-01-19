(leaf doom-themes
  :straight t
  :setq
  ((doom-themes-enable-bold . t)
   (doom-themes-enable-italic . t))
  
  :config
  (load-theme 'doom-opera-light t)
  (doom-themes-org-config))

(leaf doom-modeline
  :straight t
  :require t
  :setq
  ((doom-modeline-icon . nil)
   (doom-modeline-gnus . nil))
  :config
  (doom-modeline-mode 1))

