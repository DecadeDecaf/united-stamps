if (g.bonus_lives > 0) {
	dead = false;
	x = cam.x - 240;
	y = 540;
	xv = 0;
	yv = 0;
	iframes = 130;
	g.bonus_lives--;
} else {
	game_restart();
}