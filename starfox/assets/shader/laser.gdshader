shader_type spatial;

uniform vec4 laser_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment(){
    vec3 final_color = vec3(laser_color.x , laser_color.y, laser_color.z);
    final_color = clamp(final_color, 0.0, 1.0);
    ALBEDO = final_color;
}