;; Make ESC quit prompts
(use-package general
  ;;:after evil
  :config
  (general-create-definer mb/leader-keys
     :keymaps '(normal insert visual emacs)
     :prefix "SPC"
     :global-prefix "C-SPC")
  (mb/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "m" '(mu4e :which-key "mu4e")
    "n" '(hydra-mu4e-headers/body :which-key "mu4e-hydra")
    ;"c" '(hydra-org-clock/body :which-key "Clocking")
    "c" '(mb-clocking/body :which-key "Clocking")
    "g" '(org-boxes-workflow :which-key "GTD Workflow")
    "SPC" '(mb-gtd-menue/body :which-key "my menue")
    "e" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/config.org")) :which-key "open config.org")))

;; Use Escape to quit stuff
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Resizing the fonts
(define-key global-map (kbd "s-=") 'text-scale-increase)
(define-key global-map (kbd "s--") 'text-scale-decrease)


;; Emacs-Config on C-c e
(global-set-key "\C-ce" '(lambda ()
                           (interactive)
                           (find-file "~/.emacs.d/config.org")))

;; Tasks-Datei auf C-c g
;;(global-set-key "\C-cg" '(lambda ()
;;                           (interactive)
;;                           (find-file "~/projects/org/tasks.org")))

;; Übersichtsseite auf C-c s
;;(global-set-key "\C-cs" '(lambda ()
;;                           (interactive)
;;                           (find-file "~/projects/org/start.org")))

;;; Provide
(provide 'marcom-keybindings)
;;; marcom-keybindings.el ends here
