// Inicio das variaveis dos controles
key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_jump = keyboard_check(vk_space);

// ==========================================
// 1. MOVIMENTAÇÃO BÁSICA E GRAVIDADE
// ==========================================
var move = key_right - key_left;

if (active == true)
{
    // NO AR COM O GANCHO: Controle total do gancho
}
else
{
    if (place_meeting(x, y + 1, obj_parede))
    {
        var chao_bambo = instance_place(x, y + 1, obj_terra_bamba);
        if (chao_bambo != noone) and (abs(chao_bambo.image_angle) > 15)
        {
            var forca_escorregamento = dsin(chao_bambo.image_angle) * 8; 
            hspd = (move * spd) - forca_escorregamento;
        }
        else // <--- É ESTE AQUI! O CHÃO NORMAL (FORA DA GANGORRA)
        {
            // 1. Agilidade padrão (começar a andar e parar)
            var agilidade = 0.2; 
            
			// 2. O TRUQUE: DERRAPADA
            if (move != 0) and (sign(move) != sign(hspd)) and (abs(hspd) > 0.5)
            {
                agilidade = 0.03; 
                
                // GERA A FUMAÇA!
                // Usamos um "sorteio" (random) para não criar 60 fumaças por segundo.
                // Isso cria uma chance de 30% de soltar uma fumacinha a cada frame da derrapada.
                if (random(100) < 30)
                {
                    // Cria a fumaça exatamente no X do pé do gato (ajuste o y + 10 se precisar descer mais)
                    var fumaca = instance_create_depth(x, y + 11, depth + 1, obj_fumaca);
                    
                    // Faz a fumaça virar para o lado oposto que o gato está indo, para dar o efeito de "arraste"
                    fumaca.image_xscale = sign(hspd); 
                }
            }
            
            // 3. Aplica o movimento usando a agilidade dinâmica
            hspd = lerp(hspd, move * spd, agilidade); 
        }
    }
    else
    {
        // NO AR
        hspd = lerp(hspd, move * spd, 0.05);
    }
    
    // A GRAVIDADE (Com "Hang Time" para flutuar no topo do pulo)
    var gravidade_atual = grv;
    
    if (abs(vspd) < 1.5) 
    {
        gravidade_atual = grv * 0.5; 
    }
    
    vspd = vspd + gravidade_atual;
}

// ==========================================
// 2. COMPORTAMENTO NA PAREDE (Slide e Grudadinha)
// ==========================================
var no_chao = place_meeting(x, y + 1, obj_parede);
var parede_direita = place_meeting(x + 1, y, obj_parede);
var parede_esquerda = place_meeting(x - 1, y, obj_parede);

if (!no_chao) 
{
    if (parede_direita or parede_esquerda) 
    {
        // WALL SLIDE (Desliza devagar)
        if (vspd > 0) vspd = 1.5; 
        
        // WALL STICK (Gruda na parede)
        if ((parede_direita and key_left) or (parede_esquerda and key_right))
        {   
            if (tempo_desgrudar > 0)
            {
                hspd = 0; // Cancela o movimento!
                tempo_desgrudar -= 1; // Esvazia o cronômetro
            }
        }
        else
        {
            tempo_desgrudar = 20; // Recarrega a "cola"
        }
    }
    else
    {
        tempo_desgrudar = 0; // Longe da parede, perde a cola
    }
}

// ==========================================
// 3. PULO E WALL JUMP
// ==========================================
if (key_jump)
{
    // PULO NORMAL (No Chão)
    if (no_chao) 
    {
        vspd -= 7.6;
    }
    // WALL JUMP (No Ar e encostado na Parede)
    else 
    {
        if (parede_direita)
        {
            if (key_left)
            {
                vspd = -7.6; 
                hspd = -spd; 
                tempo_desgrudar = 0; // Zera a cola para liberar o pulo!
            }
        }
        else if (parede_esquerda)
        {
            if (key_right)
            {
                vspd = -7.6; 
				instance_create_depth(x, y + 8, depth + 1, obj_fumaca);
                hspd = spd;  
                tempo_desgrudar = 0; // Zera a cola para liberar o pulo!
            }
        }
    }
}

