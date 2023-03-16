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

(setq tramp-default-method "ssh")

;; make missing dir automatically when find-file
(defun er-auto-create-missing-dirs ()
  (let ((target-dir (file-name-directory buffer-file-name)))
    (unless (file-exists-p target-dir)
      (make-directory target-dir t))))

(add-to-list 'find-file-not-found-functions #'er-auto-create-missing-dirs)

(leaf tempel
  :straight t
  :init

  (defun tempel-setup-capf()
    (setq-local completion-at-point-functions
		(cons #'tempel-expand
		      completion-at-point-functions)))
  :bind
  (("M-n" . tempel-complete))
  :hook
  ((prog-mode-hook text-mode-hook) . tempel-setup-capf))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying-when-mismatch nil)
 '(dired-kept-versions 0))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
