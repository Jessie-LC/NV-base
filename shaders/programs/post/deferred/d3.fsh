/* DRAWBUFFERS:3 */
layout(location = 0) out vec3 out_sky;

#include "/lib/important.glsl"

//Samplers
/* Nothing to see here */

//Uniforms
uniform mat4 gbufferModelViewInverse, gbufferProjectionInverse;
uniform mat4 gbufferModelView, gbufferProjection;

uniform vec3 sun_vector, moon_vector, up_vector;

uniform vec2 view_size, view_pixel_size;

//Fragment inputs
in vec2 texture_coordinate;

#include "/lib/sky/atmos_projection.glsl"
#include "/lib/color/blackbody_functions.glsl"
#include "/lib/color/light_colors.glsl"
#include "/lib/sky/atmosphere/calculate.glsl"

void main() {
    if(texture_coordinate.y >= exp2(-SKY_RENDER_LOD) || texture_coordinate.x >= exp2(-SKY_RENDER_LOD)) discard;
    out_sky = atmos(unproject_sky(texture_coordinate), vec3(0.0), coefficients_scattering, coefficients_extinction);
}