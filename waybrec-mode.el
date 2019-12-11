;; The definition of Waybrec mode, a major mode for editing Waybrec.  -*- lexical-binding: t; -*-
;;
;; USAGE
;; ─────
;;   In your initialization file:
;;
;;      (require 'waybrec-mode)
;;      (add-to-list 'auto-mode-alist '("/waycast/.+\\.brec\\'" . waybrec-mode))
;;        ;; Only if the file is located in a waycast, that is.
;;
;;   Working example:
;;
;;       http://reluk.ca/sys/computer/Havoc/etc/emacs/user-initialization.el


(require 'breccia-mode)



(define-derived-mode waybrec-mode breccia-mode
  "Waybrec" "\
A major mode for editing Waybrec.
        Home page URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/’
User instructions URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/waybrec-mode.el’"
  (let* ((bq-pat brec-backquoted-pattern-pattern)
         (gap brec-gap-pattern)
         (hc (copy-sequence brec-command-highlighter-components)); So isolating from any other
           ;;; `breccia-mode` buffer the (deep) changes about to be introduced to this list.
         (hc-new (last hc 2))); The component after which to insert new components.

    ;; Patch
    ;; ─────
    (push (concat "\\|\\(?1:prepend\\|append\\)" gap "@" gap bq-pat) (cdr hc-new));
    (push (concat "\\|\\(?1:delete\\|precede\\|succeed\\)" gap bq-pat) (cdr hc-new));
    (push "\\|\\(?1:replace\\)\\>" (cdr hc-new));

    ;; Thoroughfractum designator
    ;; ──────────────────────────
    (push "\\|\\(?1:thoroughfractum\\)\\>" (cdr hc-new))

    (setq-local brec-command-highlighter-components hc))
      ;;; Locally isolating from any other `breccia-mode` buffer the (shallow) change to this variable.
  (brec-set-for-buffer 'font-lock-defaults '(brec-keywords)))



(provide 'waybrec-mode)


                                       ;;; Copyright © 2019 Michael Allan and contributors.  Licence MIT.
