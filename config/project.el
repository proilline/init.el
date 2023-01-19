;; ------------ project.el ---------
;; built-in project.el settings for personal usage.

(leaf project
  :require
  :setq
  :bind
  ("C-x C-p" . project-switch-project))

(defvar projectp-mode-map (make-sparse-keymap)
  "The keymap for projectp-mode")

(define-key projectp-mode-map
	    (kbd "C-x C-b") 'project-switch-to-buffer)
(define-key projectp-mode-map
	    (kbd "C-x C-f") 'project-find-file)
(define-key projectp-mode-map
	    (kbd "M-SPC") 'project-async-shell-command)
(define-key projectp-mode-map
	    (kbd "C-x k") '(project-kill-buffers))
			     

(define-minor-mode projectp-mode
  "trivial minor mode for set keymap"
  :lighter "project+"
  (lambda ()
   (use-local-map projectp-mode-map)
   (run-hooks 'projectp-mode-hook))) ;; hook for future customizing


(defvar projectp-hook nil
  "The hook for projectp-mode")

(add-hook 'find-file-hook
 #'(lambda() (when (project-current) 
     (projectp-mode 1))))

