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
  :config
  (global-corfu-mode)
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
	"\\*Warnings\\*"
	"\\*Async Shell Command\\*"
	".*eshell\\*$" eshell-mode
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


(leaf cape
  :straight t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(leaf which-key
  :straight t
  :setq
  (which-key-use-C-h-commands . t)
  :config
  (which-key-setup-minibuffer)
  (which-key-mode))

