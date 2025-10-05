if (!activated) {
	if (cam.x > activation_x) {
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
		xv /= 1.005;
	}
	x -= xv;
	if (eggs > 0 && cooldown <= 0 && x < cam.x + 300) {
		var _egg = instance_create_depth(x, y + 15, depth + 1, obj_enemy);
		_egg.sprite_index = spr_egg;
		_egg.behavior = "egg";
		_egg.yv = 0.25;
		_egg.hp = 2;
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

if (behavior == "ufo") {
	if (beam == -1) {
		beam = instance_create_depth(x, y, depth + 1, obj_enemy);
		beam.sprite_index = spr_ufo_beam;
		beam.behavior = "beam";
		beam.immaterial = true;
		beam.ufo = id;
	}
}

if (behavior == "beam") {
	if (!instance_exists(ufo)) {
		instance_destroy();
		exit;
	}
}

if (behavior == "corn dog") {
	yoff = 25;
	if (grounded) {
		if (cooldown <= 0) {
			xv = 5 * image_xscale;
			yv = -10;
			grounded = false;
			image_index = 0;
		}
	} else {
		var _cap = 30;
		var _fric = 1.025;
		var _grav = 0.35;
		xv /= _fric;
		xv = clamp(xv, -_cap, _cap);
		yv += _grav;
		yv = clamp(-_cap, yv, _cap);
		x += xv;
		y += yv;
		var _ground = (bbox_bottom + 2);
		if ((collision(bbox_left, _ground, true) || collision(bbox_right, _ground, true)) && yv >= 0) {
			move_snap(0, 50);
			grounded = true;
			image_index = 1;
			cooldown = 20;
		}
	}
	if (grounded) {
		if (x < obj_player.x - 40) {
			image_xscale = 1;
		} else if (x > obj_player.x + 40) {
			image_xscale = -1;
		}
	}
}

if (behavior == "tractor") {
	yoff = 50;
	if (x > 6200) {
		xv /= 1.035;
	} else {
		xv = 2;
	}
	x += xv;
	if (cooldown <= 0) {
		cooldown = 20;
	}
}

if (behavior == "football") {
	x -= 5;
	if (any_collision(true)) {
		instance_destroy();
	}
}

if (cooldown > 0) {
	cooldown--;
}

if (flash > 0) {
	flash--;
}

if (drop_stamp != -1 && sd.won) {
	if (g.fc % 4 == 0) {
		var _sparkle = instance_create_depth(x + random_range(-20, 20), y - yoff + random_range(-25, 25), depth, obj_sparkle);
		if (irandom_range(0, 1) == 0) {
			_sparkle.sprite_index = spr_sparkle_neon;
			_sparkle.depth++;
		} else {
			_sparkle.sprite_index = spr_sparkle_white;
			_sparkle.depth--;
		}
	}
}