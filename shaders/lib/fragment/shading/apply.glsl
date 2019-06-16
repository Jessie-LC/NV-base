vec3 apply_shading(in vec3 col) {
    vec3 shading;


    //8e11
    #ifdef SlowBlackbody
        float intensity = rcp(9.5e9);
    #else
        float intensity = 5.0;
    #endif
    vec3 torch = blackbody(2200.0) * intensity;

    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).x, 3.5) * torch + shading;
    shading = pow(decode2x16(texture(colortex2, texture_coordinate).b).y, 4.0) * (vec3(0.4, 0.7, 1.0) * 1.5) + shading;
    shading = vec3(0.01) + shading;

    return col * shading;
}