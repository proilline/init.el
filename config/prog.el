;; programming related settings

(leaf eglot
  :bind
  (:eglot-mode-map
   ("M-s a"   . eglot-code-actions)
   ("M-s f a" . eglot-format-buffer)
   ("M-s r"   . eglot-rename)))


(leaf rust-mode
  :straight t)
