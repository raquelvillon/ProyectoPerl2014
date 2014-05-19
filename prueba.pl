  $archivo=<>; #abre un txt que se especifica cuando se llama al .perl

  @oraciones;
#Guarda una oración separada por una coma

  if ($archivo =~ /([0-9a-zA-Z\s]+)*\,/) 
  { 
 	push(@oraciones,$1);
  	print @oraciones
  }else{
  	print "no lo contiene";
  	
  }
