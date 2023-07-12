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
  :straight t
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
  ;;

(leaf meow
  :straight t
  :require t
  :config
  (meow-setup)
  (meow-global-mode 1))

(leaf rainbow-delimiters
  :straight t
  :hook
  (prog-mode-hook . rainbow-delimiters-mode))

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
  :straight t
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
  :straight t
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
  :straight t
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
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  
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
			     embark-target-flymake-at-point
			     embark-target-smerge-at-point
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

(leaf embark-consult
  :straight t
  :hook
  (embark-collect-mode-hook . consult-preview-at-point-mode))


;; for vertico completion
;; Not well tested, but it just work

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
