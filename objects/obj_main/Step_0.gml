if (room == rm_menu) {
	var _start = controls_check_pressed("jump");

	if (_start) {
		var _count = 0;
		for (var _i = 0; _i < 50; _i++) {
			if (sd.stamps[@ _i]) {
				_count++;
			}
		}
		g.bonus_lives = floor(_count / 5);
		audio_play_sound(mus_theme, 1, true);
		room_goto(rm_game);
	}
}

if (g.rich_txt_frame > 0) {
	g.rich_txt_frame--;
}

handle_fullscreen();

handle_pause();

handle_restart();
handle_gameclose();