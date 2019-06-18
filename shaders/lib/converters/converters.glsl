#include "screen_to_view.glsl"
#include "view_to_screen.glsl"
#include "view_to_scene.glsl"
#include "scene_to_view.glsl"
#include "scene_to_shadowview.glsl"
#include "shadowview_to_shadowclip.glsl"

float linearize_depth(float depth, in mat4 projection_inv) {
	return -1.0 / ((depth * 2.0 - 1.0) * projection_inv[2].w + projection_inv[3].w);
}