
;;;### (autoloads (vc-clearcase-report-bug vc-clearcase-start-view
;;;;;;  vc-clearcase-edcs vc-clearcase-list-view-private-files vc-clearcase-label-diff-report
;;;;;;  vc-clearcase-update-view vc-clearcase-list-checkouts vc-clearcase-checkin-directory
;;;;;;  vc-clearcase-checkout-directory clearcase-file-not-found-handler
;;;;;;  cleartool-program vc-clearcase) "vc-clearcase" "vc-clearcase.el"
;;;;;;  (20909 60102 0 0))
;;; Generated autoloads from vc-clearcase.el

(let ((loads (get 'vc-clearcase 'custom-loads))) (if (member '"vc-clearcase" loads) nil (put 'vc-clearcase 'custom-loads (cons '"vc-clearcase" loads))))

(defvar cleartool-program "cleartool" "\
The name of the cleartool executable.")

(custom-autoload 'cleartool-program "vc-clearcase" t)
(defun vc-clearcase-registered (file)
 (let (wdview
       retcode
       (program cleartool-program))
   (setq wdview
         (with-output-to-string
           (with-current-buffer standard-output
             (setq retcode
                   (call-process
                    program nil t nil "pwv" "-short" "-wdview")))))
   ;;(message "Wdview for %s is %S" file wdview)
   (if (or (not (eq retcode 0))
           (eq (compare-strings "** NONE **" 0 10 wdview 0 10) t))
       nil
     (load "vc-clearcase")
     (vc-clearcase-registered file))))

(autoload 'clearcase-file-not-found-handler "vc-clearcase" "\
Handle opening of version-extended ClearCase files.
This function should be added to `find-file-not-found-functions'
to handle opening ClearCase files in the format
file.txt@@/main/0.  The function will visit the file first, than
will open the specified version in another window, using
`vc-revision-other-window'

\(fn)" nil nil)

(autoload 'vc-clearcase-checkout-directory "vc-clearcase" "\
Checkout directory DIR, or do nothing if already checked out.
To register, rename or remove files, the directory needs to be
checked out.  vc-clearcase will checkout a directory when needed
and check it in again, but if you need to register (or rename or
delete) several files, a new directory revision will be created
for each operation.  In such a case, it might be useful to
checkout/checkin the directory explicitely, so that a single
directory revision is created instead.

\(fn DIR)" t nil)

(autoload 'vc-clearcase-checkin-directory "vc-clearcase" "\
Checkin directory DIR, or do nothing if already checked in.
See `vc-clearcase-checkout-directory' for why this function might
be usefull.

\(fn DIR)" t nil)

(autoload 'vc-clearcase-list-checkouts "vc-clearcase" "\
List the checkouts of the current user in DIR.
If PREFIX-ARG is present, an user name can be entered, and all
the views are searched for checkouts of the specified user.  If
the entered user name is empty, checkouts from all the users on
all the views are listed.

\(fn DIR &optional PREFIX-ARG)" t nil)

(autoload 'vc-clearcase-update-view "vc-clearcase" "\
Run a cleartool update command in DIR and display the results.
With PREFIX-ARG, run update in preview mode (no actual changes
are made to the views).

\(fn DIR PREFIX-ARG)" t nil)

(autoload 'vc-clearcase-label-diff-report "vc-clearcase" "\
Report the changed file revisions between labels.
A report is prepared in the *label-diff-report* buffer for the
files in DIR that have different revisions between LABEL-1
and LABEL-2'.

\(fn DIR LABEL-1 LABEL-2)" t nil)

(autoload 'vc-clearcase-list-view-private-files "vc-clearcase" "\
List the view private files in DIR.
You can edit the files using 'find-file-at-point'

\(fn DIR)" t nil)

(autoload 'vc-clearcase-edcs "vc-clearcase" "\
Fetch the config spec for VIEW-TAG and pop up a buffer with it.
In interactive mode, prompts for a view-tag name with the default
of the current file's view-tag.

\(fn VIEW-TAG)" t nil)

(autoload 'vc-clearcase-start-view "vc-clearcase" "\
Start the dynamic view for VIEW-TAG.
In interactive mode, prompts for a view-tag name.

\(fn VIEW-TAG)" t nil)

(define-key vc-prefix-map "e" 'vc-clearcase-edcs)

(define-key vc-prefix-map "f" 'vc-clearcase-start-view)

(define-key vc-prefix-map "j" 'vc-clearcase-gui-vtree-browser)

(define-key vc-prefix-map "o" 'vc-clearcase-list-checkouts)

(define-key vc-prefix-map "p" 'vc-clearcase-update-view)

(define-key vc-prefix-map "t" 'vc-clearcase-what-view-tag)

(define-key vc-prefix-map "w" 'vc-clearcase-what-rule)

(define-key vc-prefix-map "y" 'vc-clearcase-what-version)

(defvar clearcase-global-menu)

(defvar clearcase-global-menu-map (make-sparse-keymap))

(easy-menu-define clearcase-global-menu clearcase-global-menu-map "Menu for the extra (non-file related) ClearCase functionality" '("ClearCase" ["Checkout directory..." vc-clearcase-checkout-directory t] ["Checkin directory..." vc-clearcase-checkin-directory t] "----" ["Start dynamic view..." vc-clearcase-start-view t] ["Edit Configspec..." vc-clearcase-edcs t] ["Update snapshot view..." vc-clearcase-update-view t] ["List Checkouts..." vc-clearcase-list-checkouts t] ["List View Private Files..." vc-clearcase-list-view-private-files t] ["Label diff report..." vc-clearcase-label-diff-report t] "----" ["Report bug in vc-clearcase..." vc-clearcase-report-bug t]))

(easy-menu-add-item menu-bar-tools-menu 'nil clearcase-global-menu "PCL-CVS")

(autoload 'vc-clearcase-report-bug "vc-clearcase" "\
Submit via mail a bug report on vc-clearcase.el.

\(fn)" t nil)

(let ((backup-regexp "\\.~[a-zA-Z0-9_-~]+\\'") (garbage-regexp "\\.\\(contrib\\|keep\\)\\(\\.[0-9]+\\)?\\'")) (unless (assoc backup-regexp auto-mode-alist) (push (list backup-regexp nil t) auto-mode-alist)) (unless (assoc garbage-regexp auto-mode-alist) (push (list garbage-regexp nil t) auto-mode-alist)))

(when (and (executable-find cleartool-program) (>= emacs-major-version 23)) (cond ((boundp 'find-file-not-found-functions) (add-hook 'find-file-not-found-functions 'clearcase-file-not-found-handler)) ((boundp 'find-file-not-found-hooks) (add-hook 'find-file-not-found-hooks 'clearcase-file-not-found-handler))) (if (boundp 'vc-handled-backends) (unless (memq 'CLEARCASE vc-handled-backends) (setq vc-handled-backends (nconc vc-handled-backends '(CLEARCASE)))) (setq vc-handled-backends '(RCS CVS CLEARCASE))))

;;;***

;;;### (autoloads (ucm-unlock-activity ucm-lock-activity ucm-checkin-activity
;;;;;;  ucm-browse-activity ucm-list-activities ucm-delete-activity
;;;;;;  ucm-show-current-activity ucm-set-activity) "ucm" "ucm.el"
;;;;;;  (20909 60102 0 0))
;;; Generated autoloads from ucm.el

(defvar ucm-create-activity-function nil "\
Function to call for creating new activities.
When nil, `ucm-set-activity' will create a new activity by
prompting for a headline and using mkact.")

(autoload 'ucm-set-activity "ucm" "\
Set the UCM ACTIVITY in the current directory.
In interactive mode, the user is prompted for the available
activities in the stream associated with the UCM view in the
`default-directory', and the selected one is set.

Two special activity names are also accepted: *NONE* which will
cause the current activity to be unset and *NEW-ACTIVITY* which
will create and set a new activity (the user is prompted for the
activity headline).

\(fn &optional ACTIVITY)" t nil)

(autoload 'ucm-show-current-activity "ucm" "\
Show the current activity in the view.
With prefix argument (EXTRA-INFO), also shows the number of
files modified under this activity, number of revisions and the
number of checked out files.

\(fn &optional EXTRA-INFO)" t nil)

(autoload 'ucm-delete-activity "ucm" "\
Remove ACTIVITY from UCM ClearCase.
An activity can only be removed if it contains no versions, it is
not the current activity and it is not locked.

\(fn ACTIVITY)" t nil)

(autoload 'ucm-list-activities "ucm" "\


\(fn &optional DIR)" t nil)

(autoload 'ucm-browse-activity "ucm" "\
Pop-up an information buffer about ACTIVITY.
The buffer will contain a report about the file revisions
checked-in under the activity plus any contributing activities.
The report contains buttons (hyperlinks) to directories, files,
revisions and other activities.

In interactive mode, the user is prompted for an activity name
and completion is available.  ACTIVITY must be in the current
stream (corresponding to the view in `default-directory').  With
prefix argument, obsolete activities can also be selected.  With
a negative prefix argument any activity can be selected, but no
completion is provided.

There are no restriction on ACTIVITY when this function is called
directly.

\(fn ACTIVITY)" t nil)

(autoload 'ucm-checkin-activity "ucm" "\
Check in all files checked-out under ACTIVITY.
This will pop-up a `log-edit' buffer to enter the check in
comment, than attempt to check in the files.

If the log buffer is empty, each file to be checked in using its
original check out comment, otherwise the same log message will
be used for all files.

An error will be signalled if no files are checked out under
ACTIVITY.

HINT: `log-edit-modes' allows to see what files will be
checked-in using \\[log-edit-show-files].

\(fn ACTIVITY)" t nil)

(defvar ucm-before-activity-lock-hook 'nil "\
Hook run before an activity is locked.
This can be used for example to attach/modifiy attributes on the
activity.

Each hook function is called with two arguments, the first is
the activity name, the second is t.")

(autoload 'ucm-lock-activity "ucm" "\
Lock ACTIVITY.  With prefix arg, mark it as obsolete.

\(fn ACTIVITY)" t nil)

(autoload 'ucm-unlock-activity "ucm" "\
Unlock ACTIVITY. With prefix arg, allow selecting obsolete activities.

\(fn ACTIVITY)" t nil)

;;;***
