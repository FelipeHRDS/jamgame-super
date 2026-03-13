// Cria o urubu. 
instance_create_layer(2542, 31, "Instances", obj_urubu);

// Reinicia o alarme com um novo tempo aleatório para o próximo urubu
alarm[0] = irandom_range(tempo_minimo, tempo_maximo);