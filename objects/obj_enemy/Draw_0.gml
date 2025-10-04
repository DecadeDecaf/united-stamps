if (flash > 0) { gpu_set_fog(true, colors.white, 1, 1); }

draw_self();

if (flash > 0) { gpu_set_fog(false, colors.black, 0, 0); }