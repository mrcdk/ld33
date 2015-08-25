package ;

import luxe.Matrix;
import luxe.Sprite;
import luxe.tween.Actuate;
import luxe.utils.Maths;
import luxe.Vector;
import phoenix.Shader;

/**
 * ...
 * @author MrCdK
 */
class ColorMatrix
{

	// from here https://github.com/phoboslab/WebGLImageFilter/blob/master/webgl-image-filter.js
	
	public static var normal(get, never):Array<Float>;
		static inline function get_normal():Array<Float> {
			return [
				1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, 1, 0,
			];
		}
	
	public static var sepia(get, never):Array<Float>;
		static inline function get_sepia():Array<Float> {
			return [
				0.393, 0.7689999, 0.18899999, 0, 0,
				0.349, 0.6859999, 0.16799999, 0, 0,
				0.272, 0.5339999, 0.13099999, 0, 0,
				0,0,0,1,0
			];
		}
		
	public static var desaturateLuminance(get, never):Array<Float>;
		static inline function get_desaturateLuminance():Array<Float> {
			return [
				0.2764723, 0.9297080, 0.0938197, 0, -37.1,
				0.2764723, 0.9297080, 0.0938197, 0, -37.1,
				0.2764723, 0.9297080, 0.0938197, 0, -37.1,
				0, 0, 0, 1, 0
			];
		}
	public static var brownie(get, never):Array<Float>;
		static inline function get_brownie():Array<Float> {
			return [
				0.5997023498159715,0.34553243048391263,-0.2708298674538042,0,47.43192855600873,
				-0.037703249837783157,0.8609577587992641,0.15059552388459913,0,-36.96841498319127,
				0.24113635128153335,-0.07441037908422492,0.44972182064877153,0,-7.562075277591283,
				0,0,0,1,0
			];
		}
		
	public static var desaturate(get, never):Array<Float>;
		static inline function get_desaturate():Array<Float> {
			return saturation(-1);
		}
	public static var negative(get, never):Array<Float>;
		static inline function get_negative():Array<Float> {
			return [
				-1, 0, 0, 0, 255,
				0, -1, 0, 0, 255,
				0, 0, -1, 0, 255,
				0, 0, 0, 1, 0
			];
		}
		
	static public function brightness(amount:Float) {
		var b = amount + 1;
		return [
			b, 0, 0, 0, 0,
			0, b, 0, 0, 0,
			0, 0, b, 0, 0,
			0, 0, 0, 1, 0
		];
	}
	static public function saturation(amount:Float) {
		var x = amount * 2 / 3 + 1;
		var y = ((x - 1) * -0.5);
		return [
			x, y, y, 0, 0,
			y, x, y, 0, 0,
			y, y, x, 0, 0,
			0, 0, 0, 1, 0
		];
	}
	static public function contrast(amount:Float) {
		var v = amount + 1;
		var o = -128 * (v - 1);
		return [
			v, 0, 0, 0, o,
			0, v, 0, 0, o,
			0, 0, v, 0, o,
			0, 0, 0, 1, 0
		];
	}
		
	
	public var shader:Shader;
	var multipliers:Matrix;
	var offsets:Vector;
	
	public function new() {
		this.shader = Luxe.resources.shader("colormatrix");
		
		multipliers = new Matrix();
		offsets = new Vector();
		
		apply(ColorMatrix.normal);
	}
	
	public function applyTween(sprite:Sprite, time:Float, from:Array<Float>, to:Array<Float>) {
		apply(from);
		sprite.shader = shader;
		var t = { t:0. };
		var tween = Actuate.update(tweenFunc, time, [from, to, 0], [from, to, 1]);
		
		return tween;
	}
	
	public inline function apply(m:Array<Float>) {
		multipliers.set(
			m[ 0], m[ 1], m[ 2], m[ 3],
			m[ 5], m[ 6], m[ 7], m[ 8],
			m[10], m[11], m[12], m[13],
			m[15], m[16], m[17], m[18]
		);
		
		offsets.set(
			m[4] / 255., m[9] / 255., m[14] / 255., m[19] / 255.
		);
		
		shader.set_matrix4("multipliers", multipliers.transpose());
		shader.set_vector4("offsets", offsets);
	}
	
	function tweenFunc(from:Array<Float>, to:Array<Float>, t:Float) {
		var m = [for(i in 0...from.length) Maths.lerp(from[i], to[i], t)];
		apply(m);
	}
	
	
	
}