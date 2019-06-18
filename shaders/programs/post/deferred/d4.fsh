layout(location = 0) out vec3 color;
layout(location = 1) out vec4 transparent;

#include "/lib/important.glsl"
#include "/lib/color/color_space.glsl"
#include "/lib/encoders/encoder.glsl"

//Samplers
uniform sampler2D colortex0;
uniform sampler2D colortex2;
uniform sampler2D colortex3;

//Uniforms
uniform mat4 gbufferModelViewInverse, gbufferProjectionInverse;
uniform mat4 gbufferModelView, gbufferProjection;

uniform vec3 sun_vector, moon_vector, up_vector;

uniform vec2 view_size, view_pixel_size;

//Fragment inputs
flat in vec4[3] shcoeffs;
in vec2 texture_coordinate;

#include "/lib/converters/converters.glsl"
#include "/lib/structs/posdepth_struct.glsl"
#include "/lib/sky/atmos_projection.glsl"
#include "/lib/color/blackbody_functions.glsl"
#include "/lib/fragment/shading/apply.glsl"

/* DRAWBUFFERS:01 */
void main() {
    pd = fill_pd_struct(texture_coordinate);

    color = srgb_to_linear(texture(colortex0, texture_coordinate).rgb);
    if(land_mask(pd.depth0)) {
        color = apply_shading(color, true);
    } else {
        color = texture(colortex3, project_sky(normalize(pd.scene_position))).rgb;
    }

    transparent = vec4(0.0);
}