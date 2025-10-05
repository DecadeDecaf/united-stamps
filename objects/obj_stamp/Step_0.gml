if (float_down) {
	if (collision(x, y + 80)) {
		yv /= 1.1;
	} else if (yv < 2) {
		yv += 0.05;
	}
}

x += xv;
y += yv;