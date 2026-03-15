// 1. Verifica se a plataforma AINDA NÃO está caindo
if (caindo == false)
{
    // Checa se o gato pisou nela (verificando 1 pixel acima)
    if (place_meeting(x, y - 1, obj_gato))
    {
        caindo = true; // Ativa a armadilha
        
        // O SEGREDO DA ALTA VELOCIDADE:
        // Injeta uma velocidade vertical altíssima direto no jogador!
        // Se não fizermos isso, a plataforma cai rápido e o gato fica flutuando no ar
        // caindo devagar pela gravidade normal dele.
        obj_gato.vspd = 14; // Aumente esse número se quiser uma queda mais fatal!
    }
}

// 2. O que acontece depois que a armadilha é ativada
if (caindo == true)
{
    // A plataforma ganha gravidade própria e acelera rápido
    vspd = vspd + 0.8; 
    y = y + vspd;
    
    // Limpeza de memória: destrói a plataforma quando ela sair da tela por baixo
    if (y > room_height + 50)
    {
        instance_destroy();
    }
}