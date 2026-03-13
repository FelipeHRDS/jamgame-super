// Cria a bola de feno exatamente na posição X e Y de onde você colocar o spawner na Room
// Certifique-se de que a layer se chama "Instances"
instance_create_layer(x, y, "Instances", obj_boladefeno);

// Reinicia o alarme para a próxima bola de feno nascer depois de um tempo
alarm[0] = irandom_range(tempo_minimo, tempo_maximo);