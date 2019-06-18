vec3 screenspace_to_viewspace(vec3 screen_position, mat4 projection_inverse) {
	screen_position = screen_position * 2.0 - 1.0;

	vec3 view_position  = vec3(vec2(projection_inverse[0].x, projection_inverse[1].y) * screen_position.xy + projection_inverse[3].xy, projection_inverse[3].z);
	     view_position /= projection_inverse[2].w * screen_position.z + projection_inverse[3].w;

	return view_position;
}

float screenspace_to_viewspace(float depth, mat4 projection_inverse) {
	depth = depth * 2.0 - 1.0;
	return projection_inverse[3].z / (projection_inverse[2].w * depth + projection_inverse[3].w);
}