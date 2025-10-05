function create_macros() {
	#macro g global
	#macro o other
	#macro main obj_main
	#macro cam obj_camera
	
	#macro gp_stickl_u (gp_padr + 1)
	#macro gp_stickl_d (gp_padr + 2)
	#macro gp_stickl_l (gp_padr + 3)
	#macro gp_stickl_r (gp_padr + 4)
	#macro gp_stickr_u (gp_padr + 5)
	#macro gp_stickr_d (gp_padr + 6)
	#macro gp_stickr_l (gp_padr + 7)
	#macro gp_stickr_r (gp_padr + 8)
}

function create_globals() {
	g.fc = 0;
	
	g.g_cols = {
		white: #F2FBFF,
		black: #0F0F12,
		gray: #505359,
		neon: #CBFF70
	};
	
	#macro colors g.g_cols
	
	g.gp_press = [[false, false, false, false, false, false, false, false], [false, false, false, false, false, false, false, false]];
	g.gp_pressed = [[false, false, false, false, false, false, false, false], [false, false, false, false, false, false, false, false]];
	g.gp_released = [[false, false, false, false, false, false, false, false], [false, false, false, false, false, false, false, false]];
	
	g.pause = false;
	
	g.rich_txt = "";
	g.rich_txt_frame = 0;
	
	g.state_names = [
		"ALASKA", "ALABAMA", "ARKANSAS", "ARIZONA", "CALIFORNIA",
		"COLORADO", "CONNECTICUT", "DELAWARE", "FLORIDA", "GEORGIA",
		"HAWAII", "IOWA", "IDAHO", "ILLINOIS", "INDIANA",
		"KANSAS", "KENTUCKY", "LOUISIANA", "MASSACHUSETTS", "MARYLAND",
		"MAINE", "MICHIGAN", "MINNESOTA", "MISSOURI", "MISSISSIPPI",
		"MONTANA", "NORTH CAROLINA", "NORTH DAKOTA", "NEBRASKA", "NEW HAMPSHIRE",
		"NEW JERSEY", "NEW MEXICO", "NEVADA", "NEW YORK", "OHIO",
		"OKLAHOMA", "OREGON", "PENNSYLVANIA", "RHODE ISLAND", "SOUTH CAROLINA",
		"SOUTH DAKOTA", "TENNESSEE", "TEXAS", "UTAH", "VIRGINIA",
		"VERMONT", "WASHINGTON", "WISCONSIN", "WEST VIRGINIA", "WYOMING"
	]
	
	g.solid_tiles = [
		3, 6, 8, 9, 11, 14, 17, 19, 20, 34, 39, 48, 53
	];
	
	g.platform_tiles = [
		5, 16, 18, 21, 27, 28, 29, 30, 33, 35, 38, 45, 46, 47, 49, 50, 51, 52, 55, 58, 59, 62, 63, 64, 69
	];
	
	g.gp_last = -1;
	g.gp_any = false;
	
	#macro gamepad_last g.gp_last
	#macro keyboard_last keyboard_lastkey
	#macro gp_anykey g.gp_any
}

function create_savefile() {
	g.save = {};
	#macro s g.save
	s.savedata = {};
	s.settings = {};
	#macro sd s.savedata
	#macro ss s.settings
	ss.fullscreen = true;
	ss.resolution = {
		w: 960,
		h: 540
	};
	ss.vsync = true;
	ss.vol = 0.75;
	ss.mute = false;
	ss.controller = false;
	ss.kb_controls = {
		left: ord("A"),
		right: ord("D"),
		up: ord("W"),
		jump: vk_space,
		shoot:  ord("J")
	};
	ss.gp_controls = {
		left: gp_stickl_l,
		right: gp_stickl_r,
		up: gp_stickl_u,
		jump: gp_face1,
		shoot: gp_face3
	};
	sd.won = true;
	sd.stamps = [
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false,
		false, false, false, false, false
	];
}

function save(_filename, _encrypt, _struct) {
	var _str = "";
	_str = json_stringify(_struct);
	_str = (_encrypt ? base64_encode(_str) : _str);
	var _file = file_text_open_write(_filename);
	file_text_write_string(_file, _str);
	file_text_close(_file);
}

function load(_filename, _encrypted) {
	if (file_exists(_filename)) {
		try {
			var _file = file_text_open_read(_filename);
			var _str = file_text_read_string(_file);
			_str = (_encrypted ? base64_decode(_str) : _str);
			var _struct = json_parse(_str);
			return (_struct);
		} catch(but) {
			print(but.message);
		}
	}
	return -1;
}

function save_savefile() { save("save.txt", true, sd); }
function save_settings() { save("settings.txt", false, ss); }

function load_savefile() { var _struct = load("save.txt", true); sd = struct_merge(sd, _struct); }
function load_settings() { var _struct = load("settings.txt", false); ss = struct_merge(ss, _struct); }

function handle_fullscreen() {
	var _f = keyboard_check_pressed(ord("F"));
	if (_f) { switch_fullscreen(); }
	var _full = window_get_fullscreen();
	ss.fullscreen = _full;
}

function switch_fullscreen() {
	var _full = !window_get_fullscreen();
	set_fullscreen(_full);
}

function set_fullscreen(_full) {
	window_set_fullscreen(_full);
	if (_full) {
		window_set_size(2560, 1440);
	} else {
		window_set_size(ss.resolution.w, ss.resolution.h);
	}
	display_reset(0, ss.vsync);
}

function sift_resolutions() {
	if (!ss.fullscreen) {
		if (ss.resolution.w == 960) {
			ss.resolution.w = 1920;
			ss.resolution.h = 1080;
		} else {
			ss.resolution.w = 960;
			ss.resolution.h = 540;
		}
		window_set_size(ss.resolution.w, ss.resolution.h);
		display_reset(0, ss.vsync);
	}
}

