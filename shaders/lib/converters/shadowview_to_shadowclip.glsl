vec3 shadowview_to_shadowclip(in vec3 shadow_view, in mat4 shadow_projection) {
    return mat3(shadow_projection) * shadow_view + shadow_projection[3].xyz;
}