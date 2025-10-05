if (!deathrattle) {
	exit;
}

if (behavior == "egg") {
	var _yolk = instance_create_depth(x, y - 20, depth, obj_enemy);
	_yolk.sprite_index = spr_yolk;
	_yolk.behavior = "yolk";
	_yolk.yv = -yv / 2;
	_yolk.hp = 3;
	_yolk.drop_stamp = drop_stamp;
	var _boom = instance_create_depth(x, y, depth - 1, obj_boom);
	_boom.sprite_index = spr_splat;
	exit;
} else if (behavior == "tractor" || behavior == "white house") {
	for (var _b = 0; _b < 60; _b += 6) {
		var _boom = instance_create_depth(x + random_range(-50, 50), y - yoff + random_range(-40, 40), depth - 1, obj_boom);
		_boom.delay = _b;
	}
} else if (behavior != "beam") {
	for (var _b = 0; _b < 27; _b += 9) {
		var _boom = instance_create_depth(x + random_range(-20, 20), y - yoff + random_range(-25, 25), depth - 1, obj_boom);
		_boom.delay = _b;
	}
}

if (drop_stamp != -1) {
	var _yy = y - yoff;
	if (behavior == "tractor") { _yy = (y - 60); }
	var _stamp = instance_create_depth(x, _yy, 5, obj_stamp);
	_stamp.state_id = drop_stamp;
	_stamp.float_down = true;
	_stamp.yv = -6;
}

if (instance_exists(beam)) {
	instance_destroy(beam);
}

if (behavior == "white house") {
	sd.won = true;
	g.rich_txt = ("YOU WIN! STAMP-VISION UNLOCKED!");
	g.rich_txt_frame = 220;
	with (obj_main) {
		alarm[0] = 240;
	}
}