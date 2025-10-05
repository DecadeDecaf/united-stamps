if (dead) {
	exit;
}

var _up = controls_check("up");
var _gun_index = (_up ? 1 : 0);
var _rot = (cooldown * image_xscale);

draw_sprite_ext(spr_player_gun, _gun_index, x, y, image_xscale, image_yscale, _rot, -1, 1);

var _long = 1;

if (yv < 0) {
	_long += (yv * -0.03);
}

if (iframes > 0 && iframes % 20 < 10) { gpu_set_fog(true, colors.white, 1, 1); }

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / _long, image_yscale * _long, 0, -1, 1);

if (iframes > 0 && iframes % 20 < 10) { gpu_set_fog(false, colors.black, 0, 0); }