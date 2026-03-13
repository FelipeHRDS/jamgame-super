// Aplica a gravidade para ele ir caindo cada vez mais rápido
vspd = vspd + grv;
y = y + vspd;

// Se ele encostar na parede (chão), ele se destrói
if place_meeting(x, y, obj_parede)
{
    instance_destroy();
}