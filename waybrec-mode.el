;;; waybrec-mode.el --- A major mode for editing Waybrec  -*- lexical-binding: t; -*-

;; Copyright © 2019-2020 Michael Allan.

;; Author: Michael Allan <mike@reluk.ca>
;; Version: 0-snapshot
;; Package-Requires: (breccia-mode)
;; Keywords: wp, outlines
;; URL: http://reluk.ca/project/wayic/Waybrec/Emacs/

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This package introduces a major mode for editing Waybrec.  For more information,
;; see `http://reluk.ca/project/wayic/Waybrec/Emacs/`.
;;
;; If you install this package using a package manager, then one step will remain to complete
;; the installation.  Add the following code to your initialization file.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html
;;
;;     (set 'auto-mode-alist (cons (cons "/waycast/.*\\.brec\\'" 'waybrec-mode) auto-mode-alist))
;;
;; Ensure the regular expression captures the path to your waysource files.  Then Waybrec Mode
;; will activate on loading any of them into Emacs.  And that completes the installation.
;;
;; Manual installation, on the other hand, requires further steps:
;;
;;   1. Put a copy of the present file on your load path.
;;      https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Search.html
;;
;;   2. Optionally compile that copy.  E.g. load it into an Emacs buffer and type
;;      `M-x emacs-lisp-byte-compile`.
;;
;;   3. Add the following code to your initialization file.
;;
;;         (autoload 'waybrec-mode "waybrec-mode" nil t)
;;
;;      Ensure too that `auto-mode-alist` is set, as described further above.
;;
;; For a working example of manual installation, see the relevant lines
;; of `http://reluk.ca/.emacs.d/lisp/initialization.el`, and follow the reference there.

;;; Code:


(require 'breccia-mode)



;;;###autoload
(define-derived-mode waybrec-mode breccia-mode
  "Waybrec" "\
A major mode for editing Waybrec.  For more information,
see URL ‘http://reluk.ca/project/wayic/Waybrec/Emacs/’."
  (let* ((bq-pat brec-backquoted-pattern-pattern)
         (gap brec-partial-gap-pattern); Partial and deprecated. [BUG]
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


;; NOTE
;; ────
;;   BUG  This code is incorrect.


;;; waybrec-mode.el ends here
