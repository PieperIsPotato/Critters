shader_type spatial;

uniform float[4096] noise;

void vertex() {
	int ix = int(UV.x * 64.0);
	int iz = int(UV.y * 64.0);

	ix = clamp(ix, 0, 63);
	iz = clamp(iz, 0, 63);

	VERTEX.y = noise[ix + iz * 64];
}

void fragment() {

}