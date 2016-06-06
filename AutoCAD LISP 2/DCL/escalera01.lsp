(defun c:escalera ()
  (setq escal (load_dialog "d:/facultadI/dcl/escalera01.dcl"))
  (if (not (new_dialog "escalera" escal))
    (exit)
  )
  (set_tile "contrahuella" "0.18")
  (action_tile "contrahuella" "(SETQ contrahuella $VALUE)")
  (action_tile "contrahuella" "(verificacion)")
  (mode_tile "contrahuella" 2)
  (set_tile "huella" "0.28")
  (action_tile "huella" "(SETQ huella $VALUE)")
  (set_tile "escalones" "8")
  (action_tile "escalones" "(SETQ escalones $VALUE)")
  (action_tile "punto" "(done_dialog 2)")
  (setq ventana_general (start_dialog))
  (unload_dialog escal)
  (if (= ventana_general 2)(traerpunto))


XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  (setq osmodo (getvar "osmode"))
  (setvar "osmode" 0)
  (setq	altura contrahuella
	ancho  huella
	gradas escalones
	pinicial     p1
  )
  (setq	altura (distof altura)
	ancho  (distof ancho)
	gradas (atoi gradas)
  )
  (repeat gradas
    (setq p2 (polar p1 (/ pi 2) altura)
	  p3 (polar p2 0 ancho)
    )
    (command "line" p1 p2 p3 "")
    (setq p1 p3)
  )
  (setvar "osmode" osmodo)

)

;;;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
(defun verificacion ()
  (SETQ contrahuella $VALUE)
  (setq	B (read contrahuella)
	a (type B)
  )
  (IF (= A (QUOTE SYM))
    (PROGN
      (alert (STRCAT "ESCRIBIO:  "
		     "! "
		     $VALUE
		     " !"
		     "\nPOR FAVOR ESCRIBA UN NUMERO"
		     "\nINTENTELO DE NUEVO!!!!!"
		    )
      )
      (set_tile "contrahuella" "0.18")
      (mode_tile "contrahuella" 2)
      (PRINC)
    )
  )
)

(defun traerpunto ()
  ( setq p1 (getpoint "punto inicial"))
  )