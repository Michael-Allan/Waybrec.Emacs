;; The implementation of Waybrec mode, a major mode for editing Waybrec.
;;
;; USAGE
;; ─────
;;   In your initialization file:
;;
;;      (require 'Breccia_mode)
;;      (require 'Waybrec_mode)
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
  (let* ((bqPat brecBackquotedPatternPattern)
         (gap brecGapPattern)
         (hc (copy-sequence brecCommandHighlighterComponents)); So isolating from any other
           ;;; `breccia-mode` buffer the (deep) changes about to be introduced to this list.
         (hcNew (last hc 2))); The component after which to insert new components.

    ;; Patch
    ;; ─────
    (push (concat "\\|\\(?1:prepend\\|append\\)" gap "@" gap bqPat) (cdr hcNew));
    (push (concat "\\|\\(?1:delete\\|precede\\|succeed\\)" gap bqPat) (cdr hcNew));
    (push "\\|\\(?1:replace\\)\\>" (cdr hcNew));

    ;; Thoroughfractum designator
    ;; ──────────────────────────
    (push "\\|\\(?1:thoroughfractum\\)\\>" (cdr hcNew))

    (set (make-local-variable 'brecCommandHighlighterComponents) hc))
       ;;; So isolating from any other `breccia-mode` buffer the (shallow) change to this variable.
  (set 'font-lock-defaults '(brecKeywords))); ‘It automatically becomes buffer-local when set.’ [FLB]



;;;;;;;;;;;;;;;;;;;;

(provide 'Waybrec_mode)


;; NOTE
;; ────
;;   FLB  Font lock basics.
;;        https://www.gnu.org/software/emacs/manual/html_node/elisp/Font-Lock-Basics.html


                                      ;;; Copyright © 2019 Michael Allan and contributors.  Licence MIT.
