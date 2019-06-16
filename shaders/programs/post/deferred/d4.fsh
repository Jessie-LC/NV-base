layout(location = 0) out vec3 color;

#include "/lib/important.glsl"
#include "/lib/color/color_space.glsl"
#include "/lib/encoders/encoder.glsl"

//Samplers
uniform sampler2D colortex0;
uniform sampler2D colortex2;

//Uniforms
/* Nothing to see here */

//Fragment inputs
in vec2 texture_coordinate;

#include "/lib/structs/posdepth_struct.glsl"

#include "/lib/color/blackbody_functions.glsl"
#include "/lib/fragment/shading/apply.glsl"

/* DRAWBUFFERS:0 */
void main() {
    pd = fill_pd_struct(texture_coordinate);

    color = srgb_to_linear(texture(colortex0, texture_coordinate).rgb);
    if(!land_mask(pd.depth0)) {
        color = vec3(0.1, 0.4, 1.0);
    } else {
        color = apply_shading(color);
    }
}