if (delay > 0) {
	image_index = 0;
	delay--;
	if (delay <= 0 && sprite_index != spr_splat) {
		audio_play_sound(sfx_boom, 0, false, 0.35, 0, random_range(0.9, 1.1));
	}
}