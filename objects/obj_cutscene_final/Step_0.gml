if (estado == "mostrando")
{
    // Verifica se é a ÚLTIMA imagem da lista (ou seja, o seu Texto!)
    if (pagina_atual == array_length(paginas) - 1)
    {
        // É O TEXTO! O tempo congela. Só avança se o jogador apertar ESPAÇO.
        if (keyboard_check_pressed(vk_space))
        {
            estado = "escurecendo";
        }
    }
    else
    {
        // SÃO AS IMAGENS NORMAIS. O cronômetro funciona normalmente.
        tempo_atual -= 1; 

        if (tempo_atual <= 0) or (keyboard_check_pressed(vk_space))
        {
            estado = "escurecendo";
        }
    }
}

else if (estado == "escurecendo")
{
    alfa += 0.05; // A tela vai ficando preta

    if (alfa >= 1) // Quando ficar 100% preta...
    {
        pagina_atual += 1; // Muda para a próxima imagem!

        // Verifica se chegamos no final da lista de imagens
        if (pagina_atual >= array_length(paginas))
        {
			audio_stop_sound(Rocking_Chair6);
            room_goto_next(); // Acabou a historinha, vai para o Jogo!
        }
        else
        {
            estado = "clareando"; // Se ainda tem imagem, começa a clarear
            tempo_atual = tempo_limite; // Reseta o cronômetro para a nova foto
        }
    }
}
else if (estado == "clareando")
{
    alfa -= 0.05; // A tela preta vai sumindo

    if (alfa <= 0)
    {
        estado = "mostrando"; // Terminou de clarear, o ciclo recomeça!
    }
}