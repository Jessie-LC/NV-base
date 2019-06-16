#define transMAD(mat, v) (mat3x3(mat) * (v) + (mat)[3].xyz)

#define diagonal2(mat) vec2((mat)[0].x, (mat)[1].y)
#define diagonal3(mat) vec3(diagonal2(mat), (mat)[2].z)
#define diagonal4(mat) vec4(diagonal3(mat), (mat)[2].w)

#define projMAD3(mat, v) (diagonal3(mat) * (v) + (mat)[3].xyz)