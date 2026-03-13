draw_self();

if (active)
{
    // Escolhe a cor da linha (c_white, c_red, c_gray, c_black...)
    draw_set_color(c_maroon); 
    
    // Desenha a linha com uma espessura (neste caso, 2 pixels)
    draw_line_width(x, y, mx, my, 2); 
    
    // É sempre uma boa prática resetar a cor para branco no final, 
    // para não afetar o desenho de outros objetos!
    draw_set_color(c_white); 
}