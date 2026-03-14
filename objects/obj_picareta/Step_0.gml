// 1. Aplica a gravidade e o movimento
vspd = vspd + grv;
x = x + hspd;
y = y + vspd;

// 2. Efeito visual: Faz a picareta girar no ar!
// Ela gira para trás ou para frente dependendo de qual lado foi jogada
image_angle -= 15 * sign(hspd); 

// 3. Limpeza: Destrói a picareta se ela cair para fora da tela (ou bater no chão, se preferir)
if (y > room_height + 100)
{
    instance_destroy();
}