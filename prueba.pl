#abre un txt y guarda las lineas en el array informacion
open (datos,"informacion.txt");
@informacion=<datos>;
close (datos);
#de cada linea en @informacion separa las cadenas separadas por una coma
foreach (@informacion){
	@oraciones = split(/\,+/, $informacion[0]);
}
#hash que maneja la información del estudiante
%estudiante=(nombre,"",estudio,"",direccion,"inicia");

foreach $oracion (@oraciones){
	#print $oracion;
	####### -----PRUEBAS---######
	#busqueda del nombre
	if ($oracion =~ /nombre es ([0-9a-zA-Z\s]+)*/) {
		$estudiante{nombre}=$1;
	}
	if ($oracion =~ /estudio en la ([0-9a-zA-Z]+)/) {
		$estudiante{estudio}=$1;
	}
	if ($oracion =~ /vivo en ([0-9a-zA-Z]+)/) {
		$estudiante{direccion}=$1;
	}
}
print "Nombre: $estudiante{nombre} \nEstudios: $estudiante{estudio} \nDireccion: $estudiante{direccion} ";

