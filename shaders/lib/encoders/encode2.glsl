float encode2x16(vec2 a){
    ivec2 bf = ivec2(a*255.);
    return float( bf.x|(bf.y<<8) ) / 65535.;
}

vec2 decode2x16(float a){
    int bf = int(a*65535.);
    return vec2(mod(bf, 256), bf>>8) / 255.;
}