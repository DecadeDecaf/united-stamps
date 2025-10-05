image_xscale -= 0.1;
image_yscale -= 0.1;

if (image_xscale <= 0.3) {
	instance_destroy();
}