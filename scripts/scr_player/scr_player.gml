function collision(_xx, _yy, _platform = false) {
	var _lay = layer_get_id("tiles");
	var _map = layer_tilemap_get_id(_lay);

	var _tile = tilemap_get_at_pixel(_map, _xx, _yy);
	var _tile_cell = tilemap_get_cell_y_at_pixel(_map, _xx, _yy);
	var _coll = false;

	if (array_has(g.solid_tiles, _tile)) {
		_coll = true;
	}
	
	if (_platform) {
		var _knee_tile = tilemap_get_at_pixel(_map, _xx, _yy - max(yv, 4));
		var _knee_tile_cell = tilemap_get_cell_y_at_pixel(_map, _xx, _yy - max(yv, 4));
		if (array_has(g.platform_tiles, _tile) && (_knee_tile_cell != _tile_cell) && yv >= 0) {
			_coll = true;
		}
	}

	return _coll;
}

function any_collision(_ignore_platforms = false) {
	var _t = (collision(bbox_left, bbox_top) || collision(bbox_right, bbox_top) || collision(x, bbox_top));
	var _b = (collision(bbox_left, bbox_bottom, !_ignore_platforms) || collision(bbox_right, bbox_bottom, !_ignore_platforms) || collision(x, bbox_bottom, !_ignore_platforms));
	var _l = (collision(bbox_left, bbox_top) || collision(bbox_left, bbox_bottom));
	var _r = (collision(bbox_right, bbox_top) || collision(bbox_right, bbox_bottom));
	var _edge = (bbox_top < 0 || bbox_left < 0 || bbox_right > room_width);
	
	return (_t || _b || _l || _r || _edge);
}

function player_die() {
	if (!dead) {
		dead = true;
		alarm[0] = 90;
		for (var _b = 0; _b < 45; _b += 9) {
			var _boom = instance_create_depth(x + random_range(-20, 20), y - 30 + random_range(-25, 25), depth - 1, obj_boom);
			_boom.delay = _b;
		}
	}
}