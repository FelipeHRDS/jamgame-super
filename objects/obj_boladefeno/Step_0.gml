// 1. Aplica a gravidade para ela cair
vspd = vspd + grv;

// 2. Colisão Vertical (Onde acontece o quique)
if place_meeting(x, y + vspd, obj_parede)
{
    // Cola a bola perfeitamente no chão antes de quicar
    while (!place_meeting(x, y + sign(vspd), obj_parede))
    {
        y = y + sign(vspd);
    }
    
    vspd = random_range(-3, -3.5);
}

// Aplica o movimento vertical
y = y + vspd;

// 3. Colisão Horizontal (Onde acontece o quique na parede)
if place_meeting(x + hspd, y, obj_parede)
{
    // Cola a bola perfeitamente na parede antes de quicar
    while (!place_meeting(x + sign(hspd), y, obj_parede))
    {
        x = x + sign(hspd);
    }
    
    // Inverte a direção da bola! 
    // Se era negativo (esquerda), vira positivo (direita), e vice-versa.
    hspd = -hspd; 
}

// Aplica o movimento horizontal
x = x + hspd;

// 4. Efeito Visual de Rolar Inteligente
// Se a velocidade for menor que 0 (esquerda), gira pra um lado. Senão, gira pro outro.
if (hspd < 0) 
{
    image_angle = image_angle + 4; 
} 
else 
{
    image_angle = image_angle - 4; 
}

// 5. Destruição (Limpar a memória)
// Adicionamos "x > room_width + 50" para destruir a bola se ela sair pela direita da tela
if (x < -50) or (x > room_width + 50) or (y > room_height + 50)
{
    instance_destroy();
}