shader_type canvas_item;

uniform vec2 ripple_center_1 = vec2(0.21, 0.185); // First ripple center
uniform vec2 ripple_center_2 = vec2(0.835, 0.885); // Second ripple center
uniform vec2 ripple_center_3 = vec2(0.835, 0.885); // Third ripple center

uniform float ripple_speed : hint_range(0.0, 10.0) = 0.925;
uniform float ripple_frequency : hint_range(0.0, 50.0) = 4.735;
uniform float ripple_amplitude : hint_range(0.0, 1.0) = 0.008;

void fragment() {
    vec2 uv = UV;
    
    // First ripple
    float distance1 = distance(uv, ripple_center_1);
    float ripple1 = sin(distance1 * ripple_frequency - TIME * ripple_speed) * ripple_amplitude;

    // Second ripple
    float distance2 = distance(uv, ripple_center_2);
    float ripple2 = sin(distance2 * ripple_frequency - TIME * ripple_speed) * ripple_amplitude;

    // Third ripple
    float distance3 = distance(uv, ripple_center_3);
    float ripple3 = sin(distance3 * ripple_frequency - TIME * ripple_speed) * ripple_amplitude;

    // Combine the ripples
    float combined_ripple = ripple1 + ripple2 * ripple3;

    // Apply ripple distortion
    vec2 distorted_uv = uv 
        + normalize(uv - ripple_center_1) * ripple1 
        + normalize(uv - ripple_center_2) * ripple2
        + normalize(uv - ripple_center_3) * ripple3;

    COLOR = texture(TEXTURE, distorted_uv);
}
