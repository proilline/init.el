;; ------------ project.el ---------
;; built-in project.el settings for personal usage.

(leaf project
  :require
  :setq
  :bind
  (("M-p C-p" . project-switch-project)
  ("M-p C-b"  . consult-project-buffer)
  ("M-p C-f"  . project-find-file)
  ("M-p C-k"  . project-kill-buffers)
  ))

