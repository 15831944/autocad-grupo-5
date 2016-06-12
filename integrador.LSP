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

(defun cambiar_capa (nombre)
  (setvar "CLAYER" nombre)
)

(defun crear_agarre (pt_t1 pt_t2 ptc pta multi cuerpo)
;Magic Function
;debería hacer todo solo
  (setq oldLayer ( getvar "CLAYER" ) ) ;tomo la capa actual
  (cambiar_capa "AUX") ;cambio de capa

  ;; ME MANTENGO EN LA CAPA AUX

  (command "circle" ptc (* multi 1.5) ) ;creo el circulo inicial
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

 ;; TIENE PROBLEMAS, CREO QUE ES POR EL UCS
(defun crear_oblicuo ( pt_a pt_b pt_c pt_d )
  ; forma de los puntos
  ; ptd--ptc
  ; |       \
  ; |        \
  ; pta_____ptb
  (setq oldLayer ( getvar "CLAYER" ) ) ;tomo la capa actual
  (cambiar_capa "TAPA") ;cambio de capa
  (
  (command "pline" pt_a pt_b pt_c pt_d pt_a "Close")
  (setq _oblic (entlast))
  (command "revolve" _oblic "" pt_a pt_d "" )
  (cambiar_capa oldLayer) ;regreso a la capa de donde vine
)

(defun c:termo ()
; seteo de variables
  (setq
    punto_de_insercion (getpoint "\n Ingrese punto de insercion: ")
    altura (getreal "\n Ingrese la altura del termo: ")
    multiplicador ( / altura 100 )
  )
  ;puntos auxiliares
  (setq
    punto_fin_cuerpo_cilindro ( list
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 70 ) ) )
    
    punto_fin_cuerpo_oblicuo ( list
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 85 ) ) )
    
    punto_fin_tapa ( list
      ( car  punto_de_insercion )
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 100 ) ) )
  )
  ;mas putnos auxiliares, no se si los define on the fly
  (setq
    punto_fin_cuerpo_cilindro_horizontal ( list
      (+ ( car punto_fin_cuerpo_cilindro ) (* multiplicador 11.5 ) ) ;
      (cadr punto_fin_cuerpo_cilindro )
      (caddr punto_fin_cuerpo_cilindro ) )
    
    punto_fin_cuerpo_oblicuo_horizontal ( list
      (+ ( car punto_fin_cuerpo_oblicuo ) (* multiplicador 7.5 ) ) ;
      (cadr punto_fin_cuerpo_oblicuo )
      (caddr punto_fin_cuerpo_oblicuo ) )
    
    punto_circulo_agarre ( list
      (+ ( car punto_de_insercion ) (* multiplicador 11.5 ))
      ( cadr punto_de_insercion )
      ( + ( caddr punto_de_insercion ) ( * multiplicador 14 ) ) )
    
    punto_de_giro_array ( list
        ( car punto_de_insercion )
        ( cadr punto_de_insercion )
        ( + ( caddr punto_de_insercion ) ( * multiplicador 14 ) ) )
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
  (oblicuo
    punto_fin_cuerpo_cilindro
    punto_fin_cuerpo_cilindro_horizontal
    punto_fin_cuerpo_oblicuo_horizontal
    punto_fin_cuerpo_oblicuo )

  ;No debería haber otra cosa que el cilindro de cuerpo con los huecos hechos y
  ;el oblicuo, por lo que agarro todo y le hago un union
  (setq todo (ssget "X" ))
  (command "union" todo "" )

  ;se crea la tapa en su capa
  ( crear_tapa punto_fin_cuerpo_oblicuo multiplicador )
)

;Funcion de prueba de funcionamiento de func. auxiliares (toroide, oblicuo, array)
(defun c:prueba_toroide ()
  (setq
    pt_i (getpoint "\n Ingrese punto de insercion de toroide")
    multi (getreal "\n Ingrese el multiplicador (0;1]: ")
  )
  (command "torus" pt_i (* 11.5 multi ) (* 1 multi ) )
)

(defun c:prueba_array ()
  (setq
    pt_i (getpoint "\n Ingrese punto de creacion del circulo")
    pt_a (getpoint "\n Ingrese punto de giro del arreglo")
    cant (getint "\n Ingrese la cantidad total de entidades: ")
    multi (getreal "\n Ingrese el multiplicador (0;1]: ")
  )
  (command "circle" pt_i (* multi 3) ) ;creo el circulo inicial
  (setq circ (entlast)) ;retengo su identidad
  (command "_.array" circ "" "P" pt_a cant "" "y" ) ;creo el array
  (setq circ ( ssget "X" '(( 0 . "CIRCLE" )) ) ) ;almaceno todos los circulos
  (command "extrude" circ "" (* multi 42) 0 )
)

(defun c:prueba_oblicuo ()
  (setq
    pt_a (getpoint "\n Ingrese punto A: ")
    pt_b (getpoint "\n Ingrese punto B: ")
    pt_c (getpoint "\n Ingrese punto C: ")
    pt_d (getpoint "\n Ingrese punto D: ") )
  (command "pline" pt_a pt_b pt_c pt_d pt_a "Close")
  (setq _oblic (entlast))
  (command "revolve" _oblic "" pt_a pt_d "" )
)
