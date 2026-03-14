if (estado == "esperando")
{
    // Radar largo! 80 pixels de distância já ativa a queda.
    if (abs(obj_gato.x - x) < 60) and (obj_gato.y > y)
    {
        estado = "caindo";
    }
}
else if (estado == "caindo")
{
    // Física de queda
    vspd += grv;
    y += vspd;
    
    // Destrói ao bater no chão
    if (place_meeting(x, y + vspd, obj_parede)) { instance_destroy(); }
}