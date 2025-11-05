(defvar bootstrap-version)
(let ((bootstrap-file
       (locate-user-emacs-file "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq vc-follow-symlinks t)

(setq straight-vc-git-default-clone-depth 1)

(straight-use-package 'use-package)
(use-package straight
  :custom (straight-use-package-by-default t)
  :bind  (("C-<f2>" . hydra-straight-helper/body)))

;;; Provide
(provide 'marcom-straight)
;;; marcom-straight.el ends here
