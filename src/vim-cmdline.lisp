(in-package :hemlock-vim)

(defcommand "Execute VIM command" (p)
  "Executes a VIM command"
  "Executes a VIM command"
  (declare (ignore p))
  )


(in-mode ("vim-cmdline")
  (bind-key "Execute VIM command" #k"return")

  (bind-key "Into Normal Mode" #k"escape")
  (bind-key "Into Normal Mode" #k"control-c")
  )
