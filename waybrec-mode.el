;; Waybrec mode  │ -*- lexical-binding: t; -*-
;;
;; This is the definition of Waybrec mode, a major mode for editing Waybrec.  For usage instructions, see
;; `./user_instructions.brec` or `http://reluk.ca/project/wayic/Waybrec/Emacs/user_instructions.brec`.


(require 'breccia-mode)



(define-derived-mode waybrec-mode breccia-mode
  "Waybrec" "\
A major mode for editing Waybrec.
        Home page URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/’
User instructions URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/user_instructions.brec’"
  (let* ((bq-pat brec-backquoted-pattern-pattern)
         (gap brec-gap-pattern)
         (mc (copy-sequence brec-command-matcher-components)); So isolating from any other
           ;;; `breccia-mode` buffer the (deep) changes about to be introduced to this list.
         (mc-new (last mc 2))); The component after which to insert new components.

    ;; Patch
    ;; ─────
    (push (concat "\\|\\(?1:prepend\\|append\\)" gap "@" gap bq-pat) (cdr mc-new));
    (push (concat "\\|\\(?1:delete\\|precede\\|succeed\\)" gap bq-pat) (cdr mc-new));
    (push "\\|\\(?1:replace\\)\\>" (cdr mc-new));

    ;; Thoroughfractum designator
    ;; ──────────────────────────
    (push "\\|\\(?1:thoroughfractum\\)\\>" (cdr mc-new))

    (setq-local brec-command-matcher-components mc))
      ;;; Locally isolating from any other `breccia-mode` buffer the (shallow) change to this variable.
  (brec-set-for-buffer 'font-lock-defaults '(brec-keywords)))



(provide 'waybrec-mode)


                                  ;;; Copyright © 2019-2020 Michael Allan and contributors.  Licence MIT.
