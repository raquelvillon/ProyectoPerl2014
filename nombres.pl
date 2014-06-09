use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes

open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales
	@informacion=<datos>; #guarda cada linea dentro del arreglo "@informacion"
close (datos);

#todos los resultados se imprimirán aquí 
open (sal,">salida.txt");
	#guarda solo las lineas que tienen texto, se salta las lineas en blanco
	foreach $inf(@informacion){
		if (length($inf)>2) {
			push(@parrafos,$inf);
		
		
			
			buscaNombre($inf);
			buscaCiudadNatal($inf);
			#buscaEdad($oracion);
			#print sal "$oracion\n";
			
			
			#print sal $oraciones[$var];
			#buscarEstudios($oraciones[$var]);
			
	
		print sal "\n\n";
		undef(@oraciones);
	}
}
close (sal);

sub buscaCiudadNatal {
	if ($nom =~ /(nac[íi] (en|el|)|mi ciudad natal|lugar de nacimiento es (en|))([0-9A-Za-záéíóÁÉÍÓÚñ\.\s]+)*/) {
		$nombre=$4;
		print sal "Ciudad de Nacimiento: ".$4."\n";
		if($nombre=~/[Gg]uayaquil/){
			print sal "Ciudad: Guayaquil \n";
		}elsif ($nombre=~/[Bb]abahoyo/){
			print sal "Ciudad: Babahoyo \n";
		}elsif ($nombre=~/[Ll]oja/){
			print sal "Ciudad: Loja \n";
		}elsif ($nombre=~/[Qq]uito/){
			print sal "Ciudad: Quito \n";
		}elsif ($nombre=~/[Cc]uenca/){
			print sal "Ciudad: Quito \n";
		}
		
	}
}

sub buscaNombre {
	$nom=$_[0];
	if ($nom =~ /(nombre es |llamo )([A-Za-záéíóÁÉÍÓÚ\s]+)*/) {
		$nombre=$2;
		if($nombre=~/([A-Za-záéíóúÁÉÍÓÚS\s]+)*(tengo|nac[íi])/){
		print sal "Nombre: ".$1."\n";
		}else{
			print sal "Nombre: ".$nombre."\n";
		}
		
	}
}


sub buscarEstudios {
	$nom=$_[0];
	if ($nom =~ /([eE]studi[oeé] |estudiante )([A-Za-záéíóÁÉÍÓÚS|.\s]+)*/) {
		$estudios=$2;
		print sal $2."\n";
		if($estudios=~/([Ee][Ss][Pp][Oo][Ll]|Escuela)/){
			print sal "Universidad: ESPOL \n"
		}if($estudios=~/Ing ([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			print sal "Carrera:  $1 \n"
		}
		#	print sal "NO SE ENCONTRO \n";
		
	} 
}