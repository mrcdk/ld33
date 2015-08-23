#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D tex0;

varying vec2 tcoord;
varying vec4 color;

uniform mat4 multipliers;
uniform vec4 offsets;

void main() {

	vec4 tcol = texture2D(tex0, tcoord);
	//tcol = vec4(tcol.rgb / tcol.a, tcol.a);
	tcol = offsets + tcol * multipliers;
	//tcol = vec4(tcol.rgb * tcol.a, tcol.a);
	gl_FragColor = tcol * color;

}