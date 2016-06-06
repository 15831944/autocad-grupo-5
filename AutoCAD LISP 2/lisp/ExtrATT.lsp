;;; ExtATT.LSP Aplicación para extracción de Atributos de Bloques  
;;; a una Tabla Excel. Ejemplo utilizando ActiveX                  

;;; Inicialización: Cargar funciones ActiveX y obtener el objeto    
;;; Documento Actual                                                
(vl-load-com)
(setq *EsteDibujo* (vla-get-ActiveDocument (vlax-get-acad-object)))

;;;Verifica si el bloque tiene atributos
(defun CompruebaAtributos (valor)
  (if (not (equal (cdr (nth (atoi valor) *listaBloques*)) "ATRIB"))
    (set_tile "error" "El bloque seleccionado no posee atributos")
    (set_tile "error" "")
  ) ;_ fin de if
) ;_ fin de defun

;;;Función asignada al botón Aceptar
(defun ExtrATT (valor)
  (if *listaBloques*
    (if (not (equal (cdr (nth (atoi valor) *listaBloques*)) "ATRIB")
        ) ;_ fin de not
      (set_tile "error"
                "El bloque seleccionado no posee atributos"
      ) ;_ fin de set_tile
      (progn (set_tile "error" "Espere, por favor...")
             (Lista->Excel
               (SelBloque (car (nth (atoi valor) *listaBloques*)))
             ) ;_ fin de Lista->Excel
             (setq *Posicion* (done_dialog 1))
)))) ;_ fin de defun

