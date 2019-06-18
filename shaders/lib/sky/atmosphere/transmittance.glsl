vec3 calculate_atmosphere_density(in float h) {
    float r = 0.0;
    float m = 0.0;
    r = exp(-h * rcp(scale_heights.x) + scaled_planet_radius.x);
    m = exp(-h * rcp(scale_heights.y) + scaled_planet_radius.y);

    float o = exp(-max(0.0, (35000.0 - h) - atmosphere_radius) * rcp( 5000.0))
	            * exp(-max(0.0, (h - 35000.0) - atmosphere_radius) * rcp(15000.0));

    return vec3(r, m, o);
}

vec3 atmosphere_transmittance(in vec3 ray_vector, in vec3 position, in mat3x3 coeffs) {
	float ray_length = dot(position, ray_vector);
	      ray_length = sqrt(ray_length * ray_length + atmosphere_radius_squared - dot(position, position)) - ray_length;
	float step_size  = ray_length * rcp(transmittance_steps);
	vec3  increment = ray_vector * step_size;
	position += increment * 0.5;

    vec3 thickness = vec3(0.0);

    for(int j = 0; j < transmittance_steps; ++j, position += increment) thickness += calculate_atmosphere_density(length(position));

    vec3 transmittance = coeffs * (step_size * thickness);

    return max(exp(-transmittance), 0.0);
}