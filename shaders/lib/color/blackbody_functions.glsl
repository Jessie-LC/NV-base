#ifdef SlowBlackbody
    float blackbody_radiation_s(in float temperature, in float wavelength)
    {
        float e = exp(1.4387752e+7 / (temperature * wavelength));
        return 3.74177e+29 / (pow(wavelength, 5.0) * (e - 1.0));
    }

    vec3 blackbody_radiation(in float t, in vec3 w)
    {
        return vec3(blackbody_radiation_s(t, w.r), 
            blackbody_radiation_s(t, w.g), 
            blackbody_radiation_s(t, w.b));
    }

    vec3 blackbody(in float t) {
        vec3 w[6] = vec3[](
            vec3(400, 425, 450),
            vec3(475, 500, 525),
            vec3(550, 575, 600),
            vec3(625, 650, 675),
            vec3(700, 725, 750),
            vec3(775, 800, 830)
        );

    /*
        vec3 w[29] = vec3[](
            vec3(390, 395, 400),
            vec3(405, 410, 415), 
            vec3(420, 425, 430),
            vec3(435, 440, 445),
            vec3(450, 455, 460),
            vec3(465, 470, 475),
            vec3(480, 485, 490),
            vec3(495, 500, 505),
            vec3(510, 515, 520),
            vec3(525, 530, 535),
            vec3(540, 545, 550),
            vec3(555, 560, 565),
            vec3(570, 575, 580),
            vec3(585, 590, 595),
            vec3(600, 605, 610),
            vec3(615, 620, 625),
            vec3(630, 635, 640),
            vec3(645, 650, 655),
            vec3(660, 665, 670),
            vec3(675, 680, 685),
            vec3(690, 695, 700),
            vec3(705, 710, 715),
            vec3(720, 725, 730),
            vec3(735, 740, 745),
            vec3(750, 755, 760),
            vec3(765, 770, 775),
            vec3(780, 785, 790),
            vec3(795, 800, 805),
            vec3(810, 815, 820)
        );
    */

        vec3 xyz = vec3(0.0);
        for (int i = 0; i < w.length(); ++i)
        {
            vec3 wl = w[i];
            float r = blackbody_radiation(t, wl).x;
            float g = blackbody_radiation(t, wl).y;
            float b = blackbody_radiation(t, wl).z;
            xyz += r * spectrum_to_xyz(wl.x);
            xyz += g * spectrum_to_xyz(wl.y);
            xyz += b * spectrum_to_xyz(wl.z);
        }

        vec3 rgb = xyz_to_rgb(xyz) / w.length();

        return rgb;
    }
#else
    vec3 blackbody(float t) {
        // http://en.wikipedia.org/wiki/Planckian_locus

        vec4 vx = vec4(-0.2661239e9,-0.2343580e6,0.8776956e3,0.179910);
        vec4 vy = vec4(-1.1063814,-1.34811020,2.18555832,-0.20219683);
        float it = 1./t;
        float it2= it*it;
        float x = dot(vx,vec4(it*it2,it2,it,1.));
        float x2 = x*x;
        float y = dot(vy,vec4(x*x2,x2,x,1.));
        float z = 1. - x - y;
        
        // http://www.brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
        mat3 xyzToSrgb = mat3(
            3.2404542,-1.5371385,-0.4985314,
            -0.9692660, 1.8760108, 0.0415560,
            0.0556434,-0.2040259, 1.0572252
        );

        vec3 srgb = vec3(x/y,1.,z/y) * xyzToSrgb;
        return max(srgb,0.);
    }
#endif