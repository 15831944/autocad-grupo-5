;API
(defun delantero (pt_i largo_talle contorno_torax contorno_cuello ancho_hombro alto_sisa mirroring)
  (setq
    ancho ( + ( / contorno_torax 4 ) 3 ) ;holgura, sino sería imposible ponerse la ropa
    alto ( * largo_talle 1.5 );supongo que el largo total es la mitad del talle
    distancia_caida_hombro (sqrt (- (* ancho_hombro ancho_hombro) 9 ) ) ;3cm de caida vertical de hombro
    sexto_de_cuello (/ contorno_cuello 6)
    )
  (setq
    pt_cuello (list (+ (car pt_i) (- ancho sexto_de_cuello ) ) (+ (cadr pt_i) alto ) )
    pt_cuello_bajo (list (+ (car pt_i) ancho ) (+ (cadr pt_i) (- alto sexto_de_cuello ) ) )
    pt_dir_cuello (list (car pt_cuello) (cadr pt_cuello_bajo) )

    pt_hombro (list (- (car pt_cuello) distancia_caida_hombro ) (- (cadr pt_cuello) 3) )
    pt_sisa (list (car pt_i) (+ (cadr pt_i) (- alto (+ 3 alto_sisa) ) ) )
    pt_dir_hombro (list (car pt_hombro) (cadr pt_sisa) )

    pt_talle (list (+ (car pt_i) 3) (+ (cadr pt_i) (/ alto 3) ) )

    pt_bajada (list (car pt_i) (+ (cadr pt_i) 5) )
    pt_cambio_concavidad (list (+ (car pt_i) (/ ancho 2) ) (+ (cadr pt_i ) 2.5 ) )
    pt_final ( list (+ (car pt_i) ancho) (cadr pt_i) )
    pt_dir_bajada (list (car pt_cambio_concavidad) (cadr pt_bajada) )
    pt_dir_final (list (car pt_cambio_concavidad) (cadr pt_final) )

    pt_carteron_abajo (list (+ (car pt_final) 3) ( cadr pt_final) )
    pt_carteron_arriba (list (+ (car pt_cuello_bajo) 3) (- (cadr pt_cuello_bajo) 2) )
    pt_carteron_cierre (list (car pt_cuello_bajo) (- (cadr pt_cuello_bajo) 2) )

    pt_espejado_a (list (+ (car pt_i) (/ (+ ancho 3) 2 ) ) (cadr pt_i) )
    pt_espejado_b (list (car pt_espejado_a) (+ (cadr pt_espejado_a) alto ) )
    )
  (command "_pline" pt_cuello_bajo "A" "D" pt_dir_cuello pt_cuello "L" pt_hombro "A" "D" pt_dir_hombro pt_sisa "L" pt_talle pt_bajada "A" "D" pt_dir_bajada pt_cambio_concavidad "" )
  (setq obj_a (entlast))
  (command "_pline" pt_final "A" "D" pt_dir_final  pt_cambio_concavidad "" )
  (command "pedit" (entlast) "J" obj_a "" "" )
  (setq obj_b (entlast))
  (command "_pline" pt_final pt_carteron_abajo pt_carteron_arriba pt_carteron_cierre pt_cuello_bajo "")
  (command "pedit" (entlast) "J" obj_b "" "" )
  (if
    (= mirroring "s")
    (command "mirror" (entlast) "" pt_espejado_a pt_espejado_b "Y" )
    (prompt "\nNo mirroring")
    )
)
;wraper
(defun c:user_delantero ()
(setq
  _pt_i (getpoint "\nPunto de insercion: ")
  _largo_talle (getreal "\nLargo de talle: ")
  _contorno_torax (getreal "\nContorno de torax: ")
  _contorno_cuello (getreal "\nContorno de cuello: ")
  _ancho_hombro (getreal "\nAncho de hombro: ")
  _alto_sisa (getreal "\nAlto de sisa: ")
  _mirroring (getstring "\nEspejado (s/n) <n>: ")
  )
(delantero _pt_i _largo_talle _contorno_torax _contorno_cuello _ancho_hombro _alto_sisa _mirroring)
)
