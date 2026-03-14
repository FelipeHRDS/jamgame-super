// ==========================================
// 1. GRAVIDADE E CRONÔMETRO
// ==========================================
vspd = vspd + grv;

if (cooldown_tiro > 0) 
{
    cooldown_tiro -= 1;
}

// ==========================================
// 2. A MÁQUINA DE ESTADOS BLINDADA
// ==========================================
if (estado == "patrulhando")
{
    // A toupeira só tenta atacar SE estiver patrulhando
    var distancia = distance_to_object(obj_gato);
    
    // Gato perto E arma recarregada?
    if (distancia < 100 and cooldown_tiro <= 0)
    {
        estado = "atacando";
        hspd = 0; // Freia na mesma hora!
        
        sprite_index = sprite_topeira_atacando; // Coloca a fantasia de ataque
        image_index = 0; // Começa do frame zero
        atirou_neste_loop = false; // Prepara o tiro
    }
    else
    {
        // Se não for atacar, anda normalmente!
        // IMPORTANTE: Troque o nome abaixo para o sprite real dela andando!
        sprite_index = sprite_topeira; 
        
        hspd = spd * dir;
        
        var largura_segura = abs(sprite_width) / 2;
        var chao_na_frente = place_meeting(x + (largura_segura * dir), y + 1, obj_parede);
        var parede_na_frente = place_meeting(x + hspd, y, obj_parede);
        
        if (parede_na_frente or !chao_na_frente)
        {
            dir = dir * -1; 
        }
    }
}
else if (estado == "atacando")
{
    hspd = 0; // Garante que ela não vai dar nenhum passo enquanto ataca
    
    // Olha pro gato
    var direcao_gato = sign(obj_gato.x - x);
    if (direcao_gato != 0) dir = direcao_gato; 
    
    // --------------------------------------------------
    // O TIRO SINCRONIZADO
    // --------------------------------------------------
    var frame_exato_do_tiro = 7; // Ajuste para o seu frame correto

    if (floor(image_index) == frame_exato_do_tiro) and (atirou_neste_loop == false)
    {
        var picareta = instance_create_depth(x, y - 10, depth + 1, obj_picareta);
        picareta.hspd = (obj_gato.x - x) / 60; 
        atirou_neste_loop = true; 
    }
    
    // --------------------------------------------------
    // FIM DO ATAQUE (Volta ao normal)
    // --------------------------------------------------
    // Quando a animação chega no último quadro...
    if (image_index >= image_number - 1)
    {
        estado = "patrulhando"; 
        cooldown_tiro = 120; // 2 segundos de espera
        
        // MUITO IMPORTANTE: Tira a fantasia de ataque e devolve a de andar!
        // Troque pelo seu sprite de caminhada:
        sprite_index = sprite_topeira; 
    }
}

// ==========================================
// 3. COLISÕES BÁSICAS E ANIMAÇÃO
// ==========================================
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

// Vira a imagem para o lado certo
image_xscale = -dir;