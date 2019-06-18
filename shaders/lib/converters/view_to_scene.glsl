vec3 viewspace_to_scenespace(in vec3 view_position, in mat4 model_view_inverse) {
    return mat3(model_view_inverse) * view_position + model_view_inverse[3].xyz;
}