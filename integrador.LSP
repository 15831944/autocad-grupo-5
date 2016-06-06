(defun toroide ( punto multiplicador )
   (command "torus" punto (* 11.5 multiplicador ) (* 1 multiplicador ) )
)

(defun capa (nombre color)
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

(defun cambiar_capa (nombe)

)

(defun seleccionar_todos_de_la_capa ()

)

(defun crear_agarre (pt pta multi)
  (command "circle" pt (* multi 3) )
  (setq circ (entlast))
  (command "array" circ "" "P" "" pta 15 "" "y" "" )
  
)

(defun crear_tapa (pt multi)
  (command "cylinder" pt ( * multi 7.5 ) ( * multi 15 ))
)

(defun c:termo ()
; seteo de variables
  (setq
    punto_de_insercion (getpoint "\n Ingrese punto de insercion")
    altura (getreal "\n Ingrese la altura de la bottella: ")
    multiplicador ( / altura 100 )
  )
  ;puntos auxiliares
  (setq
    punto_fin_cuerpo_cilindro ( list(
      ( car  punto_de_insercion)
      ( + ( cadr punto_de_insercion ) ( * multiplicador 70 ) ) ) )
    punto_fin_cuerpo_oblicuo ( list(
      ( car  punto_de_insercion)
      ( + ( cadr punto_de_insercion ) ( * multiplicador 85 ) ) ) )
    punto_fin_tapa ( list(
      ( car  punto_de_insercion)
      ( + ( cadr punto_de_insercion ) ( * multiplicador 100 ) ) ) )
  )
  ;mas putnos auxiliares, no se si los define on the fly
  (setq
    punto_fin_cuerpo_cilindro_horizontal ( list(
      (+ ( car punto_fin_cuerpo_cilindro ) (* multiplicador 11.5 )) ;
      (cadr punto_fin_cuerpo_cilindro )
      (caddr punto_fin_cuerpo_cilindro )
      ))
    punto_fin_cuerpo_oblicuo_horizontal ( list(
      (+ ( car punto_fin_cuerpo_oblicuo ) (* multiplicador 7.5 )) ;
      (cadr punto_fin_cuerpo_oblicuo )
      (caddr punto_fin_cuerpo_oblicuo )
      ))
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


  (cambiar_capa "aux")
  ;creo un circulo
  ;hago un array polar
  ;selecciono todos los circulos o todo en la capa
  ;extrude

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

  ;selecciono todo en la capa
  ;substract de todo lo seleccionado
  ;deprecate
  (command "subtract" cuerpo "" toroide_arriba toroide_abajo "")

  ()
  ;se crea la tapa y se mueve a su capa
  ( crear_tapa punto_fin_cuerpo_oblicuo )
  (setq tapa (entlast))
  (command "change" tapa "" "p" "la" "TAPA" "")
  )