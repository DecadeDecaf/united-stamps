if (float_down) {
	if (yv > 0 && collision(x, y + 80)) {
		yv /= 1.1;
	} else if (yv < 0) {
		yv += 0.25;
	} else if (yv < 2) {
		yv += 0.05;
	}
}

if (cam.x > x - 420) {
	if (escape_down) {
		yv += 0.01;
		yv *= 1.04;
	}
}

if (cam.x > x - 300) {
	if (escape_up) {
		yv -= 0.01;
		yv *= 1.04;
	}
}

if (cam.x > x) {
	if (escape_down_slow) {
		yv += 0.01;
		yv *= 1.04;
	}
}

x += xv;
y += yv;