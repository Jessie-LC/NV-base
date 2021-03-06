float square(in float x) {
    return _square(x);
}

int square(in int x) {
    return _square(x);
}

vec2 square(in vec2 x) {
    return _square(x);
}

vec3 square(in vec3 x) {
    return _square(x);
}

vec4 square(in vec4 x) {
    return _square(x);
}

float saturate(in float x) {
    return _saturate(x);
}

int saturate(in int x) {
    return _saturate(x);
}

vec2 saturate(in vec2 x) {
    return _saturate(x);
}

vec3 saturate(in vec3 x) {
    return _saturate(x);
}

vec4 saturate(in vec4 x) {
    return _saturate(x);
}

float cubic_smooth(in float x) {
    float y = 3.0, z = 2.0;
    return _cubic_smooth(x, y, z);
}

int cubic_smooth(in int x) {
    int y = 3, z = 2;
    return _cubic_smooth(x, y, z);
}

vec2 cubic_smooth(in vec2 x) {
    vec2 y = vec2(3.0), z = vec2(2.0);
    return _cubic_smooth(x, y, z);
}

vec3 cubic_smooth(in vec3 x) {
    vec3 y = vec3(3.0), z = vec3(2.0);
    return _cubic_smooth(x, y, z);
}

vec4 cubic_smooth(in vec4 x) {
    vec4 y = vec4(3.0), z = vec4(2.0);
    return _cubic_smooth(x, y, z);
}

float rcp(in float x) {
    return _rcp(x, 1.0);
}

float rcp(in int x) {
    return _rcp(x, 1.0);
}

vec2 rcp(in vec2 x) {
    return _rcp(x, 1.0);
}

vec3 rcp(in vec3 x) {
    return _rcp(x, 1.0);
}

vec4 rcp(in vec4 x) {
    return _rcp(x, 1.0);
}

float log10(in float x) {
    return _log10(x, 10.0);
}

int log10(in int x) {
    return int(_log10(x, 10.0));
}

vec2 log10(in vec2 x) {
    return _log10(x, 10.0);
}

vec3 log10(in vec3 x) {
    return _log10(x, 10.0);
}

vec4 log10(in vec4 x) {
    return _log10(x, 10.0);
}

#define length2(x) dot(x,x)

vec2 raysphere_intersection(vec3 pos, vec3 dir, float radius) {
    float radius_squared = (radius*radius);
    float pos_times_dir = dot(pos, dir);
    float end_distance = pos_times_dir*pos_times_dir + radius_squared - length2(pos);
    end_distance = sqrt(end_distance);
    
    vec2 ret = -pos_times_dir + vec2(-end_distance, end_distance);
    if(end_distance < 0.0) ret = vec2(-1.0);

    return ret;
}

#include "spectral.glsl"

float bayer2  (vec2 c) { c = 0.5 * floor(c); return fract(1.5 * fract(c.y) + c.x); }
float bayer4  (vec2 c) { return 0.25 * bayer2 (0.5 * c) + bayer2(c); }
float bayer8  (vec2 c) { return 0.25 * bayer4 (0.5 * c) + bayer2(c); }
float bayer16 (vec2 c) { return 0.25 * bayer8 (0.5 * c) + bayer2(c); }
float bayer32 (vec2 c) { return 0.25 * bayer16(0.5 * c) + bayer2(c); }
float bayer64 (vec2 c) { return 0.25 * bayer32(0.5 * c) + bayer2(c); }
float bayer128(vec2 c) { return 0.25 * bayer64(0.5 * c) + bayer2(c); }

float linear_bayer2  (float c) { return fract(c * 0.5); }
float linear_bayer4  (float c) { return 0.5 * linear_bayer2 (c * 0.5) + linear_bayer2(c); }
float linear_bayer8  (float c) { return 0.5 * linear_bayer4 (c * 0.5) + linear_bayer2(c); }
float linear_bayer16 (float c) { return 0.5 * linear_bayer8 (c * 0.5) + linear_bayer2(c); }
float linear_bayer32 (float c) { return 0.5 * linear_bayer16(c * 0.5) + linear_bayer2(c); }
float linear_bayer64 (float c) { return 0.5 * linear_bayer32(c * 0.5) + linear_bayer2(c); }
float linear_bayer128(float c) { return 0.5 * linear_bayer64(c * 0.5) + linear_bayer2(c); }

vec2 sincos(float x) { return vec2(sin(x), cos(x)); }

vec2 hash2(vec3 p3) {
	p3 = fract(p3 * vec3(443.897, 441.423, 437.195));
	p3 += dot(p3, p3.yzx + 19.19);
	return fract((p3.xx + p3.yz) * p3.zy);
}

vec3 gen_unit_vector(vec2 hash) {
    hash.x *= tau; hash.y = hash.y * 2.0 - 1.0;
    return vec3(vec2(sin(hash.x), cos(hash.x)) * sqrt(1.0 - hash.y * hash.y), hash.y);
}