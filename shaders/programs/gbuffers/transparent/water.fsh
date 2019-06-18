#ifndef MC_GL_RENDERER_RADEON
    layout(location = 0) out vec4 out_color;
    layout(location = 1) out vec4 out_data;
#endif

#include "/lib/important.glsl"
#include "/lib/encoders/encoder.glsl"

//Samplers
uniform sampler2D gcolor;

//Uniforms
/* Nothing to see here */

//Fragment inputs
in vec3 tint;
in vec2 texture_coordinate;
in vec2 lightmap_coordinate;
in float ao;

#ifdef MC_GL_RENDERER_RADEON
    vec4 out_color;
    vec4 out_data;
#endif

/* DRAWBUFFERS:12 */
void main() {
    out_color = texture(gcolor, texture_coordinate) * vec4(tint, 1.0);

    out_data.r = 1.0;
    out_data.g = 1.0;
    out_data.b = encode2x16(lightmap_coordinate);
    out_data.a = 1.0;

    #ifdef MC_GL_RENDERER_RADEON
        gl_FragData[0] = out_color;
        gl_FragData[1] = out_data;
    #endif
}