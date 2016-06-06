(defun toroide ( punto multiplicador )
   (command "torus" punto (* 11.5 multiplicador ) (* 1 multiplicador ) )
)

(DEFUN capa (nombre color)
  (ENTMAKE (LIST
    (CONS 0 "LAYER")
    (CONS 100 "AcDbSymbolTableRecord")
    (CONS 100 "AcDbLayerTableRecord")
    (CONS 2 nombre)
    (CONS 70 0)
    (CONS 62 color)
    (CONS 6 "CONTINUOUS")
    )
  )
)

(defun c:termo ()
; seteo de variables
  (setq
    punto_de_insercion (getpoint "\n Ingrese punto de insercion")
    altura (getreal "\n Ingrese la altura de la bottella: ")
    multiplicador ( / altura 100 )
  )
  ; seteo configuraciones
  (command "osmode" 0 )
  (command "surftab1" 20 )
  (command "surftab2" 20 )
  (command "isolines" 20 )


  ;;;crear capa
  (capa "TAPA" 1)
  (capa "CUERPO" 4)
  (capa "aux" 2)

  ;;; deprecate
  ;;; (command "ucs" "X" -90 )

;creo el cuerpo
  (command "cylinder" punto_de_insercion ( * 11.5 multiplicador ) ( * 70 multiplicador ) )
  ;radio por multi y altura por multi
    (setq cuerpo (entlast))
  ;moverlo de capa




  ; Creo toroides
  (toroide
    (list
      ( car punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 7 ) )
    )
    multiplicador
  )
  (setq toroide_abajo ( entlast ) )
  (toroide
    (list
      ( car punto_de_insercion)
      ( cadr punto_de_insercion )
      (+ (caddr punto_de_insercion) (* multiplicador 63 ) )
    )
    multiplicador
  )
  (setq toroide_arriba ( entlast ) )

  (command "subtract" cuerpo "" toroide_arriba toroide_abajo "")

  ; deprecate
  ;(command "ucs" "w")

  ;creo los circulos
  ;moverlos de capa
  ;seleccionarlos todos dentro de una capa
  ;substraer
  
  )
