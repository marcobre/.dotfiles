(use-package deft
;;  :ensure t
  :config 
  (setq deft-directory "~/Syncthing/org/notes/")
  (setq deft-strip-title-regexp "\\(?:^%+\\|^#\\+TITLE: *\\|^#\\+COMMENT: *\\|^[#* ]+\\|-\\*-[[:alpha:]]+-\\*-\\|^Title:[  ]*\\|#+$\\)")
  (setq deft-text-mode 'org-mode)
  (setq deft-extension "org")
  (setq deft-extensions '("org"))
  (setq deft-default-extension "org")

  ;; to create new files based on title
  (setq deft-use-filename-as-title nil)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-file-naming-rules
      '((noslash . "-")
        (nospace . "-")
        (case-fn . downcase))))

(defun show-notes ()
  (interactive)
  (hs-kill-buffers "*Deft*")
  (when deft-directory "~/Syncthing/org/notes/"
        (setq-default deft-directory "~/Syncthing/org/notes/"))
  (deft))

(defun show-project-notes ()
  (interactive)
  (hs-kill-buffers "*Deft*")
  (setq-default deft-directory "~/Syncthing/org/projects/")
  (deft))

(defun show-technical-notes ()
  (interactive)
  (hs-kill-buffers "*Deft*")
  (setq-default deft-directory "~/Syncthing/org/technical/")
  (deft))

(defun show-personal-notes ()
  (interactive)
  (hs-kill-buffers "*Deft*")
  (setq-default deft-directory "~/Syncthing/org/personal/")
  (deft))

;; Deft mit Notizen auf C-c n
(global-set-key "\C-cn" 'show-notes)
(global-set-key "\C-cP" 'show-project-notes)

;; Deft mit programming notes auf C-c p
(global-set-key "\C-cp" 'show-personal-notes)
(global-set-key "\C-ct" 'show-technical-notes)

(require 'cl)
(defun hs-kill-buffers (regexp)
  "Kill buffers matching REGEXP without asking for confirmation."
  (interactive "sKill buffers matching this regular expression: ")
  (flet ((kill-buffer-ask (buffer) (kill-buffer buffer)))
    (kill-matching-buffers regexp)))
(setq deft-recursive t)
  
;;key to launch deft
(global-set-key (kbd "C-c d") 'deft)

;;; Provide
(provide 'marcom-deft)
;;; marcom-deft.el ends here
