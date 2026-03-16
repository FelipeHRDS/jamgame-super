// Chama a tela preta de transição (que vai te levar para a próxima fase/cutscene)
if (!instance_exists(obj_transicao))
{
    instance_create_depth(0, 0, -9999, obj_transicao); 
}

audio_stop_sound(welcome_to_dry_land1);