function toggle_vsync() {
	ss.vsync = !ss.vsync;
	display_reset(8, ss.vsync);
}

function handle_restart() {
	var _r = keyboard_check_pressed(ord("R"));
	if (_r) { video_close(); game_restart(); }
}

function handle_gameclose() {
	var _esc = keyboard_check_pressed(vk_escape);
	if (_esc) { game_end(); }
}

function handle_pause() {
	var _esc = keyboard_check_pressed(vk_escape);
	if (_esc) { g.pause = !g.pause; }
	/*
	with (obj_) {
		if (g.pause && image_speed > 0) {
			frozen = true;
			frozen_speed = image_speed;
			image_speed = 0;
		} else if (!g.pause && frozen) {
			frozen = false;
			image_speed = frozen_speed;
		}
	}
	*/
}

function error(_struct) {
	show_debug_message("ERROR: " + string(_struct));
}

function controls_check(_control, _protocol = "menu") {
	var _control_kb = struct_get(ss.kb_controls, _control);
	var _control_gp = struct_get(ss.gp_controls, _control);
	var _kb_check = keyboard_check(_control_kb);
	var _gp1_check = false;
	var _gp2_check = false;
	if (_control_gp > gp_padr) {
		var _control_gp_off = (_control_gp - gp_padr - 1);
		_gp1_check = g.gp_press[@ 0][@ _control_gp_off];
		_gp2_check = g.gp_press[@ 1][@ _control_gp_off];
	} else {
		_gp1_check = gamepad_button_check(0, _control_gp);
		_gp2_check = gamepad_button_check(1, _control_gp);
	}
	if (_protocol == "menu") { return (_kb_check || _gp1_check); }
	if (_protocol == "p2") { return (ss.controller ? (!g.second_controller ? _kb_check : _gp2_check) : _gp1_check); }
	if (_protocol == "not p1") { return (ss.controller ? (_kb_check || _gp2_check) : _gp1_check); }
	return (!ss.controller ? _kb_check : _gp1_check);
}

function controls_check_pressed(_control, _protocol = "menu") {
	var _control_kb = struct_get(ss.kb_controls, _control);
	var _control_gp = struct_get(ss.gp_controls, _control);
	var _kb_check = keyboard_check_pressed(_control_kb);
	var _gp1_check = false;
	var _gp2_check = false;
	if (_control_gp > gp_padr) {
		var _control_gp_off = (_control_gp - gp_padr - 1);
		_gp1_check = g.gp_pressed[@ 0][@ _control_gp_off];
		_gp2_check = g.gp_pressed[@ 1][@ _control_gp_off];
	} else {
		_gp1_check = gamepad_button_check_pressed(0, _control_gp);
		_gp2_check = gamepad_button_check_pressed(1, _control_gp);
	}
	if (_protocol == "menu") { return (_kb_check || _gp1_check); }
	if (_protocol == "p2") { return (ss.controller ? (!g.second_controller ? _kb_check : _gp2_check) : _gp1_check); }
	if (_protocol == "not p1") { return (ss.controller ? (_kb_check || _gp2_check) : _gp1_check); }
	return (!ss.controller ? _kb_check : _gp1_check);
}

function controls_check_released(_control, _protocol = "menu") {
	var _control_kb = struct_get(ss.kb_controls, _control);
	var _control_gp = struct_get(ss.gp_controls, _control);
	var _kb_check = keyboard_check_released(_control_kb);
	var _gp1_check = false;
	var _gp2_check = false;
	if (_control_gp > gp_padr) {
		var _control_gp_off = (_control_gp - gp_padr - 1);
		_gp1_check = g.gp_released[@ 0][@ _control_gp_off];
		_gp2_check = g.gp_released[@ 1][@ _control_gp_off];
	} else {
		_gp1_check = gamepad_button_check_released(0, _control_gp);
		_gp2_check = gamepad_button_check_released(1, _control_gp);
	}
	if (_protocol == "menu") { return (_kb_check || _gp1_check); }
	if (_protocol == "p2") { return (ss.controller ? (!g.second_controller ? _kb_check : _gp2_check) : _gp1_check); }
	if (_protocol == "not p1") { return (ss.controller ? (_kb_check || _gp2_check) : _gp1_check); }
	return (!ss.controller ? _kb_check : _gp1_check);
}

function reset_binds() {
	if (!ss.controller) {
		ss.kb_controls = {
			left: ord("A"),
			right: ord("D"),
			up: ord("W"),
			jump: vk_space,
			shoot:  ord("J")
		};
	} else {
		ss.gp_controls = {
			left: gp_padl,
			right: gp_padr,
			up: gp_padu,
			jump: gp_face1,
			shoot: gp_face3
		};
	}
}

function position_camera() {
	vx += cam_speed;
}

function lookat_camera() {
	var _delay = 10;
	
	var _ow = camera_get_view_width(camera);
	var _oh = camera_get_view_height(camera);

	var _nw = (_ow - (_ow - zw) / _delay);
	var _nh = (_oh - (_oh - zh) / _delay);

	camera_set_view_size(camera, _nw, _nh);

	if (!g.pause) {
		x -= ((x - vx) / _delay);
		y -= ((y - vy) / _delay);
	}

	var _mw = (_nw / 2);
	var _mh = (_nh / 2);

	

	var _cx = median(_mw, x, room_width - _mw);
	var _cy = median(_mh, y, room_height - _mh);

	x = _cx;
	y = _cy;
	
	print(_cy);

	var _vm = matrix_build_lookat(_cx, _cy, -10, _cx, _cy, 0, 0, 1, 0);
	camera_set_view_mat(camera, _vm);
}