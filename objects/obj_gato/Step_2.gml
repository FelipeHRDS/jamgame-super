// Mecânica da camera seguir o player

if (instance_exists(obj_gato))
{
    halfViewWidth = camera_get_view_width(view_camera[0]) / 2;
    halfViewHeight = camera_get_view_height(view_camera[0]) / 2;

    camera_set_view_pos(view_camera[0], obj_gato.x - halfViewWidth, obj_gato.y - halfViewHeight);
}

// Pega a posição X e Y exata da câmera neste frame
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);


layer_x("BG_1", -cam_x * 0.0);
layer_x("BG_2", -cam_x * 0.05);
layer_x("BG_3", -cam_x * 0.07);
layer_x("BG_4", -cam_x * 0.12);
layer_x("BG_5", -cam_x * 0.15);


