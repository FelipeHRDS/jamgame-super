// ==========================================
// 1. ESPERANDO O JOGADOR
// ==========================================
if (partindo == false)
{
    // Se o gato encostar no carrinho...
    if (place_meeting(x, y, obj_gato))
    {
        partindo = true; // Liga os motores!
        
        // Em vez de destruir, nós apenas deixamos o gato invisível!
        obj_gato.visible = false; 
        
        // BÔNUS: Muda a imagem do carrinho para mostrar o gato sentadinho nele
        // sprite_index = sprite_carrinho_com_gato; 
    }
}

// ==========================================
// 2. FUGINDO DA TELA E PASSANDO DE FASE
// ==========================================
else if (partindo == true)
{
    // O carrinho começa a andar sozinho para a direita
    x += velocidade_fuga;
    
    // A MÁGICA DO TELEPORTE: Gruda o gato no carrinho o tempo todo!
    if (instance_exists(obj_gato))
    {
        obj_gato.x = x;
        
        // Opcional: Se o seu gato nascer "enterrado" no carrinho, ajuste o Y dele aqui (ex: y - 10)
        obj_gato.y = y; 
    }
    
// Quando o carrinho passar totalmente do limite direito da Room
    if (x > room_width + 100)
    {
        // Só cria a transição se ela já não existir (para não criar 60 por segundo!)
        if (!instance_exists(obj_transicao))
        {
            // Cria o diretor da transição na tela!
            instance_create_depth(0, 0, -9999, obj_transicao); 
        }
    }
}