;; proilline's personal emacs settings

;; load config files

(load-file "~/.emacs.d/config/core.el")
(load-file "~/.emacs.d/config/edit.el")
(load-file "~/.emacs.d/config/theme.el")
(load-file "~/.emacs.d/config/project.el")
(load-file "~/.emacs.d/config/ux.el")
(load-file "~/.emacs.d/config/prog.el")

;; make missing dir automatically when find-file
(defun er-auto-create-missing-dirs ()
  (let ((target-dir (file-name-directory buffer-file-name)))
    (unless (file-exists-p target-dir)
      (make-directory target-dir t))))

(add-to-list 'find-file-not-found-functions #'er-auto-create-missing-dirs)

(leaf dirvish
  :straight t
  :init
  (dirvish-override-dired-mode)
  :bind
  (:dirvish-mode-map
   ("a" . dirvish-quick-access)
   ("i" . dirvish-file-info-menu)
   ("v" . dirvish-vc-menu)
   ("TAB" . dirvish-subtree-toggle)
   ("h" . dired-up-directory)
   ("l" . dired-find-file)))

(leaf dashboard
  :straight t
  :init
  (dashboard-setup-startup-hook)
  :setq
  (dashboard-projects-backend . 'project-el)
  (dashboard-items . '((recents . 5)
		       (bookmarks . 5)
		       (projects . 5)
		       (registers . 5)))
  (dashboard-show-shortcuts . "jump"))

(setq default-input-method "korean-hangul")
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

(leaf vterm
  :straight t
  :require t)

(leaf markdown-mode
  :straight t
  :require t)

(leaf flymake-diagnostic-at-point
  :straight t
  :after flymake
  :hook
  (flymake-mode-hook . flymake-diagnostic-at-point-mode))

(leaf cmake-mode
  :straight t)

(fset 'yes-or-no-p 'y-or-n-p) ;; yes-or-no to y-or-n

(leaf super-save
  :straight t
  :config
  (super-save-mode +1))

(leaf savehist
  :straight t
  :init
  (savehist-mode))

(leaf tempel
  :straight t
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
		(cons #'tempel-expand
		      completion-at-point-functions)))
  :hook
  (prog-mode-hook . tempel-setup-capf)
  (text-mode-hook . tempel-setup-capf)
  :bind
  ("M-n" . tempel-insert)
  ("M-j" . forward-paragraph)
  ("M-k" . backward-paragraph))

(leaf tempel-collection
  :straight t
  :after tempel)

(leaf ocamlformat
  :straight t
  :custom (ocamlformat-enable . 'enable-outside-detected-project)
  :hook (before-save-hook . ocamlformat-before-save))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-kept-versions 0))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.)
)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
