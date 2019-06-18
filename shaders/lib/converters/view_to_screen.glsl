vec3 viewspace_to_screenspace(vec3 view_position, mat4 projection) {
	vec3 screen_position  = vec3(projection[0].x, projection[1].y, projection[2].z) * view_position + projection[3].xyz;
	     screen_position /= -view_position.z;

	return screen_position * 0.5 + 0.5;
}

float viewspace_to_screenspace(float depth, mat4 projection) {
	return ((projection[2].z * depth + projection[3].z) / -depth) * 0.5 + 0.5;
}