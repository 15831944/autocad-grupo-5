(DEFUN C:CIRCULO ()
  (ALERT "VA A CREAR UN CIRCULO")
  (entmake '((0 . "CIRCLE") (62 . 1) (10 100.0 100.0 0.0) (40 . 20.0))) 
)