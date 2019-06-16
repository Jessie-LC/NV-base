#ifndef MC_GL_RENDERER_RADEON 
    layout(location = 0) in vec4 vert_pos;
    layout(location = 3) in vec3 vert_color;
    layout(location = 8) in vec2 vert_texcoord;
    layout(location = 9) in vec2 vert_lmcoord;
#endif

#include "/lib/important.glsl"

//Samplers
/* Nothing to see here */

//Uniforms
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;

//Vertex outputs
out vec3 tint;
out vec2 texture_coordinate;

void main() {
    #ifdef MC_GL_RENDERER_RADEON 
        vec4 pos = gl_Vertex;
    #else
        vec4 pos = vert_pos;
    #endif

    gl_Position = gl_ModelViewMatrix * pos;
	gl_Position = gl_ProjectionMatrix * gl_Position;

    #ifdef MC_GL_RENDERER_RADEON
        tint = gl_Color.rgb;

        texture_coordinate = gl_MultiTexCoord0.st;
    #else
        tint = vert_color;

        texture_coordinate = vert_texcoord;
    #endif
}