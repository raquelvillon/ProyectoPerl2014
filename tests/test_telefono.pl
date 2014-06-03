use utf8; #permite que se compilen caracteres especiales como las vocales tildadas y las eñes
open (datos,"<:encoding(UTF-8)","dataset.txt"); #hace que lea el txt tal y como esta escrito, incluidas los caracteres esperciales

@informacion=<datos>;
close (datos);
open (sal,">salidaTelefono.txt");
foreach $inf(@informacion){
	
	if (length($inf)>20) {
		push(@parrafos,$inf);
	}
}
$numParrafos=length(@parrafos);

foreach $info(@parrafos){
	push(@oraciones,split(/\,+/, $info));
}
 
foreach $telf (@oraciones){
	#Encuentra los telefonos5
	if ($telf =~ /(celular es |celular |tel[eé]fono es |tel[eé]fonico es |tel[eé]fonico es el )([0][9][0-9]{8}|"+593 "[0-9]{9})*/){
		print sal "Telefono: ".$2."\n";
	}
	
	#print "\n";
}     

close (sal);