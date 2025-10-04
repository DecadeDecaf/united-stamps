if (!activated) {
	if (cam.x > x - 540) {
		activated = true;
	} else {
		exit;
	}
}

if (hp <= 0) {
	instance_destroy();
}

if (behavior == "eagle") {
	if (eggs > 0) {
		xv = 2.5;
	} else if (xv > 0.5) {
		xv -= 0.025;
	}
	x -= xv;
	if (eggs > 0 && cooldown <= 0 && x < cam.x + 300) {
		var _egg = instance_create_depth(x, y + 30, depth + 1, obj_enemy);
		_egg.sprite_index = spr_egg;
		_egg.behavior = "egg";
		_egg.yv = 0.25;
		_egg.hp = 3;
		_egg.image_xscale = 0.5;
		_egg.image_yscale = 0.5;
		cooldown = 55;
		eggs--;
	}
}

if (behavior == "egg") {
	if (image_xscale < 1) {
		image_xscale += 0.05;
		image_yscale += 0.05;
	}
	yv *= 1.0225;
	y += yv;
	if (any_collision()) {
		instance_destroy();
	}
}

if (behavior == "yolk") {
	if (!landed) {
		yv += 0.075;
		y += yv;
		if (any_collision()) {
			yv = 0;
			move_snap(0, 50);
			landed = true;
		}
	}
	if (yv < -0.4) { image_index = 0; }
	else if (yv > 0.4) { image_index = 1; }
	else { image_index = 2; }
}

if (cooldown > 0) {
	cooldown--;
}

if (flash > 0) {
	flash--;
}