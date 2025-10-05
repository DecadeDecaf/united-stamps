if (behavior == "egg") {
	var _yolk = instance_create_depth(x, y - 20, depth, obj_enemy);
	_yolk.sprite_index = spr_yolk;
	_yolk.behavior = "yolk";
	_yolk.yv = -yv / 2;
	_yolk.hp = 4;
	var _boom = instance_create_depth(x, y, depth - 1, obj_boom);
	_boom.sprite_index = spr_splat;
} else if (behavior == "tractor") {
	for (var _b = 0; _b < 60; _b += 6) {
		var _boom = instance_create_depth(x + random_range(-50, 50), y - yoff + random_range(-40, 40), depth - 1, obj_boom);
		_boom.delay = _b;
	}
} else {
	for (var _b = 0; _b < 27; _b += 9) {
		var _boom = instance_create_depth(x + random_range(-20, 20), y - yoff + random_range(-25, 25), depth - 1, obj_boom);
		_boom.delay = _b;
	}
}

if (drop_stamp != -1) {
	var _yy = y + 20;
	if (behavior == "tractor") { _yy = (y - 60); }
	var _stamp = instance_create_depth(x, _yy, 5, obj_stamp);
	_stamp.state_id = drop_stamp;
	_stamp.float_down = true;
}

if (instance_exists(beam)) {
	instance_destroy(beam);
}