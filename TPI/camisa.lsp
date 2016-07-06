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

(defun c:camisas ()
  (command "OSNAP" "OFF")
  (prompt "\nSolo por si acaso, desactivamos el OSNAP por vos")
  ;(LoadDialog_no_name)
  (load "auxiliares.lsp" "\nNo se pudo cargar la libreria de funciones")
  (load "manga.lsp" "\nNo se pudo cargar la libreria de manga")
  (load "canesu.lsp" "\nNo se pudo cargar la libreria de canesu")
  (load "trasero.lsp" "\nNo se pudo cargar la libreria de trasero")
  (load "delantero.lsp" "\nNo se pudo cargar la libreria de delantero")
  (load "tirilla.lsp" "\nNo se pudo cargar la libreria de tirilla")
  (load "solapa.lsp" "\nNo se pudo cargar la libreria de solapa")
  )
