#ifndef MC_GL_RENDERER_RADEON
    layout(location = 0) out vec3 out_color;
#endif

#include "/lib/important.glsl"

//Samplers
uniform sampler2D gcolor;

//Uniforms
/* Nothing to see here */

//Fragment inputs
flat in vec3 tint;

#ifdef MC_GL_RENDERER_RADEON
    vec3 out_color;
#endif

/* DRAWBUFFERS:0 */
void main() {
    out_color = tint;

    #ifdef MC_GL_RENDERER_RADEON
        gl_FragData[0] = vec4(out_color, 1.0);
    #endif
}