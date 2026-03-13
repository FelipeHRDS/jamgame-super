// Tempo em frames (60 = 1 segundo)
// Você pode ajustar esses valores para deixar o deserto mais calmo ou mais perigoso!
tempo_minimo = 60 * 4;  // 5 segundos
tempo_maximo = 60 * 7; // 12 segundos

// Inicia o cronômetro com um valor aleatório entre o mínimo e o máximo
alarm[0] = irandom_range(tempo_minimo, tempo_maximo);