(use-package which-key
  :straight (:build (:not native-compile))
  :diminish
  :custom
  (which-key-idle-secondary-delay 0.01)
  (which-key-dont-use-unicode t)
  :config
  (which-key-mode t))
;;; Provide
(provide 'marcom-which-key)
;;; marcom-which-key.el ends here
