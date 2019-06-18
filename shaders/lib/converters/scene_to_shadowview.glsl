vec3 scenespace_to_shadowview(in vec3 scene_position, in mat4 shadow_model_view) {
    return mat3(shadow_model_view) * scene_position + shadow_model_view[3].xyz;
}