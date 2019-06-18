layout(location = 0) out vec3 color;

#include "/lib/important.glsl"
#include "/lib/color/color_space.glsl"
#include "/lib/encoders/encoder.glsl"

//Samplers
uniform sampler2D colortex0;
uniform sampler2D colortex1;
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

/* DRAWBUFFERS:0 */
void main() {
    pd = fill_pd_struct(texture_coordinate);

    color = texture(colortex0, texture_coordinate).rgb;

    vec3 transparent_color = srgb_to_linear(texture(colortex1, texture_coordinate).rgb);
    float transparent_alpha = texture(colortex1, texture_coordinate).a;

    if(land_mask(pd.depth0)) color = mix(color * mix(vec3(1.0), transparent_color, transparent_alpha), apply_shading(transparent_color), transparent_alpha);
}