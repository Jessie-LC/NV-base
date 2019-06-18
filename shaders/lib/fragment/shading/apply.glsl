vec3 apply_shading(in vec3 col) {
    vec3 shading = vec3(0.0);

    #ifdef SlowBlackbody
        float intensity = rcp(9.5e9);
    #else
        float intensity = 5.0;
    #endif
    vec3 torch = blackbody(BlocklightTemperature) * intensity;

    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).x, 3.5) * torch + shading;
    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).y, 4.0) * texture(colortex3, project_sky(up_vector)).rgb + shading;
    shading = vec3(0.01) + shading;

    return col * shading;
}