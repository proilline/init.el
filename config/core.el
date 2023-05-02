;; core.el
;;

;; straight.el, leaf.el, and some builtin settings here.

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'leaf)
(straight-use-package 'leaf-keywords)
(leaf leaf-keywords
      :config
      (leaf-keywords-init))

(leaf cus-start
  :doc "define customization properties of builtins"
  :custom ((menu-bar-mode . nil)
	   (tool-bar-mode . nil)
	   (scroll-bar-mode . nil)
	   
	   (prefer-codig-system . 'utf-8)
	   (read-process-output-max . 1048576)
	   
	   (completion-cycle-threshold . 2)
	   (tab-always-indent . 'complete)
	   (inhibit-compacting-font-caches . t)
	   (minibuffer-prompt-properties
	    . '(read-only t cursor-intangible t face minibuffer-prompt))
	   
	   (make-backup-files . nil))

  :hook ((prog-mode-hook text-smode-hook . display-line-numbers-mode)
	 (prog-mode-hook text-mode-hook . electric-pair-mode)
	 (minibuffer-setup-hook . cursor-intangible-mode))
  
  :advice
  (:filter-args completing-read-multipe crm-indicator) ;; settings for vertico
  
  :bind
  ("M-SPC"   . async-shell-command)
  ("C-x b"   . 'ibuffer))

(add-to-list 'default-frame-alist '(font . "iosevka-16"))
(set-face-attribute 'default nil
		    :family "iosevka-16")
(set-frame-font "iosevka-16" nil t)

(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
		(replace-regexp-in-string
		 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		 crm-separator)
		(car args))
	(cdr args)))

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
  :straight t
  :init
  (gcmh-mode 1)
  :setq
  (gcmh-high-cons-threshold . 100000000) ;; 100mb
  (gcmh-low-cons-threshold . 10000000)) ;; 10mb
