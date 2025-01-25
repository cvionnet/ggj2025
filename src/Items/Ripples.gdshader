shader_type canvas_item;

uniform float ripple_radius : hint_range(0.0, 1.0) = 0.5;
uniform float ripple_amplitude : hint_range(0.0, 0.1) = 0.02;
uniform float ripple_speed : hint_range(0.0, 5.0) = 1.0;

void fragment() {
    vec2 uv = UV - vec2(0.5); // Center the effect
    float dist = length(uv);
    
    // Ripple effect
    float ripple = sin((dist - TIME * ripple_speed) * 10.0) * ripple_amplitude;

    // Mask ripple outside radius
    float mask = smoothstep(ripple_radius, ripple_radius - 0.05, dist);
    
    COLOR = texture(TEXTURE, UV + ripple * normalize(uv)) * mask;
}
