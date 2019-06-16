layout(location = 0) out vec3 out_color;

#include "/lib/important.glsl"
#include "/lib/color/color_space.glsl"

//Samplers
uniform sampler2D colortex0;

//Uniforms
/* Nothing to see here */

//Fragment inputs
in vec2 texture_coordinate;

/* DRAWBUFFERS:0 */
void main() {
    out_color = srgb_to_linear(texture(colortex0, texture_coordinate).rgb);
}