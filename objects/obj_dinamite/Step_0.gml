// Diminui o tempo a cada frame
tempo_explosao -= 1;

// Opcional: Fazer a dinamite tremer ou piscar de vermelho aqui ficaria super legal!

// Quando o tempo acabar...
if (tempo_explosao <= 0)
{
    // 1. O EFEITO VISUAL (O show de luzes)
    effect_create_depth(depth - 10, ef_explosion, x, y, 1, c_orange);
    effect_create_depth(depth - 10, ef_smoke, x, y, 2, c_dkgray);
    
    // ==========================================
    // 2. A ÁREA DE DANO (O perigo real!)
    // ==========================================
    // collision_circle(x, y, raio, objeto_alvo, preciso, notme)
    // O número 40 é o tamanho do raio da explosão em pixels. Aumente se quiser uma explosão maior!
    var acertou_o_gato = collision_circle(x, y, 40, obj_gato, false, true);
    
	// Se o gato estava dentro do círculo na hora da explosão...
    if (acertou_o_gato)
    {
        // Mata o jogador (Lembre de usar o nome exato do seu objeto gato!)
        obj_gato.morto = true; 
    }
    
    // 3. Destrói a dinamite
    instance_destroy();
}