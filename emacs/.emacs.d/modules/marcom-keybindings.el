;; Make ESC quit prompts
(use-package general
  ;;:after evil
  :config
  (global-unset-key (kbd "C-SPC"))
  (general-create-definer mb/leader-keys
     ;;:states '(normal insert visual emacs)
     ;;:keymaps 'override
     :prefix "C-SPC"
     :global-prefix "C-SPC")
  (mb/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "m" '(mu4e :which-key "mu4e")
    "f" '(:ignore t :which-key "files")
  "ff" '(counsel-find-file :which-key "find file")
  "fr" '(counsel-recentf :which-key "recent files")
  "fs" '(save-buffer :which-key "save file")
  "b" '(:ignore t :which-key "buffer")
  "bb" '(counsel-switch-buffer :which-key "switch buffer")
  "bk" '(kill-this-buffer :which-key "kill buffer")
  "g" '(:ignore t :which-key "git")
  "gs" '(magit-status :which-key "git status")
  "h" '(:ignore t :which-key "help")
  "hf" '(describe-function :which-key "describe function")
  "hv" '(describe-variable :which-key "describe variable")
  "hk" '(describe-key :which-key "describe key")
  "w" '(:ignore t :which-key "windows")
  "wl" '(windmove-right :which-key "move right")
  "wh" '(windmove-left :which-key "move left")
  "wk" '(windmove-up :which-key "move up")
  "wj" '(windmove-down :which-key "move down")
  "w/" '(split-window-right :which-key "split right")
  "w-" '(split-window-below :which-key "split bottom")
  "wd" '(delete-window :which-key "delete window")
  "p" '(:ignore t :which-key "project")
  "pf" '(projectile-find-file :which-key "find file")
  "ps" '(projectile-switch-project :which-key "switch project")
  "pp" '(projectile-find-file :which-key "find file")
  "o" '(:ignore t :which-key "org")
  "oa" '(org-agenda :which-key "agenda")
  "oc" '(org-capture :which-key "capture")
    "n" '(hydra-mu4e-headers/body :which-key "mu4e-hydra")
    ;"c" '(hydra-org-clock/body :which-key "Clocking")
    "c" '(mb-clocking/body :which-key "Clocking")
    "SPC" '(org-boxes-workflow :which-key "GTD Workflow")
    "v" '(mb-gtd-menue/body :which-key "my menue")
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
