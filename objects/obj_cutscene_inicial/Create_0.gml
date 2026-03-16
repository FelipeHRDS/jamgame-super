// Guarda todas as sprites na ordem exata da sua cutscene
paginas = [
    sprite_cutscene_1, 
    sprite_cutscene_2, 
    sprite_cutscene_3, 
    sprite_cutscene_4, 
    sprite_cutscene_5, 
    sprite_cutscene_6,
	Texto_escrito_inicial // <--- O TEXTO ENTRA AQUI NO FINAL!
];

pagina_atual = 0; // Começa lendo a imagem 0 (que é a cutscene_1)

// Configuração de Tempo (60 frames = 1 segundo)
tempo_limite = 180; // 3 segundos por tela (ajuste como quiser)
tempo_atual = tempo_limite;

// Controle da Transição
estado = "mostrando"; // Os estados serão: "mostrando", "escurecendo", "clareando"
alfa = 0; // Transparência do escurecimento

// Toca a música. 
// O número 1 é a prioridade.
// O "true" no final é a mágica: ele avisa o GameMaker para tocar em LOOP infinito!
audio_play_sound(Meowing2, 1, true);