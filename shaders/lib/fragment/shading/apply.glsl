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

vec3 apply_shading(in vec3 col, in bool do_particles) {
    vec3 shading = vec3(0.0);

    #ifdef SlowBlackbody
        float intensity = rcp(9.5e9);
    #else
        float intensity = 5.0;
    #endif
    vec3 torch = blackbody(BlocklightTemperature) * intensity;

    vec3 normal = decode_normal3x16(texture(colortex2, texture_coordinate).r);

    vec3 skylight = vec3(0.0);
    //if(texture_coordinate.x > 0.5) {
        skylight = max(ValueFromSphericalHarmonicCoefficientsAlt(shcoeffs, normal), 0.0);
    /* } else {
        for(int i = 0; i < 128; ++i) {
            vec3 dir = mat3(gbufferModelViewInverse) * fNormalize(gen_unit_vector(hash2(pd.view_position + i)));
            skylight += max(texture(colortex3, project_sky(dir)).rgb * dot(normal, dir), 0.0);
        }
        skylight /= 128;
    } */

    if(do_particles && texture(colortex0, texture_coordinate).a < 0.5) skylight = texture(colortex3, project_sky(fNormalize(up_vector))).rgb;

    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).x, 3.5) * torch + shading;
    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).y, 4.0) * (skylight * pi) + shading;
    shading = vec3(0.0001) + shading;

    return col * shading;
}