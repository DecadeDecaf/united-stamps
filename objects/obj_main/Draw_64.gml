if (room == rm_menu) {
	draw_set_font(fnt_regular);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(colors.white);
	draw_text(480, 250, "STAMPS COLLECTED:");
	draw_text(240, 100, "PRESS JUMP TO START");
	draw_text(720, 100, "PRESS JUMP TO START");
	draw_set_color(colors.gray);
	draw_text(240, 160, "KEYBOARD:\n\nMOVE: A/D\nAIM: W\nJUMP: SPACEBAR\nSHOOT: J");
	draw_text(720, 160, "CONTROLLER (RECOMMENDED):\n\nMOVE: LEFT STICK\nAIM: LEFT STICK\nJUMP: A\nSHOOT: X");
	draw_text(480, 500, (sd.won ? "STAMP-VISION: ENEMIES THAT DROP STAMPS ARE HIGHLIGHTED" : "BEAT THE GAME TO UNLOCK STAMP-VISION"));
	var _i = 0;
	for (var _xx = 160; _xx < 960; _xx += 160) {
		for (var _yy = 280; _yy < 480; _yy += 20) {
			var _has = (sd.stamps[@ _i]);
			var _txt = (_has ? g.state_names[@ _i] : "???");
			var _col = (_has ? colors.white : colors.gray);
			draw_set_color(_col);
			draw_text(_xx, _yy, _txt);
			_i++;
		}
	}
}

if (g.rich_txt_frame > 0) {
	var _yoff = 0;
	if (g.rich_txt_frame <= 20) {
		_yoff = (-3 * (20 - g.rich_txt_frame));
	}
	draw_set_font(fnt_regular);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(colors.black);
	draw_text(480, 52 + _yoff, g.rich_txt);
	draw_text(480, 51 + _yoff, g.rich_txt);
	draw_text(479, 50 + _yoff, g.rich_txt);
	draw_set_color(colors.white);
	draw_text(480, 50 + _yoff, g.rich_txt);
}

for (var _h = 0; _h < g.bonus_lives; _h++) {
	draw_sprite(spr_heart, 0, 70 + (_h * 23), 70 - (_h * 2));
}