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
  (setvar "CLAYER" nombre)
)

(defun crear_agarre (pt_t1 pt_t2 ptc pta multi cuerpo)
;Magic Function
;debería hacer todo solo
  (setq oldLayer ( getvar "CLAYER" ) ) ;tomo la capa actual
  (cambiar_capa "AUX") ;cambio de capa

  ;; ME MANTENGO EN LA CAPA AUX

  (command "circle" ptc (* multi 3) ) ;creo el circulo inicial
  (setq circ (entlast)) ;retengo su identidad
  (command "_.array" circ "" "P" pta 15 "" "y" ) ;creo el array
  (setq circ ( ssget "X" '(( 0 . "CIRCLE" )) ) ) ;almaceno todos los circulos
  (command "extrude" circ "" (* multi 42) 0 ) ;hago el extrude

  (toroide pt_t1 multi);creo toroide de abajo
  (toroide pt_t2 multi);creo toroide de arriba


  (setq capa_aux (ssget "X" '((8 . "AUX")))) ;selecciono todo en la capa
  (command "subtract" cuerpo "" capa_aux "") ;lo substraigo
  (cambiar_capa oldLayer) ;regreso a la capa de donde vine
)

(defun crear_tapa (pt multi)
  (setq oldLayer ( getvar "CLAYER" ) ) ;tomo la capa actual
  (cambiar_capa "TAPA") ;cambio de capa
  (command "cylinder" pt ( * multi 7.5 ) ( * multi 15 ))
  (cambiar_capa oldLayer)
)

(defun crear_oblicuo (pta ptb ptc ptd multi)
  ; forma de los puntos
  ; ptd--ptc
  ; |       \
  ; |        \
  ; pta_____ptb
  (setq oldLayer ( getvar "CLAYER" ) ) ;tomo la capa actual
  (cambiar_capa "CUERPO") ;cambio de capa
  (command "pline" pta ptb ptc ptd pta "Close")
  (setq _oblic (entlast))
  ;;(command "revolve" _oblic pta ptd ) ---------------> TODO estoy adivinando como se hace
  (cambiar_capa oldLayer)
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
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 70 ) ) ) )
    punto_fin_cuerpo_oblicuo ( list(
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 85 ) ) ) )
    punto_fin_tapa ( list(
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 100 ) ) ) )
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
    punto_circulo_agarre ( list(
      (+ ( car punto_de_insercion ) (* multiplicador 11.5 ))
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 14 ) )
      ))
      punto_de_giro_array ( list(
        ( car punto_de_insercion )
        ( cadr punto_de_insercion )
        ( + ( caddr punto_de_insercion ) ( * multiplicador 14 ) )
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
  (command "change" cuerpo "" "p" "la" "CUERPO" "")

  (crear_agarre
    ;punto toroide 1
    (list (car punto_de_insercion) (cadr punto_de_insercion) (+ (caddr punto_de_insercion)(* multiplicador 7)))
    ;punto toroide 2
    (list (car punto_de_insercion) (cadr punto_de_insercion ) (+ (caddr punto_de_insercion)(* multiplicador 63 )))
    ;punto de insercion del circulo
    punto_circulo_agarre
    ;pta punto de giro del array
    punto_de_giro_array
    multiplicador
    cuerpo)

  ;se crea parte oblicua
  (crear_oblicuo
    punto_fin_cuerpo_cilindro
    punto_fin_cuerpo_cilindro_horizontal
    punto_fin_cuerpo_oblicuo_horizontal
    punto_fin_cuerpo_oblicuo
    multiplicador
    )

  ;No debería haber otra cosa que el cilindro de cuerpo con los huecos hechos y
  ;el oblicuo, por lo que agarro todo y le hago un union
  (setq capa_cuerpo (ssget "X" '((8 . "CUERPO"))))
  (command "union" capa_cuerpo "" )

  ;se crea la tapa en su capa
  ( crear_tapa punto_fin_cuerpo_oblicuo multiplicador )
  )
