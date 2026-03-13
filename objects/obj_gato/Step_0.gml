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
        else
        {
            hspd = move * spd; 
        }
    }
    else
    {
        hspd = lerp(hspd, move * spd, 0.05);
    }
    
    // A GRAVIDADE
    vspd = vspd + grv;
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
                hspd = spd;  
                tempo_desgrudar = 0; // Zera a cola para liberar o pulo!
            }
        }
    }
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
if (hspd != 0) image_xscale = sign(hspd); // Vira para o lado certo

if (active == true)
{
    sprite_index = sprite_gato_hook; 
}
else if (place_meeting(x, y + 1, obj_parede)) 
{
    if (hspd != 0) 
    {
        sprite_index = sprite_gato_correndo;
    }
    else 
    {
        sprite_index = sprite_gato_parado; 
    }
}
else
{
    // No ar (se tiver um sprite de pulo no futuro, é só colocar aqui)
    sprite_index = sprite_gato_pulando;
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