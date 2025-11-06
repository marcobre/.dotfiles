(use-package vertico
  :init (vertico-mode)
  :config
;;  (require 'vertico-grid)       ;; Beispiel: Grid-Modus für Datei Completion
;;  (vertico-grid-mode 1)
  (require 'vertico-repeat)
  (require 'vertico-directory))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package all-the-icons-completion
  :after (marginalia)
  :init (all-the-icons-completion-mode))
(use-package all-the-icons
  :if (display-graphic-p))

(use-package consult
  :after vertico
  :bind (("C-s" . consult-line)
         ("M-g i" . consult-imenu)))

(use-package embark
  :bind (("C-." . embark-act)
         ("M-." . embark-dwim))
  :init (setq embark-confirm-act-always nil))
(use-package embark-consult
  :after (embark consult))

;;; Provide
(provide 'marcom-vertico)
;;; marcom-vertico.el ends here
