vec2 project_sky(vec3 dir) {
	vec2 lonlat = vec2(atan(-dir.x, -dir.z), acos(dir.y));
	vec2 coord = vec2(lonlat.x / tau + 0.5, lonlat.y / pi);
	return coord * (exp2(-SKY_RENDER_LOD) - view_pixel_size) + view_pixel_size * 0.5;
}

vec3 unproject_sky(vec2 coord) {
	coord = (coord - view_pixel_size * 0.5) / (exp2(-SKY_RENDER_LOD) - view_pixel_size);
	coord *= vec2(tau, pi);
	return vec3(sincos(coord.x) * sin(coord.y), cos(coord.y)).xzy;
}