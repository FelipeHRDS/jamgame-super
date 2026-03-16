tempo += 0.05; // Velocidade da flutuação (aumente para flutuar mais rápido)

// O "sin" faz o valor subir e descer suavemente como uma onda.
// O número "5" é a quantidade de pixels que a logo vai subir e descer.
y = y_inicial + sin(tempo) * 5;