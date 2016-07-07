(defun get_data ()
 (setq
   _contorno_cuello (get_tile "_contorno_cuello")
   _ancho_hombro (get_tile "_ancho_hombro")
   _largo_manga (get_tile "_largo_manga")
   _alto_sisa (get_tile "_alto_sisa")
   _contorno_sisa (get_tile "_contorno_sisa")
   _contorno_torax (get_tile "_contorno_torax")
   _largo_talle (get_tile "_largo_talle")
   )
)

(defun obtener_datos ()
 (setq
   _pt_i (list 0 0 )
   _contorno_cuello (getreal "\nIngrese el contorno de cuello: ")
   _ancho_hombro (getreal "\nIngrese el ancho de hombro: ")
   _largo_manga (getreal "\nIngrese el largo de manga: ")
   _alto_sisa (getreal "\nIngrese el alto de la sisa: ")
   _contorno_sisa (getreal "\nIngrese el contorno de sisa: ")
   _contorno_torax (getreal "\nIngrese el contorno de torax: ")
   _largo_talle (getreal "\nIngrese el largo de talle: ")
   )
)


(defun LoadDialog_no_name( / dcl_id)
   (defun init_handler()   ;Initialation_Code
       (princ)
   );End of Initial Function
   (defun set_data() ;Start Set function
       (princ)
   );End of Set function
   (defun get_data() ;Start Get function
       (princ)
   );End of Get function
   (if (setq dcl_id (load_dialog "camisa.dcl"))
       (if (new_dialog "no_name" dcl_id)
           (progn
              (setq result nil)
              (init_handler)
              (set_data)
              (action_tile "accept" "(get_data)(done_dialog)(setq result T)")
              (start_dialog)
              (unload_dialog dcl_id)
              result
            )
        )
    )
)

(defun c:camisas_visual ()
  (command "OSNAP" "OFF")
  (prompt "\nSolo por si acaso, desactivamos el OSNAP por vos")
  (LoadDialog_no_name)
  (load "auxiliares.lsp" "\nNo se pudo cargar la libreria de funciones")
  (load "manga.lsp" "\nNo se pudo cargar la libreria de manga")
  (load "canesu.lsp" "\nNo se pudo cargar la libreria de canesu")
  (load "trasero.lsp" "\nNo se pudo cargar la libreria de trasero")
  (load "delantero.lsp" "\nNo se pudo cargar la libreria de delantero")
  (load "tirilla.lsp" "\nNo se pudo cargar la libreria de tirilla")
  (load "solapa.lsp" "\nNo se pudo cargar la libreria de solapa")
)

(defun c:camisas ()
  (command "OSNAP" "OFF")
  (prompt "\nSolo por si acaso, desactivamos el OSNAP por vos")
  (load "auxiliares.lsp" "\nNo se pudo cargar la libreria de funciones")
  (load "manga.lsp" "\nNo se pudo cargar la libreria de manga")
  (load "canesu.lsp" "\nNo se pudo cargar la libreria de canesu")
  (load "trasero.lsp" "\nNo se pudo cargar la libreria de trasero")
  (load "delantero.lsp" "\nNo se pudo cargar la libreria de delantero")
  (load "tirilla.lsp" "\nNo se pudo cargar la libreria de tirilla")
  (load "solapa.lsp" "\nNo se pudo cargar la libreria de solapa")
  (obtener_datos)
  (setq
    pt_i_trasero (list 0 0)
    pt_i_delantero_1 (list (* ( + ( / _contorno_torax 4 ) 3 ) 2) 0 )
    pt_i_delantero_2 (list (+ (car pt_i_delantero_1) (+ (/ _contorno_torax 4 ) 6 ) ) (cadr pt_i_delantero_1 ) )
    pt_i_manga_1 (list 0 (* _largo_talle 1.5 ) )
    pt_i_manga_2 (list (- _contorno_sisa 10) (cadr pt_i_manga_1) )
    pt_i_canesu (list (+ (- _contorno_sisa 10) (car pt_i_manga_2) ) (cadr pt_i_manga_1) )
    pt_i_tirilla (list 0 (+ (cadr pt_i_manga_1) (+ (+ _largo_manga (/ _alto_sisa 3) ) 4) ) )
    pt_i_solapa (list _contorno_cuello (cadr pt_i_tirilla) )
    )
  (crear_capa "trasero" 1)
  (capa "trasero")
  (trasero pt_i_trasero _largo_talle _contorno_torax _contorno_cuello _ancho_hombro _alto_sisa)

  (crear_capa "delantero_izq" 2)
  (capa "delantero_izq")
  (delantero pt_i_delantero_1 _largo_talle _contorno_torax _contorno_cuello _ancho_hombro _alto_sisa "n")

  (crear_capa "delantero_der" 3)
  (capa "delantero_der")
  (delantero pt_i_delantero_2 _largo_talle _contorno_torax _contorno_cuello _ancho_hombro _alto_sisa "s")

  (crear_capa "manga_izq" 4)
  (capa "manga_izq")
  (manga pt_i_manga_1 _contorno_sisa _alto_sisa _largo_manga)

  (crear_capa "manga_der" 5)
  (capa "manga_der")
  (manga pt_i_manga_2 _contorno_sisa _alto_sisa _largo_manga)

  (crear_capa "canesu" 6)
  (capa "canesu")
  (canesu pt_i_canesu _contorno_cuello _ancho_hombro _contorno_torax _alto_sisa)

  (crear_capa "tirilla" 7)
  (capa "tirilla")
  (tirilla pt_i_tirilla _contorno_cuello)

  (crear_capa "solapa" 8)
  (capa "solapa")
  (solapa pt_i_solapa _contorno_cuello)
)
