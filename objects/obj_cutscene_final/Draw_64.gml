var largura = display_get_gui_width();
var altura = display_get_gui_height();

// 1. DESENHA A IMAGEM DA CUTSCENE
var sprite_agora = paginas[pagina_atual];
// O "stretched" estica a sua arte para preencher a tela toda perfeitamente
draw_sprite_stretched(sprite_agora, 0, 0, 0, largura, altura);

// 2. DESENHA A TELA PRETA DA TRANSIÇÃO POR CIMA
draw_set_alpha(alfa);
draw_set_color(c_black);
draw_rectangle(0, 0, largura, altura, false);

// MUITO IMPORTANTE: Reseta a transparência e a cor!
draw_set_alpha(1); 
draw_set_color(c_white);