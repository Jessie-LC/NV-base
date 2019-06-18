struct position_depth {
    float depth0;
    float depth1;
    float depth2;

    vec3 screen_position;
    vec3 end_screen_position;
    vec3 view_position;
    vec3 end_view_position;
    vec3 scene_position;
    vec3 shadow_view_position;
    vec3 shadow_clip_position;
}pd;

uniform sampler2D depthtex0;
uniform sampler2D depthtex1;
uniform sampler2D depthtex2;

position_depth fill_pd_struct(in vec2 coord) {
    position_depth pd;
    pd.depth0 = texture(depthtex0, coord).r;
    pd.depth1 = texture(depthtex1, coord).r;
    pd.depth2 = texture(depthtex2, coord).r;

    pd.screen_position = vec3(coord, pd.depth0);
    pd.end_screen_position = vec3(coord, pd.depth1);
    pd.view_position = screenspace_to_viewspace(pd.screen_position, gbufferProjectionInverse);
    pd.end_view_position = screenspace_to_viewspace(pd.end_screen_position, gbufferProjectionInverse);
    pd.scene_position = viewspace_to_scenespace(pd.view_position, gbufferModelViewInverse);

    return pd;
}