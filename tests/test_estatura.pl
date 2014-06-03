use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaEstatura.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);

foreach $info(@parrafos){
	push(@oraciones,split(/\,+/, $info));
}
 
foreach $estatura (@oraciones){
	#Encuentra las estaturas en metros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([1]+\.)+([0-9]{2}|[0-9])+(m| m|metros| metros)*/){
		$datoestatura = $2.$3;
		if (length($datoestatura)<4){
			$datoestatura = $datoestatura."0";
		}
		print sal "Estatura: ".$datoestatura." metros\n";
		#print sal "Estatura: ".$2.$3." metros\n";
	}
	#Encuentra las estaturas en centimetros
	if ($estatura =~ /([mM]ido |[mM]i estatura es de |[mM]i estatura es |[mM]ido aproximadamente )([0-9]{3})+(cm| cm|centimetros| centimetros)*/){
		$datoestatura = $2/100;
		print sal "Estatura: ".$datoestatura." metros\n";
	}
	#print "\n";
}     

close (sal);