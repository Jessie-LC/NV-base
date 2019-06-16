vec3 tonemap(in vec3 x) {
    #if ReinhardMode == 0
        return x * rcp(1.0 + x);
    #elif ReinhardMode == 1
        return x * rcp(1.0 + (dot(x, vec3(1.0)) / 3.0));
    #endif
}