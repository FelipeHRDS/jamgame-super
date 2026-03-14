spd = 1.6;
hspd = 0;
vspd = 0;
grv = 0.45;

mx = x; // Coordenada do hook no eixo x
my = y; // Coordenada do hook no eixo y

active = false;

hook_timer = 0;

tempo_desgrudar = 20; // Cronômetro da "grudadinha"

morto = false;      // O gato começa vivo, obviamente!
tempo_morte = 60;   // Vai esperar 1 segundo (60 frames) antes de reiniciar a tela