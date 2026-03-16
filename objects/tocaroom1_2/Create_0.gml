// O ponto de exclamação (!) significa "NÃO".
// Ou seja: "Se essa música NÃO estiver tocando agora..."
if (!audio_is_playing(Last_dance5))
{
    // ...então pode dar o Play!
    audio_play_sound(Last_dance5, 1, true);
}