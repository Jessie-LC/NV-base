#ifndef MC_GL_RENDERER_RADEON 
    layout(location = 0) in vec4 vert_pos;
    layout(location = 8) in vec2 vert_texcoord;
#endif

#include "/lib/important.glsl"

//Samplers
uniform sampler2D colortex3;

//Uniforms
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;

uniform vec2 view_pixel_size;

//Vertex outputs
flat out vec4[3] shcoeffs;
out vec2 texture_coordinate;

#include "/lib/sky/atmos_projection.glsl"

vec4 CalculateSphericalHarmonics(vec3 xyz) {
    const vec2 freqW = vec2(sqrt(1.0 / (4.0 * pi)), sqrt(3.0 / (4.0 * pi)));
    return vec4(freqW.x, freqW.y * xyz.yzx);
}

vec3[4] CalculateSphericalHarmonicCoefficients(vec3 value, vec3 xyz) {
    vec4 harmonics = CalculateSphericalHarmonics(xyz);
    return vec3[4](value * harmonics.x, value * harmonics.y, value * harmonics.z, value * harmonics.w);
}
vec3 ValueFromSphericalHarmonicCoefficients(vec3[4] coefficients, vec3 xyz) {
    vec4 harmonics = CalculateSphericalHarmonics(xyz);
    return coefficients[0] * harmonics.x + coefficients[1] * harmonics.y + coefficients[2] * harmonics.z + coefficients[3] * harmonics.w;
}

vec4[3] CalculateSphericalHarmonicCoefficientsAlt(vec3 value, vec3 xyz) {
    vec4 harmonics = CalculateSphericalHarmonics(xyz);
    return vec4[3](value.r * harmonics, value.g * harmonics, value.b * harmonics);
}
vec3 ValueFromSphericalHarmonicCoefficientsAlt(vec4[3] coefficients, vec3 xyz) {
    vec4 harmonics = CalculateSphericalHarmonics(xyz);
    return vec3(dot(coefficients[0], harmonics), dot(coefficients[1], harmonics), dot(coefficients[2], harmonics));
}

vec3 gen_unit_vector(vec2 hash) {
    hash.x *= tau; hash.y = hash.y * 2.0 - 1.0;
    return vec3(vec2(sin(hash.x), cos(hash.x)) * sqrt(1.0 - hash.y * hash.y), hash.y);
}

void main() {
    #ifdef MC_GL_RENDERER_RADEON 
        vec4 pos = gl_Vertex;
    #else
        vec4 pos = vert_pos;
    #endif

    gl_Position = vec4(pos.xy * 2.0 - 1.0, 0.0, 1.0);

    const int samples = SH_Directions;

    shcoeffs[0] = vec4(0.0);
    shcoeffs[1] = vec4(0.0);
    shcoeffs[2] = vec4(0.0);
    for(int i = 0; i < samples; ++i) {
        vec3 dir = gen_unit_vector(vec2((i + 0.5) / samples, fract(i * phi)));
        vec4[3] s= CalculateSphericalHarmonicCoefficientsAlt(texture(colortex3, project_sky(fNormalize(dir))).rgb, fNormalize(dir));

        shcoeffs[0] += s[0]; shcoeffs[1] += s[1]; shcoeffs[2] += s[2];
    }
    shcoeffs[0] /= (samples / 2);
    shcoeffs[1] /= (samples / 2);
    shcoeffs[2] /= (samples / 2);

    #ifdef MC_GL_RENDERER_RADEON
        texture_coordinate = gl_MultiTexCoord0.st;
    #else
        texture_coordinate = vert_texcoord;
    #endif
}