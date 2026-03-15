// Se ainda não mudou de fase, a tela ESCURECE
if (mudou_de_sala == false)
{
    alfa += 0.05; // Velocidade do escurecimento (aumente se quiser mais rápido)
    
    // Quando a tela ficar 100% preta...
    if (alfa >= 1)
    {
        room_goto_next();      // Pula para a próxima fase!
        mudou_de_sala = true;  // Avisa que já mudou
    }
}
// Se já mudou de fase, a tela CLAREIA
else
{
    alfa -= 0.05; 
    
    // Quando a tela ficar 100% transparente de novo...
    if (alfa <= 0)
    {
        instance_destroy(); // O diretor termina o trabalho e se destrói
    }
}