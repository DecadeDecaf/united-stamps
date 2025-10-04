if (hit) {
	image_xscale -= 0.15;
	image_yscale -= 0.15;
	if (image_xscale <= 0.3) {
		instance_destroy();
	}
	exit;
}

repeat (3) {
	x += lengthdir_x(spd, dir);
	y += lengthdir_y(spd, dir);

	var _width = 16;

	var _point_x = (x + lengthdir_x(_width, dir));
	var _point_y = (y + lengthdir_y(_width, dir));
	
	with (obj_enemy) {
		if (activated && position_meeting(_point_x, _point_y, id)) {
			hp--;
			flash = 4;
			o.hit = true;
			game_set_speed(40, gamespeed_fps);
			break;
		}
	}

	if (!hit && collision(_point_x, _point_y)) {
		hit = true;
	}
	
	if (hit) {
		x = _point_x;
		y = _point_y;
		sprite_index = spr_bullet_hit;
		image_angle = random_range(0, 360);
	}
}