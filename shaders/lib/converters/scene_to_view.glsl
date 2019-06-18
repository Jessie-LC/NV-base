vec3 scenespace_to_viewspace(in vec3 view_position, in mat4 model_view) {
    return mat3(model_view) * view_position + model_view[3].xyz;
}