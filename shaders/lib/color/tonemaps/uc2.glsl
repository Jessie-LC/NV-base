vec3 tonemap(in vec3 x) {
    const float A = 0.15; // Default: 0.15
	const float B = 0.50; // Default: 0.50
	const float C = 0.10; // Default: 0.10
	const float D = 0.20; // Default: 0.20
	const float E = 0.02; // Default: 0.02
	const float F = 0.30; // Default: 0.30
	const float W = 11.2; // Default: 11.2
	const float exposure_bias = 2.0; // Default: 2.0

	const float white_scale = 1.0 / ((W*(A*W+C*B)+D*E)/(W*(A*W+B)+D*F))-E/F;

	x *= exposure_bias;
	x = ((x*(A*x+C*B)+D*E)/(x*(A*x+B)+D*F))-E/F;
	x *= white_scale;

    return x;
}