if (float_down) {
	if (collision(x, y + 80)) {
		yv /= 1.1;
	} else {
		yv = 2;
	}
}

x += xv;
y += yv;