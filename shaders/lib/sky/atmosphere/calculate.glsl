#include "constants.glsl"
#include "transmittance.glsl"
#include "phase.glsl"

vec3 sph_normal( in vec3 pos, in vec3 sph) {
    return fNormalize(pos-sph.xyz);
}

vec3 atmos(in vec3 view_vector, in vec3 multi, in mat2x3 coeffs, in mat3x3 atcoeffs) {
    //View position
    vec3 view_pos = vec3(0, planet_radius + eyeAltitude, 0) + view_vector * length(view_vector);

    //Raysphere intersection to figure out how far to march.    
    vec2 ad = raysphere_intersection(view_pos, view_vector, atmosphere_radius);
    vec2 pd = raysphere_intersection(view_pos, view_vector, atmosphere_lower_limit);

	bool planet_intersected = pd.y >= 0.0;
   	bool atmosphere_intersected = ad.y >= 0.0;

    vec2 sd = vec2((planet_intersected && pd.x < 0.0) ? pd.y : max(ad.x, 0.0), (planet_intersected && pd.x > 0.0) ? pd.x : ad.y);

    //Calculate the increment, position and step size
    float step_size = length(sd.y - sd.x) * rcp(scattering_steps);

    vec3 increment = view_vector * step_size;
    vec3 position = view_vector * sd.x + (increment * 0.3 + view_pos);

    //Needed for the loop
    vec3 transmittance = vec3(1.0);
    vec3 scattered_sun = vec3(0.0);
    vec3 scattered_moon = vec3(0.0);

    //Mie, isotropic and Rayleigh Phase.
    vec4 phase = vec4(phase_function(dot(view_vector, sun_vector)), phase_function(dot(view_vector, moon_vector)));
    float phase_iso = 0.25 / pi;

    //Loop
    for(int i = 0; i < scattering_steps; ++i, position += increment) {
        float height = length(position);

        vec3 airmass = calculate_atmosphere_density(height);
        if(airmass.y > 1e35) break;
        vec3 optical_depth = step_size * airmass;
        vec3 optical_depth_step = atcoeffs * optical_depth;

        vec3 transmittance_step = clamp(exp(-optical_depth_step), 0.0, 1.0);
        vec3 step_transmitted_fraction = clamp((transmittance_step - 1.0) / -optical_depth_step, 0.0, 1.0);
        vec3 visible_scattering = transmittance * step_transmitted_fraction;

        vec3 scattering_view_step_sun = coeffs * vec2(optical_depth.xy * phase.xy);
        scattering_view_step_sun *= visible_scattering;
        vec3 scattering_view_step_moon = coeffs * vec2(optical_depth.xy * phase.zw);
        scattering_view_step_moon *= visible_scattering;

        scattered_sun += scattering_view_step_sun * atmosphere_transmittance(sun_vector, position, atcoeffs); 
        scattered_moon += scattering_view_step_moon * atmosphere_transmittance(moon_vector, position, atcoeffs);      

        transmittance *= transmittance_step;
    }
    vec3 scattered = (scattered_sun * sun_color) + (scattered_moon * moon_color);

    vec3 retscatter = scattered;

    return max(retscatter, 0.0);
}