var rotacao_alvo = 0;

if (instance_exists(obj_gato))
{
    // Verifica se o gato está encostando na plataforma (testando 2 pixels para cima)
    if (place_meeting(x, y - 2, obj_gato))
    {
        // Calcula a distância do gato até o centro da gangorra
        // Se o gato estiver na esquerda, o valor é negativo. Na direita, positivo.
        var diferenca_x = obj_gato.x - x;
        
        // No GameMaker, ângulo positivo gira para a esquerda (anti-horário).
        // Por isso, invertemos o sinal da diferença (-) para a gangorra descer do lado certo!
        rotacao_alvo = -diferenca_x * 2;
        
        // Usamos o clamp() para limitar o ângulo. 
        // Isso impede que a plataforma dê um giro completo de 360 graus!
        // Aqui ela vai inclinar no máximo 40 graus para cada lado.
        rotacao_alvo = clamp(rotacao_alvo, -360, 360); 
    }
}

// A função lerp() suaviza o movimento para a gangorra não "teletransportar" para o ângulo
// O valor 0.05 é a velocidade que ela tomba (aumente se quiser que ela caia mais rápido)
image_angle = lerp(image_angle, rotacao_alvo, 0.05);