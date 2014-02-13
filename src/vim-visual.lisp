(in-package :hemlock-vim)



(in-mode ("vim-visual")
  (bind-key "Into Normal Mode" #k"escape")
  (bind-key "Into Normal Mode" #k"c-c")

  (bind-key "Exchange Point and Mark" #k"o")
  )
