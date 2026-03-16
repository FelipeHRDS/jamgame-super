// Se ainda não mudou de fase, a tela ESCURECE
if (mudou_de_sala == false)
{
    alfa += 0.05; 
    
    // Quando a tela ficar 100% preta...
    if (alfa >= 1)
    {
        audio_stop_all(); // <--- O JOGO INTEIRO FICA MUDO AQUI!
        
        room_goto_next();      
        mudou_de_sala = true;  
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