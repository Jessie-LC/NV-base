layout(location = 0) out vec3 out_color;

/*
const int colortex0Format = R11F_G11F_B10F; //Scene color
const int colortex1Format = RGBA16F;
const int colortex2Format = RGBA32F;
*/

#include "/lib/important.glsl"
#include "/lib/color/color_space.glsl"

//Samplers
uniform sampler2D colortex0;

//Uniforms
/* Nothing to see here */

//Fragment inputs
in vec2 texture_coordinate;

#include "/lib/color/tonemapping.glsl"

void main() {
    out_color = texture(colortex0, texture_coordinate).rgb;

    out_color = tonemap(out_color);
    
    #if Tonemap != 1
        out_color = linear_to_srgb(out_color);
    #endif
}