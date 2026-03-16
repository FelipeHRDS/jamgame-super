// Guarda as sprites do final do jogo!
paginas = [
    cutscene_final_1, 
    cutscene_final_2,
	Texto_ESCRITO_FINAL // <--- O TEXTO FINAL ENTRA AQUI!
];

pagina_atual = 0; 
tempo_limite = 180; // 3 segundos por tela
tempo_atual = tempo_limite;

estado = "mostrando"; 
alfa = 0; 


audio_play_sound(Rocking_Chair6, 1, true);