// CONTROLE DE ALTURA DO PULO
// Se o jogador soltar a tecla de pulo (vk_space) ENQUANTO ainda estiver subindo (vspd negativo)
if (keyboard_check_released(vk_space) and vspd < 0)
{
    // Corta a velocidade do pulo pela metade, fazendo ele cair mais rápido
    vspd = vspd * 0.5; 
}

// ==========================================
// 4. COLISÕES (Com suporte a Rampas)
// ==========================================
// Horizontal
if place_meeting(x + hspd, y, obj_parede)
{
    var altura_rampa = 0;
    while (place_meeting(x + hspd, y - altura_rampa, obj_parede) and altura_rampa <= 5)
    {
        altura_rampa += 1;
    }
    
    if (!place_meeting(x + hspd, y - altura_rampa, obj_parede))
    {
        y -= altura_rampa;
    }
    else 
    {
        while (!place_meeting(x + sign(hspd), y, obj_parede))
        {
            x = x + sign(hspd);
        }
        hspd = 0;
    }
}
x = x + hspd;

// Vertical
var no_chao_antes = place_meeting(x, y + 1, obj_parede); 

if place_meeting(x, y + vspd, obj_parede)
{
    while (!place_meeting(x, y + sign(vspd), obj_parede))
    {
        y = y + sign(vspd);
    }
    vspd = 0;
}
y = y + vspd;

// Grudar na Rampa descendo
if (no_chao_antes and !place_meeting(x, y + 1, obj_parede) and vspd >= 0)
{
    var desce_rampa = 0;
    while (!place_meeting(x, y + desce_rampa, obj_parede) and desce_rampa <= 5)
    {
        desce_rampa += 1;
    }
    if (place_meeting(x, y + desce_rampa, obj_parede))
    {
        y += desce_rampa - 1;
    }
}

// ==========================================
// 5. SISTEMA DE ANIMAÇÃO
// ==========================================

if (active == true)
{
    // 1. PRIORIDADE MÁXIMA: Voando no gancho
    sprite_index = sprite_gato_hook; 
    if (hspd != 0) image_xscale = sign(hspd); // No gancho, vira pro lado do puxão
}
else if (place_meeting(x, y + 1, obj_parede)) 
{
    // 2. NO CHÃO
    if (abs(hspd) > 0.1) 
    {
        sprite_index = sprite_gato_correndo;
    }
    else 
    {
        sprite_index = sprite_gato_parado; 
    }
    
    // O SEGREDO DO MOONWALK PERFEITO:
    // O rosto vira na mesma hora que você aperta o botão, 
    // enquanto o corpo continua escorregando de costas!
    if (move != 0)
    {
        image_xscale = sign(move); 
    }
}
else
{
    // 3. NO AR
    sprite_index = sprite_gato_parado; // (Ou sprite_gato_pulando)
    
    // No ar, ele também olha pro lado que você está tentando ir
    if (move != 0) 
    {
        image_xscale = sign(move); 
    }
}

// ==========================================
// 6. MECÂNICA DE MORTE E GANCHO
// ==========================================
if (y > 180)
{
    room_restart();
}

if (mouse_check_button_pressed(mb_left))
{
    if (position_meeting(mouse_x, mouse_y, obj_grabador))
    {
        var grabador = instance_position(mouse_x, mouse_y, obj_grabador);
        mx = grabador.x;
        my = grabador.y;
        active = true;
        hook_timer = 8;
    }
}

if (active)
{
    hook_timer -= 1;
    
    var direcao = point_direction(x, y, mx, my);
    var distancia = point_distance(x, y, mx, my);
    var velocidade_gancho = 7.5; 
    
    hspd = lengthdir_x(velocidade_gancho, direcao);
    vspd = lengthdir_y(velocidade_gancho, direcao);
    
    if (distancia < 15) or (hook_timer <= 0)
    {
        active = false;
    }
}

if (mouse_check_button_released(mb_left))
{
    active = false;
}