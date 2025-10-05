if (!activated) {
	exit;
}

var _long = 1;

if (behavior == "corn dog") {
	if (yv < 0) {
		_long += (yv * -0.03);
	}
}

if (behavior == "tractor") {
	_long -= (cooldown * -0.0025 * xv);
}

if (behavior == "white house") {
	_long -= (spawned * -0.0015);
}

if (drop_stamp != -1 && sd.won) {
	gpu_set_fog(true, colors.neon, 1, 1);
	for (var _dir = 0; _dir < 360; _dir += 45) {
		var _xx = (x + lengthdir_x(2, _dir));
		var _yy = (y + lengthdir_y(2, _dir));
		draw_sprite_ext(sprite_index, image_index, _xx, _yy, image_xscale / _long, image_yscale * _long, 0, -1, 1);
	}
	gpu_set_fog(false, colors.black, 0, 0);
}

if (flash > 0) { gpu_set_fog(true, colors.white, 1, 1); }

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / _long, image_yscale * _long, 0, -1, 1);

if (flash > 0) { gpu_set_fog(false, colors.black, 0, 0); }