use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaEstadoCivil.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);

foreach $info(@parrafos){
	push(@oraciones,split(/\,+/, $info));
}
 
foreach $estadoCiv (@oraciones){
	#Encuentra los estados civil
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(solter[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}
	if ($estadoCiv =~ /([Ss]oy |[Ee]stoy |[Mm]e encuentro )(casad[oa])/){
		print sal "Estado Civil: ".$2."\n";
	}
	
	#print "\n";
}     

close (sal);