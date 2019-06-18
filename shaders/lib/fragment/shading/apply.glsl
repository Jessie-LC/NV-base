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

vec3 apply_shading(in vec3 col) {
    vec3 shading = vec3(0.0);

    #ifdef SlowBlackbody
        float intensity = rcp(9.5e9);
    #else
        float intensity = 5.0;
    #endif
    vec3 torch = blackbody(BlocklightTemperature) * intensity;

    vec3 normal = decode_normal3x16(texture(colortex2, texture_coordinate).r);

    vec3 skylight = max(ValueFromSphericalHarmonicCoefficientsAlt(shcoeffs, normal), 0.0);

    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).x, 3.5) * torch + shading;
    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).y, 4.0) * (skylight * pi) + shading;
    shading = vec3(0.0001) + shading;

    return col * shading;
}