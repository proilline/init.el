(leaf cus-start
  :doc "define customization properties of builtins"
  :custom ((menu-bar-mode . nil)
	   (tool-bar-mode . nil)
	   (scroll-bar-mode . nil)
	   
	   (prefer-codig-system . 'utf-8)
	   (read-process-output-max . 1048576)
	   (inhibit-compacting-font-caches . t)
	   (completion-cycle-threshold . 2)
	   (tab-always-indent . 'complete)
	   (minibuffer-prompt-properties
	    . '(read-only t
			  cursor-intangible t
			  face minibuffer-prompt))
	   
	   (make-backup-files . nil))

  :hook ((prog-mode-hook text-smode-hook
			 . display-line-numbers-mode)
	 (prog-mode-hook text-mode-hook . electric-pair-mode)
	 (minibuffer-setup-hook . cursor-intangible-mode))
  :advice
  (:filter-args completing-read-multipe crm-indicator)
  
  :bind
  ("C-x b"   . 'ibuffer))

(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
		(replace-regexp-in-string
		 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		 crm-separator)
		(car args))
	(cdr args)))

(add-to-list 'default-frame-alist '(font . "monospace-16"))
(set-face-attribute 'default nil
		     :family "monospace-16")
(set-frame-font "monospace-16" nil t)

(defun set-exec-path-from-shell-PATH ()
  ;; read PATH from login shell
  ;; because emacs coudln't read some PATH
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(leaf gcmh
  :require t
  :init
  (gcmh-mode 1)
  :setq
  (gcmh-high-cons-threshold . 100000000) ;; 100mb
  (gcmh-low-cons-threshold . 10000000)) ;; 10mb
(defun er-auto-create-missing-dirs ()
  (let ((target-dir (file-name-directory buffer-file-name)))
    (unless (file-exists-p target-dir)
      (make-directory target-dir t))))

(add-to-list 'find-file-not-found-functions #'er-auto-create-missing-dirs)

(leaf dirvish
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
  :init
  (dashboard-setup-startup-hook)
  :require t
  :setq
  (dashboard-projects-backend . 'project-el)
  (dashboard-items . '((recents . 5)
		       (bookmarks . 5)
		       (projects . 5)
		       (registers . 5)))
  (dashboard-show-shortcuts . "jump")
  (dashboard-banner-logo-title . "It's time to start hacking")
  (dashboard-startup-banner . 3)
  (dashboard-icon-type . 'all-the-icons))

(setq default-input-method "korean-hangul")
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

(leaf markdown-mode
  :require t)

;;(leaf flymake-diagnostic-at-point
;;  :after flymake
;;  :hook
;;  (flymake-mode-hook . flymake-diagnostic-at-point-mode))

(fset 'yes-or-no-p 'y-or-n-p) ;; yes-or-no to y-or-n

(leaf super-save
  :config
(super-save-mode +1))

(leaf savehist
  :init
  (savehist-mode))

(defun meow-backward-find ()
  (interactive)
  (let ((current-prefix-arg -1))
    (call-interactively 'meow-find)))
(defun meow-backward-till ()
  (interactive)
  (let ((current-prefix-arg -1))
    (call-interactively 'meow-till)))

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("/" . meow-visit)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   '("s" . "M-+")
   '("p" . "M-p")
   ;; Use SPC (0-9) for digit arguments.

   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . consult-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . vundo)
   '("v" . meow-right-expand)
   '("/" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . consult-goto-line)
   '(":" . consult-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("F" . meow-backward-find)
   '("T" . meow-backward-till)
   '("<escape>" . ignore)))

(leaf vundo
  :require t
  :bind
  (:vundo-mode-map
   ("l" . vundo-forward)
   ("h" . vundo-backward)
   ("k" . vundo-previous)
   ("j" . vundo-next))
  :setq
  (vundo-compact-display . t))

;; it only tested for korean keyboards
(leaf mule
  :config
  (defun activate-input-method-internal ()
    (let ((prev-input-method current-input-method))
      (setq-local current-input-method nil)
      (activate-input-method prev-input-method)))
  
  ;; deactivate the input method's functionality
  (defun deactivate-input-method-internal ()
    (let ((deactivated-input-method current-input-method)
	  (deactivated-input-method-title current-input-method-title))
      (deactivate-input-method)
      (setq-local current-input-method deactivated-input-method)
      (setq-local current-input-method-title deactivated-input-method-title)))
  
  ;; only activated at insert mode
  (defun input-method-activate-guard ()
    (when (not (or (meow-insert-mode-p)
		    (meow-motion-mode-p)
		    (minibufferp)))
      (deactivate-input-method-internal)))
  :hook
  (meow-insert-exit-hook . deactivate-input-method-internal)
  (meow-insert-enter-hook . activate-input-method-internal)
  (input-method-activate-hook . input-method-activate-guard))

(leaf meow
  :require t
  :config
  (meow-setup)
  (meow-global-mode 1))

(advice-add #'hangul2-input-method-internal :before
	    (lambda (&rest args)
	      (run-hooks 'hangul-insert-before-hook)))

(advice-add #'hangul2-input-method-internal :after
	    (lambda (&rest args)
	      (run-hooks 'hangul-insert-after-hook)))

(advice-add #'vertico--setup :after
	    (lambda (&rest args)
	      (add-hook 'hangul-insert-before-hook
			#'vertico--prepare nil 'local)
	      (add-hook 'hangul-insert-after-hook
			#'vertico--exhibit nil 'local)))

(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

(leaf doom-themes
  :setq
  ((doom-themes-enable-bold . nil)
   (doom-themes-enable-italic . t))
  
  :config
  (load-theme 'doom-tomorrow-day t)
  (doom-themes-org-config))

(leaf doom-modeline
  :require t
  :setq
  ((doom-modeline-gnus . nil))
  :config
  (doom-modeline-mode 1))

(defun consult-ripgrep-region (&optional dir given-initial)
  (interactive)
  (let ((initial
	 (if (use-region-p)
	     (buffer-substring-no-properties
	      (region-beginning)
	      (region-end)) given-initial)))
    (meow--cancel-selection)
    (consult-ripgrep dir initial)))

(defun consult-line-region (&optional given-initial given-start)
  (interactive)
  (let ((initial
	 (if (use-region-p)
	     (buffer-substring-no-properties
	      (region-beginning)
	      (region-end)) given-initial)))
    (meow--cancel-selection)
    (consult-line initial given-start)))

(leaf consult
  :setq
  (xref-show-xrefs-function . #'consult-xref)
  (xref-show-definitions-function . #'consult-xref)
  :config
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep)

  :bind
  (("M-y" . consult-yank-pop)
   ("M-+ f" . consult-ripgrep-region)
   ("M-+ l" . consult-line-region)
   ("C-x C-b" . consult-buffer)))

(leaf marginalia
  :init
  (marginalia-mode))


(defun sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (when (file-writable-p file)
    (user-error "File is user writeable, aborting sudo"))
  (find-file (if (file-remote-p file)
                 (concat "/" (file-remote-p file 'method) ":"
                         (file-remote-p file 'user) "@" (file-remote-p file 'host)
                         "|sudo:root@"
                         (file-remote-p file 'host) ":" (file-remote-p file 'localname))
               (concat "/sudo:root@localhost:" file))))

(leaf embark
  :bind
  (("M-SPC" . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :setq
  (prefix-help-command . #'embark-prefix-help-command)

  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  
  :custom
  (embark-keymap-alist . '((t . embark-general-map)
			   (file . embark-file-map)
			   (buffer . embark-buffer-map)
			   (bookmark . embark-bookmark-map)
			   (url . embark-url-map)
			   (package . embark-package-map)))
  
  (embark-target-finders . '(embark--vertico-selected
			     embark-target-top-minibuffer-completion
			     embark-target-active-region
			     embark-target-collect-candidate
			     embark-target-completion-at-point
			     embark-target-bug-reference-at-point
			     embark-target-package-at-point
			     embark-target-email-at-point
			     embark-target-url-at-point
			     embark-target-file-at-point))
  :bind
  (:embark-general-map
   ("i" . nil)
   ("w" . nil)
   ("C-r" . nil)
   ("C-s" . nil)
   ("y" . embark-copy-as-kill)
   ("s" . consult-line)
   ("f" . consult-ripgrep))
  (:embark-file-map
   ("s" . sudo-find-file)))

(leaf vertico
  :require t
  :init
  (vertico-mode)
  :bind (:vertico-map
	 ("C-j" . vertico-next)
	 ("C-k" . vertico-previous)))

(leaf corfu
  :require t
  :setq
  ((corfu-cycle . t)
   (corfu-auto  . nil))
  :config
  (advice-add 'eglot-completion-at-point
	      :around #'cape-wrap-buster)
  (global-corfu-mode)
  :bind
  (corfu-map
   ("TAB" . corfu-next)
   ([tab] . corfu-next)
   ("C-j" . corfu-next)
   ("C-k" . corfu-previous)))

(leaf eglot
  :config
  (defun my/eglot-capf ()
    (setq-local completion-at-point-functions
		(list (cape-super-capf
                       #'eglot-completion-at-point
                       #'cape-file))))
  :hook (eglot-managed-mode-hook . my/eglot-capf))

(leaf cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-abbrev))


(leaf popper
  :require t
  :config
  (popper-mode +1)
  (popper-echo-mode +1)
  
  :setq
  ((popper-reference-buffers
    . '("\\*Messages\\*"
	"Ouptput\\*$"
	"Repl\\*$"
	"^\\*Guix"
	"\\*Warnings\\*"
	"\\*Async Shell Command\\*"
	".*eshell\\*$" eshell-mode
	".*shell\\*$" shell-mode
	".*vterm\\*$" vterm-mode
	"\\*xref\\*"
	"^\\*eldoc.*\\*$"
	"^\\*Man.*$"
	"\\*Embark.*\\*"
	"\\*OCaml.*\\*"
	help-mode
	compilation-mode)))
  :bind
  ("M-c" . popper-cycle)
  ("M-`" . popper-toggle-latest))

(leaf orderless
  :require t
  :custom
  (completion-styles . '(orderless basic))
  (completion-category-overrieds
   . '((file (styles basic partial-completion)))))

(leaf ace-window
  :setq
  (aw-keys . '(?h ?j ?k ?l))
  :bind
  ("M-o" . ace-window))

(leaf project
  :require
  :setq
  :bind
  (("M-p C-p" . project-switch-project)
  ("M-p C-b"  . consult-project-buffer)
  ("M-p C-f"  . project-find-file)
  ("M-p C-k"  . project-kill-buffers)))

(leaf emacs-guix
  :hook
  (dired-mode-hook shell-mode-hook . guix-prettify-mode)
  (shell-mode-hook . guix-build-log-minor-mode)
  :bind
  ("s-g" . guix))

(leaf geiser
  :config
  (remove-hook 'scheme-mode-hook 'geiser-mode--maybe-activate)
  :hook
  (scheme-mode-hook . geiser-mode))

(custom-set-variables
 '(dired-kept-versions 0))

(leaf direnv
  :init
  (direnv-mode))


