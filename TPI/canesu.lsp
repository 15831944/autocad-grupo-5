;API
(defun canesu(pt_i contorno_cuello ancho_hombro contorno_torax alto_de_canesu)
      (setq
        ancho (+ (/ contorno_torax 2) 6 ) ;holgura, sino sería imposible ponerse la ropa
        distancia_caida_hombro (sqrt (- (* ancho_hombro ancho_hombro) 9 ) ) ;3cm de caida vertical de hombro
        )
      (setq
        pt_cuello_1 (list (+ (car pt_i) (- (/ ancho 2) (/ contorno_cuello 6) ) ) (+ (cadr pt_i) alto_de_canesu) )
        pt_cuello_2 (list (+ (car pt_i) (+ (/ ancho 2) (/ contorno_cuello 6) ) ) (+ (cadr pt_i) alto_de_canesu) )
        pt_cuello_bajo (list (+ (car pt_i) (/ ancho 2) ) (+ (cadr pt_i) (- alto_de_canesu 2 ) ) )

        pt_f_horizontal (list (+ (car pt_i) ancho) (cadr pt_i) )
        pt_aux (list (+ (car pt_i) ancho) (cadr pt_i) )
        pt_medio_horizontal (list (+ (car pt_i) (/ ancho 2) ) (cadr pt_i) )
        )
      (setq
        pt_hombro_1 (list (- (car pt_cuello_1) distancia_caida_hombro) (- (cadr pt_cuello_1) 3 ) )
        pt_hombro_2 (list (+ (car pt_cuello_2) distancia_caida_hombro) (- (cadr pt_cuello_2) 3 ) )
        )
      (setq
        pt_dir_hombro_1 (list (car pt_hombro_1) (cadr pt_i) )
        pt_dir_hombro_2 (list (car pt_hombro_2) (cadr pt_i) )
        )

      (command "pline" pt_hombro_2 pt_cuello_2 "A" "D" pt_cuello_bajo pt_cuello_bajo pt_cuello_1 "L" pt_hombro_1 "A" "D" pt_dir_hombro_1 pt_i "L" pt_f_horizontal "")
      (setq a (entlast))
      (command "pline" pt_hombro_2 "A" "D" pt_dir_hombro_2 pt_f_horizontal "" )
      (command "pedit" a "J" (entlast) "" "")

  )

;user
(defun c:user_canesu()
  (setq
    punto_inicial (getpoint "\nPunto inicial: ")
    _contorno_cuello (getreal "\nContorno de cuello: ")
    _ancho_hombro (getreal "\nAncho de hombro: ")
    _contorno_torax (getreal "\nContorno de torax: ")
    _alto_canesu (getreal "\nAlto de canesu: ")
  )
  (canesu punto_inicial _contorno_cuello _ancho_hombro _contorno_torax _alto_canesu)
)
