const float air_number_density       = 2.5035422e25; // m^3
const float ozone_number_density     = 2.0e14;
const vec3  ozone_cross_section      = vec3(4.51103766177301E-21, 3.2854797958699E-21, 1.96774621921165E-22);

const float planet_radius = 6371e3;
const float planet_radius_squared = planet_radius*planet_radius;

const float atmosphere_height = 110e3;

const vec2  scale_heights     = vec2(8.0e3, 1.2e3);

const float atmosphere_mieg = 0.8;
const vec3 lambda = vec3(680.0, 550.0, 440.0) * 1e-9; //The wavelengths of visible light in nanometers.
const float n = 1.00029; //The IOR of air.
const float pwr = 4.0;
const float ar = 8.8437304e-32;
const vec3 coefficient_rayleigh = 4.0 * pi / pow(lambda, vec3(pwr)) * ar; //Had to be changed in order to work.
//Don't worry, we're here for you, we will get you through this hard time of saying fun fact.
const vec3 coefficient_ozone = ozone_cross_section * ozone_number_density;
const vec3 coefficient_mie = vec3(3.6e-6);

const vec2  inverse_scale_heights     = 1.0 / scale_heights;
const vec2  scaled_planet_radius      = planet_radius * inverse_scale_heights;
const float atmosphere_radius        = planet_radius + atmosphere_height;
const float atmosphere_radius_squared = atmosphere_radius * atmosphere_radius;
const float atmosphere_lower_limit = planet_radius + -3e3;
const float atmosphere_lower_limit_squared = atmosphere_lower_limit * atmosphere_lower_limit;

mat2x3 coefficients_scattering  = mat2x3(coefficient_rayleigh, coefficient_mie);
mat3x3 coefficients_extinction = mat3x3(coefficient_rayleigh, coefficient_mie * 1.11, coefficient_ozone);

const int scattering_steps = 32;
const int transmittance_steps = 6;

uniform float eyeAltitude;