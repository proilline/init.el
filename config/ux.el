;; some ux-related settings
;;
(leaf vertico
  :straight t
  :require t
  :init
  (vertico-mode)
  :bind (vertico-map
	 ("C-j" . vertico-next)
	 ("C-k" . vertico-previous)))

(leaf corfu
  :straight t
  :require t
  :setq
  ((corfu-cycle . t)
   (corfu-auto  . nil))
  :hook
  (prog-mode-hook text-mode-hook
		  . corfu-mode)
  :bind
  (corfu-map
   ("TAB" . corfu-next)
   ([tab] . corfu-next)
   ("C-j" . corfu-next)
   ("C-k" . corfu-previous)))
(leaf popper
  :straight t
  :require t
  
  :config
  (popper-mode +1)
  (popper-echo-mode +1)
  
  :setq
  ((popper-reference-buffers
    . '("\\*Messages\\*"
	"Ouptput\\*$"
	"\\*Warnigns\\*"
	"\\*Async Shell Command\\*"
	".*eshell\\*$" eshell-mode
	"\\*xref\\*"
	"^\\*eldoc.*\\*$"
	help-mode
	compilation-mode)))
  :bind
  ("M-c" . popper-cycle)
  ("M-`" . popper-toggle-latest))

(leaf orderless
  :require t
  :straight t
  :custom
  (completion-styles . '(orderless basic))
  (completion-category-overrieds
   . '((file (styles basic partial-completion)))))


(leaf ace-window
  :straight t
  :setq
  (aw-keys . '(?h ?j ?k ?l))
  :bind
  ("M-o" . ace-window))
