var _left = controls_check("left");
var _right = controls_check("right");
var _up = controls_check("up");

var _jump = controls_check_pressed("jump");
var _jumping = controls_check("jump");

var _shoot = controls_check("shoot");

if (dead) {
	exit;
}

if (control_loss > 0) {
	control_loss--;
}

var _loss = control_loss / 10;

if (_left) {
	image_xscale = -1;
	xv -= (spd / max(_loss, 1));
}

if (_right) {
	image_xscale = 1;
	xv += (spd / max(_loss, 1));
}

var _cap = (30 + (_loss * 4));
var _fric = (((fric - 1) / max(_loss, 1)) + 1);
var _grav = grav;

xv /= _fric;
xv = clamp(xv, -_cap, _cap);

yv += _grav;
yv = clamp(-_cap, yv, _cap);

if (held > 0 && _jumping) {
	yv -= _grav;
	held--;
} else {
	held = 0;
}

y += yv;

if (any_collision() && yv != 0) {
	y -= yv;
	yv = 0;
}

var _ground = (bbox_bottom + 2);

if ((collision(bbox_left, _ground, true) || collision(bbox_right, _ground, true)) && yv >= 0) {
	grounded = 6;
}

if (_jump) {
	if (grounded > 0) {
		yv = -jump_height;
		held = 10;
		grounded = 0;
		sprite_index = spr_player_jump;
		image_index = 0;
	}
}

x += xv;

if (any_collision(true) && xv != 0) {
	x -= xv;
	xv = 0;
}

if (grounded > 0) {
	if (abs(xv) >= 3) {
		if (sprite_index != spr_player_walk) {
			sprite_index = spr_player_walk;
			image_index = 0;
		}
	} else {
		sprite_index = spr_player_idle;
		image_index = 0;
	}
	grounded--;
}

if (cooldown > 0) {
	cooldown--;
}

if (_shoot) {
	if (cooldown <= 0) {
		var _flip = (image_xscale < 0);
		var _dir = (_up ? (_flip ? 135 : 45) : (_flip ? 180 : 0));
		_dir += random_range(-2.5, 2.5);
		var _xx = (x + lengthdir_x(75, _dir));
		var _yy = (y - 28 + lengthdir_y(50, _dir));
		if (!collision(_xx, _yy)) {
			var _bullet = instance_create_depth(_xx, _yy, depth - 1, obj_bullet);
			_bullet.dir = _dir;
		}
		cooldown = fire_rate;
	}
}

with (obj_stamp) {
	if (place_meeting(x, y, o.id) && !sd.stamps[@ state_id]) {
		sd.stamps[@ state_id] = true;
		g.rich_txt = (g.state_names[@ state_id] + " COLLECTED!");
		g.rich_txt_frame = 120;
	}
}

if (place_meeting(x, y, obj_enemy)) {
	player_die();
}