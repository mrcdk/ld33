package text;

import haxe.PosInfos;
import luxe.Color;
import luxe.Matrix;
import luxe.options.TextOptions;
import luxe.Text;
import luxe.Transform;
import luxe.tween.Actuate;
import luxe.tween.actuators.GenericActuator.IGenericActuator;
import luxe.tween.easing.Bounce;
import luxe.Vector;
import phoenix.geometry.TextGeometry.EvTextGeometry;
import phoenix.Matrix.MatrixTransform;

typedef CharFormat = {
	?color:Color,
	?wait:Float,
	?charDelay:Float,
	?alphaFadeIn:Float,
	?alphaFadeOut:Float,
}

@:enum abstract TextState(Int) {
	var NONE 		= 0;
	var RUNNING 	= 1;
	var SKIPPED 	= 2;
	var COMPLETED 	= 3;
}


class TextExt extends Text {

	public var state:TextState = NONE;
	public var callback:Void->Void = null;
	public var has_more_text(get, never):Bool;
		inline function get_has_more_text() return pages.length > current_page;
	
	var colors:Array<Color> = [];
	
	public var characters_per_second:Float = 2/60;
	public var fade_in:Float = 0.25;
	var lines = 5;
	var pages:Array<String> = [];
	var current_page:Int = 0;
	public function new(_options:TextOptions #if debug,  ?_pos_info:haxe.PosInfos #end) {
		
		_options.shader = Luxe.resources.shader("custom_bitmapfont");
		
		super(_options #if debug, _pos_info#end);
		
		this.geom.emitter.on(EvTextGeometry.update_text, update_vertices);
	}
	
	public function skip(?target:Float) {
		target = target == null ? color.a : target;
		for (c in colors) {
			Actuate.stop(c, ["a"]);
			c.a = target;
		}
		state = SKIPPED;
	}
	
	public function pause() {
		for (c in colors) {
			Actuate.pause(c);
		}
	}
	
	public function resume() {
		for (c in colors) {
			Actuate.resume(c);
		}
	}
	
	public inline function nextPage() {
		this.text = pages[current_page++];
	}
	
	public function paginateText(text:String) {
		this.text = text;
		
		if (bounds_wrap) {
			var lines = geom.lines;
			var max_lines = Math.floor(bounds.h / font.height_of(lines[0], geom.point_size, geom.line_spacing));
			var new_text = new StringBuf();
			
			current_page = 0;
			for (i in 0...lines.length) {
				new_text.add(lines[i]);
				new_text.add("\n");
				
				if ((i + 1) % max_lines == 0) {
					pages[current_page++] = new_text.toString();
					new_text = new StringBuf();
				}
			}
			
			if (new_text.length > 0) {
				pages[current_page++] = new_text.toString();
			}
			
			current_page = 0;
			nextPage();
		}
	}
	
	function update_vertices(_) {
		
		geom.tidy();
		
		skip(0);
		
		state = RUNNING;
		var cache = @:privateAccess geom.cache;
		var tween;
		var vecColor:Color;
		var delay:Float = 0;
		for (i in 0...cache.length) {
			
			vecColor = color.clone();
			vecColor.a = 0;
			tween = vecColor.tween(fade_in, { a: color.a }, true).delay(delay);
			
			if (i == cache.length - 1) {
				tween.onComplete(function() { 
					state = COMPLETED; 
				});
			}
			
			
			colors.push(vecColor);
			
			delay += characters_per_second;
			
			for (v in cache[i]) {
				v.color = vecColor;
			}
		}
	}
	
}