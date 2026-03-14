// Verifica se o jogador encostou no baú
// (Lembre-se de trocar obj_gato pelo nome real do seu jogador, se for diferente)
if (place_meeting(x, y, obj_gato))
{
    // Cria a dinamite feia exatamente no mesmo X e Y do baú
    instance_create_depth(x, y, depth, obj_dinamite);
    
    // O baú some!
    instance_destroy();
}