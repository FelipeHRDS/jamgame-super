if (estado == "esperando")
{
    // abs() mede a distância exata no eixo X. 15 pixels = quase exatamente embaixo!
    // obj_gato.y > y garante que ela só cai se o gato estiver ABAIXO dela.
    if (abs(obj_gato.x - x) < 15) and (obj_gato.y > y)
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