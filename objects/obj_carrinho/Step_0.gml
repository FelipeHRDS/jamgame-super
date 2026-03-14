// 1. GRAVIDADE
vspd = vspd + grv;

// 2. MOVIMENTO HORIZONTAL
hspd = spd * dir;

// 3. O RADAR DE PAREDES E ABISMOS (Com a proteção do abs!)
var largura_segura = abs(sprite_width) / 2;
var chao_na_frente = place_meeting(x + (largura_segura * dir), y + 1, obj_parede);
var parede_na_frente = place_meeting(x + hspd, y, obj_parede);

// Se bater numa parede na frente OU o chão acabar (abismo)...
if (parede_na_frente or !chao_na_frente)
{
    dir = dir * -1; // Dá meia-volta!
    hspd = spd * dir; // Atualiza a direção na mesma hora
}

// 4. COLISÕES BÁSICAS (Para ele respeitar a física do mundo)
// Colisão Horizontal
if (place_meeting(x + hspd, y, obj_parede))
{
    while (!place_meeting(x + sign(hspd), y, obj_parede)) 
    { 
        x += sign(hspd); 
    }
    hspd = 0;
}
x += hspd;

// Colisão Vertical
if (place_meeting(x, y + vspd, obj_parede))
{
    while (!place_meeting(x, y + sign(vspd), obj_parede)) 
    { 
        y += sign(vspd); 
    }
    vspd = 0;
}
y += vspd;

// 5. VIRA O DESENHO PARA O LADO CERTO
// (Se o seu carrinho for igual dos dois lados, pode até apagar essa linha)
if (hspd != 0) image_xscale = dir;