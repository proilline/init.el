;; proilline's personal emacs settings

;; load config files

(load-file "~/.emacs.d/config/core.el")
(load-file "~/.emacs.d/config/edit.el")
(load-file "~/.emacs.d/config/theme.el")
(load-file "~/.emacs.d/config/project.el")
(load-file "~/.emacs.d/config/ux.el")
(load-file "~/.emacs.d/config/prog.el")

;; TODO : edit kemap setting
(leaf dired-x
  :setq ((dired-omit-mode . 1)
	 (dired-omit-files . "^\\..*$") ;; hide dotfiles
	 (dired-recursive-copies 'top)
	 (dired-recursive-deletes 'top))
  :require t
  :after dired
  :bind (dired-mode-map
	 ("C-A" . dired-omit-mode)))

