// Tempo em frames (60 = 1 segundo)
tempo_minimo = 60 * 3; // 4,5 segundos
tempo_maximo = 60 * 7; // 7 segundos

// Inicia o alarme 0 com um tempo aleatório entre o mínimo e o máximo
alarm[0] = irandom_range(tempo_minimo, tempo_maximo);