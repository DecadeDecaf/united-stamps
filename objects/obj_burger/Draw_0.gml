draw_sprite(spr_burger, 4, x, y);
draw_sprite(spr_burger, 3, x, y - ((y - bounce_y) * 0.25));
draw_sprite(spr_burger, 2, x, y - ((y - bounce_y) * 0.5));
draw_sprite(spr_burger, 1, x, y - ((y - bounce_y) * 0.75));
draw_sprite(spr_burger, 0, x, bounce_y);