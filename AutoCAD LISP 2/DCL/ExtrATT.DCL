extratt : dialog {
    label = "Extracción de Atributos"; // Título del Cuadro de Diálogo  
    key = "titulo";
    : column  {
    	: list_box {                   // Lista de Nombres de Bloques   
        	key = "lista_bloques";
        	label = "Seleccione Bloque a Procesar:";
        	allow_accept = true;       // Pemite Selección con DobleClic
        	multiple_select = false;   // No admite Selección Múltiple  
        	width = 40;
        	height = 12;
        	tabs = "33";           //Tabulador para ordenar las columnas
    	}
   		ok_cancel;                 //Botones Aceptar y Cancelar Standard
   		errtile;                   //Mensaje de Error Standard          
  	}
}
