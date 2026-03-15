// Pega o tamanho exato da tela do jogador
var largura = display_get_gui_width();
var altura = display_get_gui_height();

// Configura a "tinta" do GameMaker
draw_set_alpha(alfa);
draw_set_color(c_black);

// Desenha o quadrado preto gigante cobrindo tudo
draw_rectangle(0, 0, largura, altura, false);

// MUITO IMPORTANTE: Reseta a transparência para 1 no final!
// Se esquecer isso, o jogo inteiro (textos, menus) vai ficar transparente depois.
draw_set_alpha(1);