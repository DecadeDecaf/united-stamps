if (hit) {
	image_xscale -= 0.15;
	image_yscale -= 0.15;
	if (image_xscale <= 0.3) {
		instance_destroy();
	}
	exit;
}

repeat (5) {
	x += lengthdir_x(spd, dir);
	y += lengthdir_y(spd, dir);

	var _width = 16;

	var _point_x = (x + lengthdir_x(_width, dir));
	var _point_y = (y + lengthdir_y(_width, dir));
	
	with (obj_enemy) {
		if (activated && position_meeting(_point_x, _point_y, id)) {
			if (!immaterial) {
				if (!immune) {
					hp--;
					flash = 4;
					game_set_speed(40, gamespeed_fps);
				}
				o.hit = true;
				break;
			}
		}
	}

	if (!hit && (collision(_point_x, _point_y) || life <= 0)) {
		hit = true;
	}
	
	life--;
	
	if (hit) {
		x = _point_x;
		y = _point_y;
		sprite_index = spr_bullet_hit;
		image_angle = random_range(0, 360);
		break;
	}
}