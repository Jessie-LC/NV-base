vec3 tonemap(vec3 x) {
    float a = 0.6;
    float b = 1.0;
    float c = dot(vec3(0.299, 0.587, 0.114), x);
    c = c*0.15;
	vec3 div = 1.0 + c + exp(b * rcp(a)) * x;
    div *= rcp(5);
	return x * rcp(1.0 + div);
}