;;;Función que devuelve los integrantes de la Colección "BLOCKS".         
;;;Devuelve una lista de los nombres de los objetos que la integran       
(defun ListaNombres (/ ListaBlq)
  (vlax-for obj (vlax-get-property *EsteDibujo* "Blocks")
    (if
      (and
        (not (wcmatch (vlax-get-property obj "Name") "`**,*|*"))
        (equal (vlax-get-property obj "IsXRef") :vlax-false)
      ) ;_ fin de and
      (setq
        listaBlq
         (cons
           (cons
             (vlax-get-property obj "Name")
             (if (TieneAtributos obj) "ATRIB" "")
           ) ;_ fin de cons
           ListaBlq
  )))) ;_ fin de vlax-for
  (setq
    ListaBlq
    (vl-sort listaBlq '(lambda (n1 n2) (< (car n1) (car n2))))
  ) ;_ fin de setq
  ListaBlq
) ;_ fin de defun

;;; Función que discrimina entre los bloques con Atributos y los que
;;; no los tienen.                                                  
(defun TieneAtributos (objDefBloque / resultado)
  (vlax-for obj objDefBloque
    (if
      (equal (vlax-get-property obj "ObjectName")
             "AcDbAttributeDefinition"
      ) ;_ fin de equal
      (setq resultado t)
  )) ;_ fin de vlax-for
  resultado
) ;_ fin de defun

;;;Crea el conjunto de selecció y lanza su procesamiento
(defun SelBloque (nombre / ss cont ename listaBloques)
  (setq cont 0)
  (if (setq ss (ssget "X" (list (cons 0 "INSERT") (cons 2 nombre))))
    (while (setq ename (ssname ss cont))
      (setq listaBloques
             (cons (LeeAtribX (vlax-ename->vla-object ename))
                   listaBloques
             ) ;_ fin de cons
      ) ;_ fin de setq
      (setq cont (1+ cont))
    ) ;_ fin de while
  ) ;_ fin de if
  listaBloques
) ;_ fin de defun

;;; Funciones para gestión del cuadro de diálogo                       
(defun CargaDialogo (/ oErr)
  (setq oErr *error* *error* apl-err)
  (if (not *Posicion*)(setq *Posicion* (list -1 -1)))
  (if (minusp (setq dcl_id (load_dialog "d:/facultadii/EXTRACCION DE ATRIBUTOS.DCL")))
    (alert "No se encuentra el archivo de diálogo EXTRATT.DCL")
    (if (not (new_dialog "extratt" dcl_id "" *Posicion*))
      (alert "No se encuentra la \ndefinición de diálogo EXTRATT")
      (progn
        (if (setq *listaBloques* (ListaNombres))
          (progn
            (start_list "lista_bloques")
            (mapcar 'add_list
              (mapcar
                '(lambda (term) (strcat (car term) "\t" (cdr term)))
                *listaBloques*) ;_ fin de mapcar
            ) ;_ fin de mapcar
            (end_list)
          ) ;_ fin de progn
          (set_tile "error" "No hay bloques en el Dibujo Actual")
        ) ;_ fin de if
        (action_tile "lista_bloques" "(CompruebaAtributos $value)")
        (action_tile "accept" "(ExtrATT (get_tile \"lista_bloques\"))")
        (action_tile "cancel" "(setq *Posicion* (done_dialog 0))")
        (start_dialog)
        (unload_dialog dcl_id)
      ) ;_ fin de progn
    ) ;_ fin de if
  ) ;_ fin de if
  (setq *error* oErr)
  (princ)
) ;_ fin de defun

;;;Añade un Comando tipo AutoCAD que invoca la función                 
(vlax-add-cmd "AtrEX" 'CargaDialogo)

(alert "Programa de Extracción de ATRIBUTOS\n\nTeclee ATREX para ejecutar")









;;;LeeAtribX.LSP
;;;Función para extracción de datos a partir de objetos ActiveX
(defun LeeAtribX (objBloque / minimo maximo listaDatos)
  (vl-load-com)
  (if (equal (vlax-get-property objBloque "HasAttributes")
             :vlax-true
      ) ;_ fin de equal
    (progn (vla-GetBoundingBox objBloque 'minimo 'maximo)
           (setq listaDatos
                  (cons (cons "ExtMax" (vlax-safearray->list maximo))
                        listaDatos
                  ) ;_ fin de cons
           ) ;_ fin de setq
           (setq listaDatos
                  (cons (cons "ExtMin" (vlax-safearray->list minimo))
                        listaDatos
                  ) ;_ fin de cons
           ) ;_ fin de setq
           (foreach atributo
                    (vlax-safearray->list
                      (vlax-variant-value (vla-GetAttributes objBloque))
                    ) ;_ fin de vlax-safearray->list
             (setq listaDatos (cons (Procesa atributo) listaDatos))
           ) ;_ fin de foreach
           (setq listaDatos
                  (cons (cons "Bloque"
                              (vlax-get-property objBloque "Name")
                        ) ;_ fin de cons
                        listaDatos
                  ) ;_ fin de cons
           ) ;_ fin de setq
    ) ;_ fin de progn
  ) ;_ fin de if
  listaDatos
  ;;valor devuelto por la función
) ;_ fin de defun

(defun Procesa (obj /)
  (cons (vlax-get-property obj "TagString")
        (vlax-get-property obj "TextString")
  ) ;_ fin de cons
) ;_ fin de defun
















;;;Demostración del papel de Visual LISP como Cliente ActiveX
;;;(c) 2000 R. Togores, Santander
;;;----------------------------------------------------------------------

;;;Función para tratamiento de errores
;;;En caso de error libera los objetos VLA:
(defun apl-err (msg)
  (TerminaExcel)
  (prompt msg)
  (setq *error* oer)
) ;_ fin de defun

;;;función InciaExcel
;;;Obtiene el objeto Aplicación Excel o lo crea
;;;en caso de que no estuviera ya activa y sigue
;;;la jerarquía de objetos hasta el objeto CELDA
(defun IniciaExcel ()
  (setq *AplExcel*        (vlax-get-or-create-object "excel.application")
        *ColeccionLibros* (vlax-get-property *AplExcel* "Workbooks")
        *NuevoLibro*      (vlax-invoke-method *ColeccionLibros* "add")
        *ColeccionHojas*  (vlax-get-property *NuevoLibro* "Sheets")
        *Hoja1*      (vlax-get-property *ColeccionHojas* "Item" 1)
        *CeldasExcel*     (vlax-get-property *Hoja1* "Cells")
  ) ;_ fin de setq
  (vla-put-visible *AplExcel* :vlax-true)
) ;_ fin de defun
;;;Función TerminaExcel, libera la memoria
;;;ocupada por los objetos VLA de Excel:
(defun TerminaExcel ()
  (vlax-release-object *CeldasExcel*)
  (vlax-release-object *Hoja1*)
  (vlax-release-object *ColeccionHojas*)
  (vlax-release-object *NuevoLibro*)
  (vlax-release-object *ColeccionLibros*)
  (vlax-release-object *AplExcel*)
) ;_ fin de defun

;;;Función DatoCelda:
;;;introduce el valor indicado en la celda
;;;que corresponde a la fila y columna que
;;;recibe como argumento
(defun DatoCelda (fila col valor)
  (vlax-put-property *CeldasExcel* "Item" fila col
    (vl-princ-to-string valor)
  ) ;_ fin de vlax-put-property
) ;_ fin de defun

;;;Función ProcesaFila:
;;;Invoca para cada campo de la fila la función
;;;que escribe los datos
(defun ProcesaFila (fila numFila / numCol)
  (setq numCol 0)
  (foreach campo fila
    (DatoCelda numFila (setq numCol (1+ numCol))(cdr campo))
  ) ;_ fin de foreach
) ;_ fin de defun

;;;Función ProcesaTabla:
;;;Primero escribe la fila de títulos utilizando
;;;los campos clave de la primera sublista, después
;;;invoca la función ProcesaFila para cada sublista
(defun ProcesaTabla (lista / numFila)
  ;;llena la fila 1 con las claves de las listas de asociación:
  (setq numFila 1 numCol 0)
  (foreach campo (car lista)
    (DatoCelda numFila (setq numCol (1+ numCol))(car campo))
  ) ;_ fin de foreach
  ;;llena el resto de la tabla con los valores asociados a las claves:
  (while (setq fila (car lista))
    (setq numFila (1+ numFila) lista (cdr lista))
    (ProcesaFila fila numFila)
  ) ;_ fin de while
) ;_ fin de defun


;;;Función Lista->Excel
;;;Realiza los siguientes procesos:
;;;1.- (vl-load com) asegura que las funciones VLAX- estén cargadas
;;;2.- (IniciaExcel) establece la conexión con la tabla de excel
;;;3.- (ProcesaTabla lista) llena la tabla con los contenidos de
;;;    la lista que recibe como argumento
;;;4.- (TerminaExcel) cierra el vínculo con la tabla
(defun Lista->Excel (lista /
                     ;variables declaradas como locales:
                     *CeldasExcel* *Hoja1* *ColeccionHojas*  *NuevoLibro*
                     *ColeccionLibros* *AplExcel*
                    )
  ;;sustituye la rutina de error original por la nueva
  (setq oer *error* *error* apl-err)
  (vl-load-com)        ;;carga las funciones VLAX-
  (IniciaExcel)        ;;establece la comunicación con Excel
  (ProcesaTabla lista) ;;escribe la tabla Excel
  (TerminaExcel)       ;;libera los objetos Excel
  (setq *error* oer)   ;;restablece la rutina de error original
) ;_ fin de defun