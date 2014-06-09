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
			buscarEstudios($inf);
			#buscaEdad($oracion);
			#print sal "$oracion\n";
			
			
			#print sal $oraciones[$var];
			#buscarEstudios($oraciones[$var]);
			
	
		print sal "\n\n";
		undef(@oraciones);
	}
	}
close (sal);


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
	if ($nom =~ /([eE]studi[oeé] |estudiante )([A-Za-záéíóÁÉÍÓÚS,.\s]+)*/) {
		$estudios=$2;
		#print sal $2."\n";
		
		if($estudios=~/([Ii]ngenier[íi]a|Ing\.)([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera:  Ingeniería $1 \n"
			}else{
				print sal "Carrera:  Ingeniería $carrera \n"
			}
			
			
		}elsif(/(carrera (es|de estudio|de))([A-Za-záéíóÁÉÍÓÚS\s]+)*/){
			$carrera=$2;
			if($carrera=~/([A-Za-záéíóÁÉÍÓÚS\s]+)*(en ESPOL|en la Escuela|en la ESPOL)/){
				print sal "Carrera:  Ingeniería $1 \n"
			}else{
				print sal "Carrera:  $carrera \n"
			}
		}elsif($estudios=~/[Ll]eyes/){
			print sal "Carrera:  Leyes \n"
		}
		if($estudios=~/([Ee][Ss][Pp][Oo][Ll]|Escuela)/){
			print sal "Universidad: ESPOL \n"
		}elsif($estudios=~/([Cc][Aa][Tt][Oo][Ll][Ii][Cc][Aa]|[Uu][Cc][Ss][Gg])/){
			print sal "Universidad: Católica \n"
		}elsif($estudios=~/([Ee]statal|[Uu]niversidad de [Gg]uayaquil)/){
			print sal "Universidad: Estatal \n"
		}

		
	} 
}