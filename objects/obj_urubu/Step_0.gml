// Se a posição X do urubu for menor que -100 (bem fora da tela pela esquerda)
if (x < -100) 
{
    instance_destroy();
}


//Mecanica de soltar o projetil

if instance_exists(obj_gato)
{

    var distancia_x = abs(x - obj_gato.x);
    

    if (distancia_x < 30) and (ja_soltou == false)
    {

        instance_create_layer(x, y + 3, "Instances", obj_arremessavel);
        
        ja_soltou = true; 
    }
}