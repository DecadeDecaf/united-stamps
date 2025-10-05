bounce_yv += 0.6;
bounce_y += bounce_yv;

if (bounce_y >= y) {
	bounce_y = y;
	bounce_yv = 0;
}