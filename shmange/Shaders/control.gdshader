shader_type canvas_item;

uniform bool wet;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if (wet == true) {
		COLOR = vec4(color.g / 3.0,color.g / 2.0,color.b,1.0);
	} else {
		COLOR = color;
	}
}
