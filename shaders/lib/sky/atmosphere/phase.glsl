float rayleigh_phase(float cos_theta) {
    /*
  	float phase = 0.75 * (1.0 + square(cos_theta));
  	*/
    float phase = 0.8 * (1.4 + 0.5 * cos_theta);
    phase *= rcp(pi4);
  	return phase;
}

float cornette_shanks_mie_phase(float cos_theta, float g) {
  	float gg = g*g;
  	float p1 = 3.0 * (1.0 - gg) * rcp((pi * (2.0 + gg)));
  	float p2 = (1.0 + square(cos_theta)) * rcp(pow((1.0 + gg - 2.0 * g * cos_theta), 3.0/2.0));
  	float phase = p1 * p2;
  	phase *= rcp(pi4);
  	return max(phase, 0.0);
}

vec2 phase_function(float cos_theta) 
{ 
    return vec2(rayleigh_phase(cos_theta), cornette_shanks_mie_phase(cos_theta, atmosphere_mieg));
}