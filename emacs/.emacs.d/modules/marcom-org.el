  (defun mb/org-font-setup ()
    ;; Replace list hyphen with dot
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

  (defun mb/org-mode-setup ()
      (org-indent-mode)
      (variable-pitch-mode 1)
      (visual-line-mode 1))

  (use-package org
      ;;:ensure org-contrib
      :straight (:type built-in)
      ;;:commands (org-capture org-agenda)
      :hook (org-mode . mb/org-mode-setup)
      :custom
      (org-src-preserve-indentation t)
      :config
      (setq org-ellipsis " ▾")
 (defvar my/org-contacts-template "* %(org-contacts-template-name)
         :PROPERTIES:
         :ADDRESS: %^{Olivzeisigweg 5, 13187 Berlin, DE}
         :BIRTHDAY: %^{Birthday}
         :EMAIL: %(org-contacts-template-email)
         :NOTE: %^{NOTE}
         :END:" "Template for org-contacts.")
    
        (setq org-capture-templates
             '(("t" "Todo" entry (file+headline "~/Syncthing/org/tasks.org" "Inbox")
                "* TODO %? %^g\n:PROPERTIES:\n:CREATED:%T\n:END:\n%i\nFrom: %a" :empty-lines 1)
               ("b" "todo" entry (file+headline "~/Syncthing/org/inbox.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
             ;;  ("j" "Journal" entry (file+olp+datetree "~/Nextcloud/org/journal.org")
             ;;   "* %?\nEntered on %U\n  %i\n %a")
               ("j" "Journal entry" entry (function org-journal-find-location)
                                    "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
               ("c" "Contact" entry (file+headline "~/Syncthing/org/contacts.org" "Friends"),
               my/org-contacts-template
               :empty-lines 1)
               ("l" "Link" entry (file+headline "~/Syncthing/org/references.org" "Links")
                "* %? %^L %^g \n%T" :prepend t)
               ("m" "Meeting"
                entry (file+datetree "~/Syncthing/org/meetings.org")
                "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
                :tree-type week
                :clock-in t
                :clock-resume t
                :empty-lines 0)
               ("W" "WWW: inbox, refile later" entry (file "~/Syncthing/org/references.org")
                "* %a :website:\n\n%U %?\n\n%:initial\n" :empty-lines 1)
               ("r" "Reviews")
               ("rd" "Daily Plan" plain (file+datetree "~/Syncthing/org/work.org" )
                 (file "~/Syncthing/org/templates/tpl-daily-review.org")
                :tree-type week
                :empty-lines 0)
                ("rw" "Weekly Plan" plain (file+datetree "~/Syncthing/org/work.org" )
                 (file "~/Syncthing/org/templates/tpl-weekly-review.org")
                :tree-type week
                :empty-lines 0)
                 ("rm" "Monthly Plan" plain (file+datetree "~/Syncthing/org/work.org" )
                 (file "~/Syncthing/org/templates/tpl-monthly-review.org")
                :tree-type week
                :empty-lines 0)
               ("a" "amazon")
      ("as" "shorts" entry (file+headline "~/Syncthing/org/tasks.org" "Inbox")
                ,my-capture-template-next :empty-lines 1)
               ("aw" "Task weekly" entry (file+headline "~/Syncthing/org/tasks.org" "Tasks/Weekly")
                "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
               ("am" "Mail link" entry (file+headline "tasks.org" "Mails")
                "* TODO %a %?\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))")))

        ;; some more examples :
        ;;(setq org-capture-templates
        ;;      '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
        ;;	 "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ;;	("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
        ;;	 "* %? %^L %^g \n%T" :prepend t)
        ;;	("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
        ;;	 "* %?\n%T" :prepend t)
        ;;	("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
        ;;	 "* TODO %?\n%u" :prepend t)
        ;;	("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
        ;;	 "* %?\n%u" :prepend t)
        ;;	("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
        ;;	 "* %?\n%i\n")))
        ;;(setq org-capture-templates
        ;;   '(("t" "Aufgabe in tasks.org" entry (file+headline "~/projects/org/tasks.org" "Inbox")
        ;;      "* TODO %?")
        ;;     ("w" "Waiting For Reply (Mail)" entry (file+headline "~/projects/org/tasks.org" "Inbox") 
        ;;      "* WAITING Antwort auf %a")
        ;;     ("m" "Aufgabe aus Mail" entry (file+headline "~/projects/org/tasks.org" "Inbox") 
        ;;      "* TODO %? , Link: %a")
        ;;     ("z" "Zeiteintrag in tasks.org" entry (file+headline "~/projects/org/tasks.org" "Inbox")
        ;;      "* ZKTO %? \n  %i" :clock-in t :clock-resume t)
        ;;     ("c" "Contacts" entry (file "~/projects/org/contacts.org")
        ;;      "* %(org-contacts-template-name) \n :PROPERTIES: %(org-contacts-template-email) \n :BIRTHDAY: \n :END:")
        ;;     ("j" "Journal" entry (file+datetree "~/projects/org/journal.org")
        ;;      "* %?\nEntered on %U\n  %i")
        ;;     ("p" "password" entry (file "~/projects/org/passwords.gpg")
        ;;      "* %^{Title}\n  %^{PASSWORD}p %^{USERNAME}p")))
	    :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
      )
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-return-follows-link t)
  ;;(setq org-drawers (quote ("PROPERTIES" "CLOCKTABLE" "LOGBOOK" "CLOCK")))
  ;(setq org-completion-use-ido t)


  ; use shift-arrows to move window focus only where no org functions are defined
  ;  (setq org-support-shift-select t)
  (add-hook 'org-shiftup-final-hook 'windmove-up)
  (add-hook 'org-shiftleft-final-hook 'windmove-left)
  (add-hook 'org-shiftdown-final-hook 'windmove-down)
  (add-hook 'org-shiftright-final-hook 'windmove-right)

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

  (defvar org-default-projects-dir   "~/Syncthing/org/projects"                     "Primary GTD directory")
  (defvar org-default-technical-dir  "~/Syncthing/org/technical"                    "Directory of shareable notes")
  (defvar org-default-personal-dir   "~/Syncthing/org/personal"                     "Directory of un-shareable, personal notes")
  (defvar org-default-completed-dir  "~/Syncthing/org/archive"            "Directory of completed project files")
  (defvar org-default-inbox-file     "~/Syncthing/org/inbox.org"         "New stuff collects in this file")
  (defvar org-default-projects-file  "~/Syncthing/org/projects.org"         "Primary Project File for now")
  (defvar org-default-tasks-file     "~/Syncthing/org/tasks.org"           "Tasks, TODOs and little projects")
  (defvar org-default-incubate-file  "~/Syncthing/org/incubate.org"        "Ideas simmering on back burner")
  (defvar org-default-completed-file nil                              "Ideas simmering on back burner")
  (defvar org-default-notes-file     "~/Syncthing/org/privat.org"   "Non-actionable, personal notes")
  (defvar org-default-media-file     "~/Syncthing/org/media.org"           "White papers and links to other things to check out")

  ; (with-eval-after-load 'org
     (setq org-directory "~/Syncthing/org")
     (setq org-agenda-files
           (mapcar (lambda (path) (concat org-directory path))
                   '("/projects.org"
                      "/inbox.org"
                      "/Haus.org"
                      "/tasks.org"
                 "/privat.org")))
  ;)
  ;   (add-to-list 'org-agenda-files org-default-tasks-file 'append)
  ;   (add-to-list 'org-agenda-files org-default-inbox-file 'append)
  ;   (add-to-list 'org-agenda-files "~/Nextcloud/org/calendars/calendar.org" 'append)
  ;   (add-to-list 'org-agenda-files "~/Nextcloud/org/calendars/cal-personal.org" 'append)
     ;; All projectfiles in Agenda
     ;(add-to-list 'org-agenda-files (list org-default-projects-dir))
     ;(add-to-list 'org-agenda-file-regexp "^[a-z0-9-_]+.org")

                        ;;  Custom Agenda View Section
                        (setq org-agenda-custom-commands
                             '(("v" "Simple agenda view"
                                ((agenda "")
                                 (alltodo "")))
                               ("c" "CIB agenda view"
                                ((agenda "")
                                 (alltodo ""))
                                ((org-agenda-show-log t)
                                 (org-agenda-ndays 7)
                                 (org-agenda-log-mode-items '(state))
                                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":CIB:"))))
                                ("C" "Team agenda view"
                                ((agenda "")
                                 (alltodo "")
                                 (tags-todo "Rambo")
                                 (tags-todo "Rados")
                                 (tags-todo "TXL1"))
                                ((org-agenda-show-log t)
                                 (org-agenda-ndays 7)
                                 (org-agenda-log-mode-items '(state))))
                               ("g" . "GTD-Workflow")
                               ("gn" "Next Actions" tags-todo "next" ((org-use-tag-inheritance nil)))
                               ("gd" "DONE" tags-todo "done" ((org-use-tag-inheritance nil)))
                               ("gw" "Waiting" todo "WAITING")
                               ("gs" "SOMEDAY" tags "someday" ((org-agenda-filter-preset 
                                                                '("+someday"))(org-agenda-todo-ignore-with-date nil)))
                               ("gf" "Agenda + flagged"
                                ((todo "WAITING")
                                 (todo "DELEGATED")
                                 (tags "flagged")
                                 (tags "TXL1")
                                 (agenda "")))
                                 ))

   (use-package org-journal
    ;;:ensure t
    :defer t
    :custom
    (org-journal-dir "~/Syncthing/org/journal/")
    (org-journal-file-format "journal%Y-%m-%d")
    (org-journal-date-format "%e %b %Y (%A)")
    (org-journal-time-format "")
    )
    (defun org-journal-find-location ()
      ;; Open today's journal, but specify a non-nil prefix argument in order to
      ;; inhibit inserting the heading; org-capture will insert the heading.
      (org-journal-new-entry t)
      ;; Position point on the journal's top-level heading so that org-capture
      ;; will add the new entry as a child entry.
      (goto-char (point-min)))

;; Archive config - move to archive file accordng to month of archiving
(setq org-archive-location (concat "archive/%s-"
                                  (format-time-string "%Y%m" (current-time))
                                  "_archiv::"))

   (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
     (python . t)
     (shell . t)
     (js . t)
     (latex . t)
     (org . t)
     (dot . t)
    ;; (gnuplot . t)
    ;; (ruby . t)
    ;;(screen . nil)
    ;; (ledger . t)
     ;;(C . t)
     (sql . t)
     (ditaa . t)))

(use-package hydra
  :defer t)

          (defhydra hydra-org-refiler (org-mode-map "C-c s" :hint nil)
              "
            ^Navigate^      ^Refile^       ^Move^           ^Update^        ^Go To^        ^Dired^
            ^^^^^^^^^^---------------------------------------------------------------------------------------
            _k_: ↑ previous _t_: tasks     _m X_: projects  _T_: todo task  _g t_: tasks    _g X_: projects
            _j_: ↓ next     _i_: incubate  _m P_: personal  _S_: schedule   _g i_: incubate _g P_: personal
            _a_: archive    _p_: personal  _m T_: technical _D_: deadline   _g x_: inbox    _g T_: technical
            _d_: delete     _r_: refile                   _R_: rename     _g n_: notes    _g C_: completed
            "
              ("<up>" org-previous-visible-heading)
              ("<down>" org-next-visible-heading)
              ("k" org-previous-visible-heading)
              ("j" org-next-visible-heading)
          ;    ("c" org-archive-subtree-as-completed) ;; idea to archive into journal files
              ("a" org-archive-subtree)
              ("d" org-cut-subtree)
              ("t" org-refile-to-task)
              ("i" org-refile-to-incubate)
              ("p" org-refile-to-personal-notes)
              ("r" org-refile)
              ("m X" org-refile-to-projects-dir)
              ("m P" org-refile-to-personal-dir)
              ("m T" org-refile-to-technical-dir)
              ("T" org-todo)
              ("S" org-schedule)
              ("D" org-deadline)
              ("R" org-rename-header)
              ("g t" (find-file-other-window org-default-tasks-file))
              ("g i" (find-file-other-window org-default-incubate-file))
              ("g x" (find-file-other-window org-default-inbox-file))
              ("g c" (find-file-other-window org-default-completed-file))
              ("g n" (find-file-other-window org-default-notes-file))
              ("g X" (show-project-notes))
          ;    ("g X" (dired org-default-projects-dir))
          ;    ("g P" (dired org-default-personal-dir))
              ("g P" (show-personal-notes))
              ("g T" (show-technical-notes))
          ;    ("g T" (dired org-default-technical-dir))
              ("g C" (dired org-default-completed-dir))
              ("[\t]" (org-cycle))
              ("s" (org-save-all-org-buffers) "save")
              ("q" nil "quit"))

          ;; Hydra functions as of howards blog
          (defun org-subtree-region ()
            "Return a list of the start and end of a subtree."
            (save-excursion
              (list (progn (org-back-to-heading) (point))
                    (progn (org-end-of-subtree)  (point)))))

          (defun org-refile-directly (file-dest)
            "Move the current subtree to the end of FILE-DEST.
          If SHOW-AFTER is non-nil, show the destination window,
          otherwise, this destination buffer is not shown."
            (interactive "Destination: ")

            (defun dump-it (file contents)
              (find-file-other-window file-dest)
              (goto-char (point-max))
              (insert "\n" contents))

            (save-excursion
              (let* ((region (org-subtree-region))
                     (contents (buffer-substring (first region) (second region))))
                (apply 'kill-region region)
                (if org-refile-directly-show-after
                    (save-current-buffer (dump-it file-dest contents))
                  (save-window-excursion (dump-it file-dest contents))))))

          (defvar org-refile-directly-show-after nil
            "When refiling directly (using the `org-refile-directly'
          function), show the destination buffer afterwards if this is set
          to `t', otherwise, just do everything in the background.")

          (defun org-refile-to-incubate ()
            "Refile (move) the current Org subtree to `org-default-incubate-file'."
            (interactive)
            (org-refile-directly org-default-incubate-file))

          (defun org-refile-to-task ()
            "Refile (move) the current Org subtree to `org-default-tasks-file'."
            (interactive)
            (org-refile-directly org-default-tasks-file ))

          (defun org-refile-to-personal-notes ()
            "Refile (move) the current Org subtree to `org-default-notes-file'."
            (interactive)
            (org-refile-directly org-default-notes-file))

          (defun org-refile-to-completed ()
            "Refile (move) the current Org subtree to `org-default-completed-file',
          unless it doesn't exist, in which case, refile to today's journal entry."
            (interactive)
            (if (and org-default-completed-file (file-exists-p org-default-completed-file))
                (org-refile-directly org-default-completed-file)
              (org-refile-directly (get-journal-file-today))))

          (defun org-rename-header (label)
            "Rename the current section's header to LABEL, and moves the
          point to the end of the line."
            (interactive (list
                          (read-string "Header: "
                                       (substring-no-properties (org-get-heading t t t t)))))
            (org-back-to-heading)
            (replace-string (org-get-heading t t t t) label))

          (defun org-archive-subtree-as-completed ()
            "Archives the current subtree to today's current journal entry."
            (interactive)
            ;; According to the docs for `org-archive-subtree', the state should be
            ;; automatically marked as DONE, but I don't notice that:
            (when (org-get-todo-state)
              (org-todo "DONE"))

            (let* ((org-archive-file (or org-default-completed-file
                                         (todays-journal-entry)))
                   (org-archive-location (format "%s::" org-archive-file)))
               (org-archive-subtree)))

          (defun todays-journal-entry ()
            "Return the full pathname to the day's journal entry file.
          Granted, this assumes each journal's file entry to be formatted
          with year/month/day, as in `20190104' for January 4th.

          Note: `org-journal-dir' variable must be set to the directory
          where all good journal entries live, e.g. ~/journal."
            (let* ((daily-name   (format-time-string "%Y%m%d"))
                   (file-name    (concat org-journal-dir daily-name)))
              (expand-file-name file-name)))

          (defun org-boxes-workflow ()
            "Load the default tasks file and start our hydra on the first task shown."
            (interactive)
            (let ((org-startup-folded nil))
              (find-file org-default-tasks-file)
              (delete-other-windows)
              (ignore-errors
                (mb/org-agenda))
              (delete-other-windows)
              (split-window-right)
              ;;(split-window-right-and-focus) seems to be gone
              (pop-to-buffer (get-file-buffer org-default-tasks-file))
              (goto-char (point-min))
              (org-next-visible-heading 1)
              (hydra-org-refiler/body)))

          (defun mb/org-agenda ()
            "Displays my favorite agenda perspective."
            (interactive)
            (org-agenda nil "a")
            (get-buffer "*Org Agenda*")
            (execute-kbd-macro (kbd "A t")))
     ;; Org Hydra
     (global-set-key (kbd "<f4>") 'hydra-org-refiler/body)

;;; Provide
(provide 'marcom-org)
;;; marcom-org.el ends here
