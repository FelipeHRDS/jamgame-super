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


layer_x("Bg_Ceu", -cam_x * 0.0);
layer_x("Bg_Nuvem", -cam_x * 0.05);
layer_x("Bg_Montanha", -cam_x * 0.07);
layer_x("Bg_Arvore", -cam_x * 0.12);
layer_x("Bg_Pedregulho", -cam_x * 0.15);


