if (behavior == "egg") {
	var _yolk = instance_create_depth(x, y - 20, depth, obj_enemy);
	_yolk.sprite_index = spr_yolk;
	_yolk.behavior = "yolk";
	_yolk.yv = -yv / 2;
	_yolk.hp = 5;
}