// ==========================================
// 1. GRAVIDADE E RADAR DE VISÃO
// ==========================================
vspd = vspd + grv;

// Descobre a distância (círculo) e também a diferença de altura!
var distancia = distance_to_object(obj_gato);
var diferenca_altura = abs(obj_gato.y - y);

// Só ataca se estiver perto (180 pixels) E no mesmo andar (diferença de altura menor que 40 pixels)
if (distancia < raio_visao) and (diferenca_altura < 40)
{
    estado = "perseguindo";
}
else
{
    estado = "patrulhando";
}

// ==========================================
// 2. RADAR DE ABISMO E PAREDE (Versão Ponta do Pé)
// ==========================================
// Pega o ponto extremo do sprite (direita ou esquerda dependendo de qual lado ela olha)
var ponta_do_pe = x;
if (dir == 1) 
{
    ponta_do_pe = bbox_right + spd_atual;
} 
else 
{
    ponta_do_pe = bbox_left - spd_atual;
}

// Em vez de calcular o corpo todo, a função position_meeting checa apenas 1 único pixel!
// Ela lança um "laser" na ponta do pé da cobra, 1 pixel para baixo (bbox_bottom + 1).
var chao_na_frente = position_meeting(ponta_do_pe, bbox_bottom + 1, obj_parede);

// A parede continua calculando o corpo todo para ela não bater o focinho
var parede_na_frente = place_meeting(x + (spd_atual * dir), y, obj_parede);

// ==========================================
// 3. MÁQUINA DE ESTADOS
// ==========================================
if (estado == "patrulhando")
{
    spd_atual = spd_patrulha;
    hspd = spd_atual * dir;
    
    // Se bater na parede ou o chão acabar, dá meia-volta
    if (parede_na_frente or !chao_na_frente)
    {
        dir = dir * -1;
    }
}
else if (estado == "perseguindo")
{
    spd_atual = spd_perseguicao;
    
    // Olha furiosa para a direção exata onde o gato está!
    var direcao_gato = sign(obj_gato.x - x);
    if (direcao_gato != 0) 
    {
        dir = direcao_gato;
    }
    
    // Acelera na direção do gato
    hspd = spd_atual * dir;
    
    // A Cobra não é boba: se ela chegar na beirada ou bater na parede tentando te pegar, ela "freia" e fica presa rosnando.
    if (parede_na_frente or !chao_na_frente)
    {
        hspd = 0; 
    }
}

// ==========================================
// 4. COLISÕES BÁSICAS E ANIMAÇÃO
// ==========================================
// Horizontal
if (place_meeting(x + hspd, y, obj_parede))
{
    while (!place_meeting(x + sign(hspd), y, obj_parede)) { x += sign(hspd); }
    hspd = 0;
}
x += hspd;

// Vertical
if (place_meeting(x, y + vspd, obj_parede))
{
    while (!place_meeting(x, y + sign(vspd), obj_parede)) { y += sign(vspd); }
    vspd = 0;
}
y += vspd;

// Vira o rostinho (usando dir para não bugar o sprite!)
if (dir != 0) image_xscale = -dir;