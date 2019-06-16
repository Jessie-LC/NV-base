#if Tonemap == 0
    #include "tonemaps/aces.glsl"
#elif Tonemap == 1
    #include "tonemaps/burgess.glsl"
#elif Tonemap == 2
    #include "tonemaps/lee.glsl"
#elif Tonemap == 3
    #include "tonemaps/reinhard.glsl"
#elif Tonemap == 4
    #include "tonemaps/uc2.glsl"
#endif