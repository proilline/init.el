;; proilline's personal emacs settings

;; load config files

(load-file "~/.emacs.d/config/core.el")
(load-file "~/.emacs.d/config/edit.el")
(load-file "~/.emacs.d/config/theme.el")
(load-file "~/.emacs.d/config/project.el")
(load-file "~/.emacs.d/config/ux.el")
(load-file "~/.emacs.d/config/prog.el")

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

(leaf dirvish
  :straight t
  :init
  (dirvish-override-dired-mode)
  :setq
  (dired-listing-switches
   . "-l --almost-all --human-readable --group-directory-first --no-group")
  :bind
  (:dirvish-mode-map
   ("a" . dirvish-quick-access)
   ("i" . dirvish-file-info-menu)
   ("v" . dirvish-vc-menu)
   ("TAB" . dirvish-subtree-toggle)
   ))

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
