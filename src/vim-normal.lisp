(in-package :hemlock-vim)


(defcommand "New Line and Insert" (p)
  "Start a new line below, and go to insert mode."
  "Start a new line below, and go to insert mode."
  ;; TODO: go via official command name?
  ;; TODO: only 1 line, repeat afterwards
  (hemlock::new-line-command 1)
  (hemlock-vim::into-insert-mode-command p))

(defcommand "New Line Above and Insert" (p)
  "Start a new line above, and go to insert mode."
  "Start a new line above, and go to insert mode."
  ;; TODO: go via official command name?
  ;; TODO: only 1 line, repeat afterwards
  (hemlock::new-line-command (- 1))
  (hemlock-vim::into-insert-mode-command p))


(defcommand "Delete Line" (p)
  "Delete lines."
  "Delete lines."
  (let ((start (current-point)))
    (line-start start)
      (with-mark ((end start))
        (if (line-offset end (or p 1))
          (kill-region (region start end) :kill-forward)
          (kill-region (region start (buffer-end start)) :kill-backward))
        (line-start (current-point)))))


(defcommand "Delete Region" (p)
  "Prepare for delete action."
  "Prepare for delete action."
  (setf *action*
        'hemlock-interface:delete-region
        ;;
        *region*
        nil
        ;;
        (buffer-major-mode (current-buffer))
        "vim-region/object"))

 
(defcommand "Append" (p)
  "appends after cursor."
  "appends after cursor."
  (character-offset (current-point) 1)
  (into-insert-mode-command p))

(defcommand "Append at EOL" (p)
  "Appends after End of Line."
  "Appends after End of Line."
  (line-end (current-point))
  (into-insert-mode-command p))



(defun add-at-current (point delta)
  ;; TODO: octal, hex, keep number of characters
  (with-mark ((mark point))
    (if (word-offset mark -1)
      (filter-region
        (lambda (stg)
          (format nil "~d" ;"~v,d"
                  ;(length stg)
                  (+ delta
                   (parse-integer stg
                                  :junk-allowed T))))
        (region mark point))
      (editor-error "Not enough words."))))


(defcommand "Decrement at Cursor" (p)
  "Increments the number at the cursor"
  "Increments the number at the cursor"
  (add-at-current (current-point) -1))
(defcommand "Increment at Cursor" (p)
  "Increments the number at the cursor"
  "Increments the number at the cursor"
  (add-at-current (current-point) +1))


;; overlay a transparent mode for the to-insert things?

(in-mode ("vim-normal-count")
  (bind-key "Cancel minor Modes" #k"escape")
  (bind-key "Argument Digit" #k"1")
  (bind-key "Argument Digit" #k"2")
  (bind-key "Argument Digit" #k"3")
  (bind-key "Argument Digit" #k"4")
  (bind-key "Argument Digit" #k"5")
  (bind-key "Argument Digit" #k"6")
  (bind-key "Argument Digit" #k"7")
  (bind-key "Argument Digit" #k"8")
  (bind-key "Argument Digit" #k"9"))

(in-mode ("vim-normal-count0")
  (bind-key "Cancel minor Modes" #k"escape")
  (bind-key "Argument Digit" #k"0"))


(in-mode ("vim-normal")
  (bind-key "Into Normal Mode" #k"escape")
  (bind-key "Into Cmdline Mode" #k":")
  (bind-key "Into Insert Mode" #k"i")
  (bind-key "Append" #k"a")
  (bind-key "Append at EOL" #k"A")

  (bind-key "Beginning of Line" #k"0")
  (bind-key "Beginning of Line" #k"^") ; TODO: first non-space char
  (bind-key "End of Line" #k"$")

  (bind-key "Into Normal/0 Mode" #k"1")
  (bind-key "Into Normal/0 Mode" #k"2")
  (bind-key "Into Normal/0 Mode" #k"3")
  (bind-key "Into Normal/0 Mode" #k"4")
  (bind-key "Into Normal/0 Mode" #k"5")
  (bind-key "Into Normal/0 Mode" #k"6")
  (bind-key "Into Normal/0 Mode" #k"7")
  (bind-key "Into Normal/0 Mode" #k"8")
  (bind-key "Into Normal/0 Mode" #k"9")

  (bind-key "Undo" #k"u") ;; TODO: get rid of question

  (bind-key "Delete Region" #k"d")
  ;(bind-key "Delete Line" #k"d d")

  (bind-key "Top of Window" #k"H")
  (bind-key "Line to Top of Window" #k"z t")
  (bind-key "Line to Top of Window" #k"z enter")
  (bind-key "Line to Center of Window" #k"z .")
  (bind-key "Line to Center of Window" #k"z z")
  (bind-key "Line to Bottom of Window" #k"z \-")
  (bind-key "Line to Bottom of Window" #k"z b")
  (bind-key "Bottom of Window" #k"L")

  (bind-key "Forward Search" #k"/")
  (bind-key "Reverse Search" #k"?")

  (bind-key "Goto Absolute Line" #k"G") ;; TODO
  (bind-key "End of Buffer" #k"G")
  (bind-key "Beginning of Buffer" #k"g g")

  (bind-key "Increment at Cursor" #k"control-a")
  (bind-key "Decrement at Cursor" #k"control-x")

  (bind-key "New Line and Insert" #k"o")
  (bind-key "New Line Above and Insert" #k"O")

  (bind-key "Next Line" #k"j")
  (bind-key "Next Line" #k"downarrow")

  (bind-key "Previous Line" #k"k")
  (bind-key "Previous Line" #k"uparrow")

  (bind-key "Forward Character" #k"l")
  (bind-key "Forward Character" #k"rightarrow")

  (bind-key "Backward Character" #k"h")
  (bind-key "Backward Character" #k"leftarrow")

  (bind-key "Forward Word" #k"w")
  (bind-key "Backward Word" #k"b")
  ;(bind-key "Kill Next Word" #k"d w")

  (bind-key "Split Window" #k"control-w control-s")
  (bind-key "Next Window" #k"control-w control-w")
  (bind-key "Delete Window" #k"control-w control-c")

  (bind-key "Here to Top of Window" #k"leftdown")
  (bind-key "Point to Here" #k"middledown")

  (bind-key "Scroll Window Down" #k"control-f")
  (bind-key "Scroll Window Up" #k"control-b")
  )

(in-mode ("vim-normal-count")
  (bind-key "Argument Digit" #k"0")
  (bind-key "Argument Digit" #k"1")
  (bind-key "Argument Digit" #k"2")
  (bind-key "Argument Digit" #k"3")
  (bind-key "Argument Digit" #k"4")
  (bind-key "Argument Digit" #k"5")
  (bind-key "Argument Digit" #k"6")
  (bind-key "Argument Digit" #k"7")
  (bind-key "Argument Digit" #k"8")
  (bind-key "Argument Digit" #k"9")
)
