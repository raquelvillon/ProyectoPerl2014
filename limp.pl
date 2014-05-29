@lineas = <>;
open (datos,">>informacion.txt");
for (my $i = 0; $i < scalar(@lineas); $i++) {
	$lineas[$i] =~ s/^\s+|\s+$//g; #TRIM
	if (length($lineas[$i])>200) { #quita las lineas vacias
		print  datos $lineas[$i]."\n"; # tambien se lo puede escribir asi $linea."\n"
	}
	if (length($lineas[$i])>0 && length($lineas[$i])<200){
	#$lineas[$i] = $lineas[$i]+$lineas[$i+1]; 
	print   datos $lineas[$i];
		while (length($lineas[$i+1])>0 && length($lineas[$i+1])<230)	{
			
			$lineas[$i+1] =~ s/^\s+|\s+$//g; #TRIM
			print datos " ".$lineas[$i+1];
			$i=$i+1;
			
		}
		print   datos "\n";
	}	
}
close (datos);