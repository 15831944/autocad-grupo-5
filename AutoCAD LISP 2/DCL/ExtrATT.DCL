extratt : dialog {
    label = "Extracci�n de Atributos"; // T�tulo del Cuadro de Di�logo  
    key = "titulo";
    : column  {
    	: list_box {                   // Lista de Nombres de Bloques   
        	key = "lista_bloques";
        	label = "Seleccione Bloque a Procesar:";
        	allow_accept = true;       // Pemite Selecci�n con DobleClic
        	multiple_select = false;   // No admite Selecci�n M�ltiple  
        	width = 40;
        	height = 12;
        	tabs = "33";           //Tabulador para ordenar las columnas
    	}
   		ok_cancel;                 //Botones Aceptar y Cancelar Standard
   		errtile;                   //Mensaje de Error Standard          
  	}
}
