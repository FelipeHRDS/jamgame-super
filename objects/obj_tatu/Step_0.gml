// 1. Aplica a gravidade sempre
vspd = vspd + grv;

// Variável temporária para saber qual velocidade usar
var spd_atual = 0;

// ==========================================
// 2. MÁQUINA DE ESTADOS
// ==========================================

if (estado == "andando")
{
    sprite_index = sprite_tatu;
	
	
    spd_atual = spd_andando;
    
    // Verifica a distância do gato para entrar no modo bolinha
    if (instance_exists(obj_gato))
    {
        var distancia = point_distance(x, y, obj_gato.x, obj_gato.y);
        
        // Se o gato chegar a menos de 100 pixels de distância...
        if (distancia < 100) 
        {
            estado = "transformando"; // Fica agressivo!
        }
    }
}

else if (estado == "transformando")
{
    // Toca a animação nova
    sprite_index = sprite_tatu_transformando;
    
    // Zera a velocidade para ele parar no lugar enquanto se transforma
    spd_atual = 0; 
}

else if (estado == "rolando")
{
	
    sprite_index = sprite_tatu_rolando;
    spd_atual = spd_rolando;
    
    // O PULO ESPELHADO:
    // Se o tatu estiver pisando no chão e o jogador apertar o botão de pulo
    if (place_meeting(x, y + 1, obj_parede))
    {
        if (keyboard_check_pressed(vk_space))
        {
            // O tatu pula junto em uma altura fixa!
            vspd = -6; 
        }
    }
}

// Define a velocidade horizontal baseada na direção e no estado atual
hspd = dir * spd_atual;


// ==========================================
// 3. INTELIGÊNCIA DE PATRULHA (NÃO CAIR/BATER)
// ==========================================

// Bateu na parede? Inverte a direção.
if (place_meeting(x + hspd, y, obj_parede))
{
    dir = dir * -1; 
}
else if (place_meeting(x, y + 1, obj_parede)) // Só verifica buraco se estiver no chão
{
    // Tem um buraco na frente? 
    // Checamos 15 pixels à frente da direção que ele está indo.
    if (!place_meeting(x + (dir * 15), y + 1, obj_parede))
    {
        dir = dir * -1; // Opa, buraco! Inverte a direção.
    }
}

// Vira o rostinho do Tatu para o lado certo
if (hspd != 0) image_xscale = -	dir;


// ==========================================
// 4. COLISÕES PADRÕES
// ==========================================

// Colisão Horizontal
if place_meeting(x + hspd, y, obj_parede)
{
    while (!place_meeting(x + sign(hspd), y, obj_parede))
    {
        x = x + sign(hspd);
    }
    hspd = 0;
}
x = x + hspd;

// Colisão Vertical
if place_meeting(x, y + vspd, obj_parede)
{
    while (!place_meeting(x, y + sign(vspd), obj_parede))
    {
        y = y + sign(vspd);
    }
    vspd = 0;
}
y = y + vspd;