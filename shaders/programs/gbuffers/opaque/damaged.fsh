#ifndef MC_GL_RENDERER_RADEON
    layout(location = 0) out vec4 out_color;
#endif

#include "/lib/important.glsl"

//Samplers
uniform sampler2D gcolor;

//Uniforms
/* Nothing to see here */

//Fragment inputs
in vec2 texture_coordinate;

#ifdef MC_GL_RENDERER_RADEON
    vec4 out_color;
#endif

/* DRAWBUFFERS:0 */
void main() {
    out_color.rgb = texture(gcolor, texture_coordinate).rgb;
    if(texture(gcolor, texture_coordinate).a < 0.1) discard;
    out_color.a = 1.0;

    #ifdef MC_GL_RENDERER_RADEON
        gl_FragData[0] = out_color;
    #endif
}