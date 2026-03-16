// O ponto de exclamação (!) significa "NÃO".
// Ou seja: "Se essa música NÃO estiver tocando agora..."
if (!audio_is_playing(Watch_out_for_the_vulture3))
{
    // ...então pode dar o Play!
    audio_play_sound(Watch_out_for_the_vulture3, 1, true);
}