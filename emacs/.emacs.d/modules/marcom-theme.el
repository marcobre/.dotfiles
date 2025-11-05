;; You will most likely need to adjust this font size for your system!
(defvar mb/default-font-size 140)
(defvar mb/default-variable-font-size 140)

;; Font Selection
(set-face-attribute 'default nil :font "Fira Code Retina" :height mb/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height mb/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Fira Code" :height mb/default-variable-font-size :weight 'regular)

(use-package doom-themes
  :init (load-theme 'doom-outrun-electric t)
  :config
    (doom-themes-org-config)
    ;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
    ;(doom-themes-treemacs-config)
    )

(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)
           (doom-themes-neotree-config)))

;;; Provide
(provide 'marcom-theme)
;;; marcom-theme.el ends here
