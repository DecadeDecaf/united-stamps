if (room == rm_menu) {
	var _start = controls_check_pressed("jump");

	if (_start) {
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