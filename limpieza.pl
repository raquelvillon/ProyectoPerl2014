@lineas = <>; # <> abre el o los archivos ingresados por linea de comando 
foreach $linea (@lineas){
	$linea =~ s/^\s+|\s+$//g; #TRIM
if (length($linea)>0) { #quita las lineas vacias
	#print  length($linea). "$linea\n"; # tambien se lo puede escribir asi $linea."\n"
	 #saber si las oraciones de un parrafo que tienen enter de por medio 
	 $long=length($linea);
	 if ($long < 200) {
	 	print  length($linea). "$linea\n";
	 }
}

	
}
#   =~ s/^\s+|\s+$//g;  expresion que elimina de la izquierda y de la derecha los espacios en blanco 
#  el sombrero dice si el espacio en blanco es el primero 

#para poder tokenizar cada linea
@tokens=split(/ /,$lineas[0]);
print @tokens;

# clase record para poder almacenar la informaci[on que se saca