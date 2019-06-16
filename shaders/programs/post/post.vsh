#ifndef MC_GL_RENDERER_RADEON 
    layout(location = 0) in vec4 vert_pos;
    layout(location = 8) in vec2 vert_texcoord;
#endif

#include "/lib/important.glsl"

//Samplers
/* Nothing to see here */

//Uniforms
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;

//Vertex outputs
out vec2 texture_coordinate;

void main() {
    #ifdef MC_GL_RENDERER_RADEON 
        vec4 pos = gl_Vertex;
    #else
        vec4 pos = vert_pos;
    #endif

    gl_Position = vec4(pos.xy * 2.0 - 1.0, 0.0, 1.0);

    #ifdef MC_GL_RENDERER_RADEON
        texture_coordinate = gl_MultiTexCoord0.st;
    #else
        texture_coordinate = vert_texcoord;
    #endif
}