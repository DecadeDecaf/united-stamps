if (!activated) {
	if (cam.x > activation_x) {
		activated = true;
	} else {
		exit;
	}
}

if (hp <= 0) {
	instance_destroy();
	exit;
}

if (image_xscale > 0 && image_xscale < 1) {
	image_xscale += 0.05;
	image_yscale += 0.05;
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
	yv *= 1.0225;
	y += yv;
	if (any_collision()) {
		drop_stamp = -1;
		instance_destroy();
		exit;
	}
}

if (behavior == "yolk") {
	yoff = 10;
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
	yoff = 350;
	if (beam == -1) {
		beam = instance_create_depth(x, y, depth + 101, obj_enemy);
		beam.sprite_index = spr_ufo_beam;
		beam.behavior = "beam";
		beam.immaterial = true;
		beam.ufo = id;
		beam.alternate = alternate;
	}
}

if (behavior == "beam") {
	if (g.fc % 150 < 75) {
		image_index = (alternate ? 1 : 0);
	} else {
		image_index = (alternate ? 0 : 1);
	}
	if (!instance_exists(ufo)) {
		instance_destroy();
		exit;
	}
}

if (behavior == "corn dog") {
	yoff = 30;
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
		if (collision(bbox_left, y - yoff) || collision(bbox_right, y - yoff)) {
			drop_stamp = -1;
			instance_destroy();
			exit;
		}
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

if (behavior == "baseball") {
	yoff = 15;
	var _cap = 30;
	var _fric = 1.015;
	var _grav = 0.5;
	xv /= _fric;
	xv = clamp(xv, -_cap, _cap);
	yv += _grav;
	yv = clamp(-_cap, yv, _cap);
	x += xv;
	y += yv;
	var _ground = (bbox_bottom + 2);
	if ((collision(bbox_left, _ground, true) || collision(bbox_right, _ground, true)) && yv >= 0) {
		move_snap(0, 50);
		yv *= -0.75;
		if (abs(yv) < 4) {
			drop_stamp = -1;
			instance_destroy();
			exit;
		}
	}
}

if (behavior == "coin") {
	yoff = (sprite_index == spr_quarter ? 20 : 15);
	var _cap = 30;
	var _fric = 1;
	var _grav = 0.5;
	xv /= _fric;
	xv = clamp(xv, -_cap, _cap);
	yv += _grav;
	yv = clamp(-_cap, yv, _cap);
	x += xv;
	y += yv;
	var _ground = (bbox_bottom + 2);
	if ((collision(bbox_left, _ground, true) || collision(bbox_right, _ground, true)) && yv >= 0) {
		move_snap(0, 50);
		yv *= -0.75;
		if (abs(yv) < 4) {
			yv = 0;
		}
	}
	if (collision(bbox_left, y - yoff)) {
		drop_stamp = -1;
		instance_destroy();
		exit;
	}
}

if (behavior == "white house") {
	yoff = 100;
	if (cooldown <= 0) {
		cooldown = (irandom_range(0, 3) == 0 ? 30 : 120);
		var _spawn_rand = irandom_range(0, 9);
		var _spawn;
		switch (_spawn_rand) {
			default:
			case 0:
				_spawn = instance_create_depth(x - 40, y - 100, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_eagle;
				_spawn.behavior = "eagle";
				_spawn.hp = 5;
				_spawn.image_xscale = 0.5;
				_spawn.image_yscale = 0.5;
				cooldown = 120;
				break;
			case 1:
			case 2:
				_spawn = instance_create_depth(x - 40, y - 100, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_football;
				_spawn.behavior = "football";
				_spawn.hp = 3;
				_spawn.image_xscale = 0.5;
				_spawn.image_yscale = 0.5;
				break;
			case 3:
			case 4:
				_spawn = instance_create_depth(x - 40, y - 30, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_football;
				_spawn.behavior = "football";
				_spawn.hp = 3;
				_spawn.image_xscale = 0.5;
				_spawn.image_yscale = 0.5;
				break;
			case 5:
			case 6:
				_spawn = instance_create_depth(x - 40, y - 80, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_penny;
				_spawn.behavior = "coin";
				_spawn.hp = 3;
				_spawn.xv = -5;
				_spawn.image_xscale = 0.5;
				_spawn.image_yscale = 0.5;
				break;
			case 7:
			case 8:
				_spawn = instance_create_depth(x - 40, y - 30, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_nickel;
				_spawn.behavior = "coin";
				_spawn.hp = 3;
				_spawn.xv = -3.5;
				_spawn.yv = -3;
				_spawn.image_xscale = 0.5;
				_spawn.image_yscale = 0.5;
				break;
			case 9:
				_spawn = instance_create_depth(x - 40, y - 30, depth - 1, obj_enemy);
				_spawn.sprite_index = spr_corndog;
				_spawn.behavior = "corn dog";
				_spawn.hp = 3;
				_spawn.image_xscale = -1
				cooldown = 120;
				break;
		}
		spawned = 30;
	}
	if (spawned > 0) {
		spawned--;
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