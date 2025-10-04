camera = camera_create();

vx = 576;
vy = 810;

cam_speed = 0.75;

x = vx;
y = vy;

zw = 960;
zh = 540;

camera_set_view_size(camera, zw, zh);

var _vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var _pm = matrix_build_projection_ortho(960, 540, -10000, 10000);

camera_set_view_mat(camera, _vm);
camera_set_proj_mat(camera, _pm);

view_camera[0] = camera;