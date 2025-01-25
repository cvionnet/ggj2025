shader_type canvas_item;

uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = ( SCREEN_UV - vec2(0.5, 0.0) ) / vec2(ratio, 1.0) + vec2(0.5, 0.0); 
	float mask = (1.0 - smoothstep(size - 0.1, size, length(scaledUV - center))) *
		smoothstep(size - thickness - 0.1, size - thickness, length(scaledUV - center));
	
	vec2 disp = normalize(scaledUV - center) * force * mask;
	
	//COLOR = vec4(SCREEN_UV - disp, 0.0, 1.0);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
	//COLOR.rgb = vec3(mask);
}

//uniform vec2 center = vec2(0.5, 0.5);
//uniform float time = 0.0;
//uniform float speed = 1.0;
//uniform float wavelength = 0.05;
//uniform float amplitude = 0.02;
//uniform float edge_width = 0.02;
//
//void fragment() {
    //// Normalize UV coordinates
    //vec2 uv = UV;
//
    //// Calculate the distance from the center
    //float dist = distance(uv, center);
//
    //// Calculate the wave effect
    //float wave = sin((dist - speed * time) / wavelength) * amplitude;
//
    //// Create the shockwave radius
    //float radius = speed * time;
//
    //// Create an edge for the shockwave
    //float edge = smoothstep(radius - edge_width, radius + edge_width, dist);
//
    //// Apply the wave distortion to UV coordinates
    //uv += normalize(uv - center) * wave * (1.0 - edge);
//
    //// Sample the texture with modified UVs
    //vec4 tex_color = texture(TEXTURE, uv);
//
    //// Optionally, modulate the alpha based on the edge
    //tex_color.a *= edge;
//
    //COLOR = tex_color;
//}
