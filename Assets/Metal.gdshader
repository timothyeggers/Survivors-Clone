shader_type canvas_item;


uniform vec4 color : source_color;
uniform float sheen = 2;
uniform float roughness = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	COLOR = texture(TEXTURE, UV);
	float metal = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.rgb = vec3(metal);
	
	// apply shine
	if (distance(UV.x, COLOR.x) < 0.1) {
		COLOR.rgb = vec3(mix(COLOR.rgb, vec3(1.0), 0.5));
	}
}
