;API
(defun trasero (pt_i largo_talle contorno_torax contorno_cuello ancho_hombro alto_sisa)
  (setq
    ancho ( + ( / contorno_torax 4 ) 3 ) ;holgura, sino sería imposible ponerse la ropa
    alto ( * largo_talle 1.5 );supongo que el largo total es la mitad del talle
    distancia_caida_hombro (sqrt (- (* ancho_hombro ancho_hombro) 9 ) ) ;3cm de caida vertical de hombro
    )
  (setq
    pt_cuello (list (+ (car pt_i) (- ancho (/ contorno_cuello 6) ) ) (+ (cadr pt_i) alto ) )
    pt_cuello_bajo (list (+ (car pt_i) ancho ) (+ (cadr pt_i) (- alto 2 ) ) )
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
    )
  (command "pline" pt_cuello_bajo "A" "D" pt_dir_cuello pt_cuello "L" pt_hombro "A" "D" pt_dir_hombro pt_sisa "L" pt_talle pt_bajada "A" "D" pt_dir_bajada pt_cambio_concavidad "" )
  (setq obj_a (entlast))
  (command "pline" pt_final "A" "D" pt_dir_final  pt_cambio_concavidad "" )
  (command "pedit" (entlast) "J" obj_a "" "" )
  (setq obj_b (entlast))
  (command "mirror" obj_b "" pt_cuello_bajo pt_final "" )
  (command "pedit" (entlast) "J" obj_b "" "" )
)
;wraper
(defun c:user_trasero ()
  (setq
    _pt_i (getpoint "\nPunto de insercion: ")
    _largo_talle (getreal "\nLargo de talle: ")
    _contorno_torax (getreal "\nContorno de torax: ")
    _contorno_cuello (getreal "\nContorno de cuello: ")
    _ancho_hombro (getreal "\nAncho de hombro: ")
    _alto_sisa(getreal "\nAlto de sisa: ")
  )
  (trasero _pt_i _largo_talle _contorno_torax _contorno_cuello _ancho_hombro _alto_sisa)
)
