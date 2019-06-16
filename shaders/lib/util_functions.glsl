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
    const float y = 1.0;
    return _rcp(x, 1.0);
}

int rcp(in int x) {
    return _rcp(x, 1);
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