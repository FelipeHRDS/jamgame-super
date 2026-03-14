// 1. GRAVIDADE BÁSICA
vspd = vspd + grv;

// 2. O RADAR (Detecta o gato)
var distancia = distance_to_object(obj_gato);

if (distancia < 150) // Raio de visão da topeira (Ajuste se necessário)
{
    estado = "atacando";
}
else
{
    estado = "patrulhando";
}

// 3. A MÁQUINA DE ESTADOS
if (estado == "patrulhando")
{
    hspd = spd * dir;
    
    // A MÁGICA: abs() garante que a largura seja sempre positiva!
    var largura_segura = abs(sprite_width) / 2;
    
    // Agora ela sempre vai olhar um pouquinho para frente, na direção correta
    var chao_na_frente = place_meeting(x + (largura_segura * dir), y + 1, obj_parede);
    var parede_na_frente = place_meeting(x + hspd, y, obj_parede);
    
    // Se bater na parede ou o chão acabar...
    if (parede_na_frente or !chao_na_frente)
    {
        dir = dir * -1; // Vira para o outro lado imediatamente
    }
}

else if (estado == "atacando")
{
    hspd = 0; // Para de andar
    
    // Olha fixa para a direção do gato para o sprite virar certo
    dir = sign(obj_gato.x - x);
    if (dir == 0) dir = 1; 
    
    // SISTEMA DE TIRO
    cooldown_tiro -= 1;
    
    if (cooldown_tiro <= 0)
    {
        // Cria a picareta
        var picareta = instance_create_depth(x, y - 10, depth + 1, obj_picareta);
        
        // ==========================================
        // A MÁGICA DA MIRA PERFEITA (TRACKING)
        // ==========================================
        // Descobre a distância exata entre a topeira e o gato
        var distancia_x = obj_gato.x - x;
        
        // Divide a distância pelo tempo de voo (60 frames). 
        // A picareta agora se ajusta para cair perfeitamente onde o gato está!
        picareta.hspd = distancia_x / 60; 
        
        // ==========================================
        // DIMINUINDO O NÚMERO DE PICARETAS
        // ==========================================
        // Antes era 60 (1 tiro por segundo). 
        // Agora é 120 (1 tiro a cada 2 segundos). 
        // Se ainda achar muito rápido, mude para 150 ou 180!
        cooldown_tiro = 120; 
    }
}

// 4. COLISÕES BÁSICAS (Para a topeira não atravessar o chão)
if (place_meeting(x + hspd, y, obj_parede))
{
    while (!place_meeting(x + sign(hspd), y, obj_parede)) { x += sign(hspd); }
    hspd = 0;
}
x += hspd;

if (place_meeting(x, y + vspd, obj_parede))
{
    while (!place_meeting(x, y + sign(vspd), obj_parede)) { y += sign(vspd); }
    vspd = 0;
}
y += vspd;

// 5. ANIMAÇÃO (Vira o sprite para o lado certo)
image_xscale = dir;