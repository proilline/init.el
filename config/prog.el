;; programming related settings

(leaf eglot
  :bind
  (:eglot-mode-map
   ("M-s a"   . eglot-code-actions)
   ("M-s f a" . eglot-format-buffer)
   ("M-s h" . eldoc-doc-buffer)
   ("M-s r"   . eglot-rename))
  :setq
  ;; inlay-hints-mode has so terrible visual, so i temporarily disable it
  (eglot-inlay-hints-mode . nil))


(leaf rust-mode
  :straight t)
