;; The implementation of Waybrec mode, a major mode for editing Waybrec.
;;
;; USAGE
;; ─────
;;   In your initialization file:
;;
;;      (require 'breccia-mode)
;;      (require 'waybrec-mode)
;;      (add-to-list 'auto-mode-alist '(           "\\.brec\\'" . breccia-mode))
;;      (add-to-list 'auto-mode-alist '("/waycast/.+\\.brec\\'" . waybrec-mode))
;;        ;; Only if the file is located in a waycast, that is.
;;
;;   Working example:
;;
;;       http://reluk.ca/.emacs


(define-derived-mode waybrec-mode breccia-mode
  "Waybrec"
  "A major mode for editing Waybrec"
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

    (set (make-local-variable 'brec-command-highlighter-components) hc))
       ;;; So isolating from any other `breccia-mode` buffer the (shallow) change to this variable.
  (set 'font-lock-defaults '(brec-keywords))); ‘It automatically becomes buffer-local when set.’ [FLB]



;;;;;;;;;;;;;;;;;;;;

(provide 'waybrec-mode); Providing these features of `waybrec-mode.el` for all who `require` them.


;; NOTE
;; ────
;;   FLB  Font lock basics.
;;        https://www.gnu.org/software/emacs/manual/html_node/elisp/Font-Lock-Basics.html


                                      ;;; Copyright © 2019 Michael Allan and contributors.  Licence MIT.
