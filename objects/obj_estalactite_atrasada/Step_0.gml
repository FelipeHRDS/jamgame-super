if (estado == "esperando")
{
    // Radar estreito (passou exatamente embaixo)
    if (abs(obj_gato.x - x) < 15) and (obj_gato.y > y)
    {
        estado = "armada"; // Muda para o estado de contagem regressiva
    }
}
else if (estado == "armada")
{
    // Efeito visual muito legal: Faz a estalactite tremer freneticamente no teto!
    x = x_original + random_range(-2, 2);
    
    // Diminui o cronômetro
    tempo_atraso -= 1;
    
    // Quando der 1 segundo...
    if (tempo_atraso <= 0)
    {
        x = x_original; // Centraliza ela de volta
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