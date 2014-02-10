(in-package :hemlock-vim)

;; make insert mode work
    #+nil
(map-bindings
  (lambda (key command)
    (print (list key (command-name command)))
    (if (equal (command-name command)
               "Self Insert")
      (bind-key "Do Nothing" key)))
  :global)


(in-mode ("vim-insert")
  (bind-key "Into Normal Mode" #k"escape")
  (bind-key "Next Window" #k"control-^")

  #+nil
  (bind-key "Temporary Normal Mode" #k"control-o")
  )
