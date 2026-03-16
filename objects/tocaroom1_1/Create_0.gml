// O ponto de exclamação (!) significa "NÃO".
// Ou seja: "Se essa música NÃO estiver tocando agora..."
if (!audio_is_playing(Echoing4))
{
    // ...então pode dar o Play!
    audio_play_sound(Echoing4, 1, true);
}