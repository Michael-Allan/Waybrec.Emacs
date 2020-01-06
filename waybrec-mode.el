;; The definition of Waybrec mode, a major mode for editing Waybrec.  -*- lexical-binding: t; -*-
;;
;; USAGE
;; ─────
;;   1. Put a copy of this file on your load path.
;;      https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Search.html
;;
;;   2. Add the following to your initialization file.
;;
;;       (autoload 'waybrec-mode "waybrec-mode" nil t)
;;       (set 'auto-mode-alist (cons (cons "/waycast/.*\\.brec\\'" 'waybrec-mode) auto-mode-alist))
;;         ;; Associating Waybrec mode, that is, with any Breccian file located in a waycast.
;;
;;   Working example:
;;
;;       http://reluk.ca/.emacs.d/lisp/initialization.el


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


                                  ;;; Copyright © 2019-2020 Michael Allan and contributors.  Licence MIT.
