// ==========================================
// 1. GRAVIDADE E RADAR DE VISÃO (Com Memória!)
// ==========================================
vspd = vspd + grv;

// Descobre a distância (círculo) e a diferença de altura
var distancia = distance_to_object(obj_gato);
var diferenca_altura = abs(obj_gato.y - y);

// A cobra está te vendo NESTE EXATO FRAME? (Perto E no mesmo chão)
var vendo_gato = (distancia < raio_visao) and (diferenca_altura < 15);

if (vendo_gato == true)
{
    // Ela te viu! Renova a memória dela para 60 frames (1 segundo de perseguição cega)
    // Se o seu pulo demorar mais de 1 segundo para cair no chão, aumente esse número!
    tempo_memoria = 60; 
}

// ==========================================
// O CÉREBRO DA MEMÓRIA
// ==========================================
// Se ela acabou de te ver OU ainda se lembra de você...
if (tempo_memoria > 0)
{
    estado = "perseguindo";
    spd_atual = spd_perseguicao;
    
    // A memória vai acabando enquanto você está no ar pulando...
    tempo_memoria -= 1; 
}
else
{
    // Se o tempo acabou e você sumiu de verdade, ela desiste.
    estado = "patrulhando";
    spd_atual = spd_patrulha;
}

// ==========================================
// 2. RADAR DE ABISMO E PAREDE (Lê apenas 1 vez!)
// ==========================================
var ponta_do_pe = x;
if (dir == 1) 
{
    ponta_do_pe = bbox_right + spd_atual;
} 
else 
{
    ponta_do_pe = bbox_left - spd_atual;
}

// As variáveis são criadas com "var" UMA ÚNICA VEZ aqui
var chao_na_frente = position_meeting(ponta_do_pe, bbox_bottom + 1, obj_parede);
var parede_na_frente = place_meeting(x + (spd_atual * dir), y, obj_parede);

// ==========================================
// 3. MÁQUINA DE ESTADOS
// ==========================================
if (estado == "patrulhando")
{
    hspd = spd_atual * dir;
    
    // Se bater na parede ou o chão acabar, dá meia-volta
    if (parede_na_frente or !chao_na_frente)
    {
        dir = dir * -1;
    }
}
else if (estado == "perseguindo")
{
    // ZONA MORTA: Impede a cobra de vibrar e bugar quando o jogador está em cima dela
    var distancia_x = abs(obj_gato.x - x);
    
    // Ela só vira e anda se o jogador estiver mais longe que 1 passo dela
    if (distancia_x > spd_atual)
    {
        var direcao_gato = sign(obj_gato.x - x);
        if (direcao_gato != 0) 
        {
            dir = direcao_gato;
        }
        hspd = spd_atual * dir;
    }
    else
    {
        // Se já está alinhada perfeitamente com o gato, ela freia e espera!
        hspd = 0; 
    }
    
    // A Cobra não é boba: se ela chegar na beirada ela "freia".
    // Como chao_na_frente já foi calculado lá em cima, não precisamos do "var" de novo!
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

// Vira o rostinho
if (dir != 0) image_xscale = -dir;