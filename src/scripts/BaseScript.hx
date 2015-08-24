package scripts;
import luxe.Color;
import luxe.Sprite;
import luxe.Text.TextAlign;
import luxe.tween.Actuate;
import luxe.tween.actuators.GenericActuator.IGenericActuator;
import mint.Control.MouseSignal;

/**
 * ...
 * @author MrCdK
 */
class BaseScript
{

	var game:GameState;
	
	public function new(game:GameState) {
		this.game = game;
		
		start();
	}
	
	public function start() {
		
	}
	
	#if release inline #end
	public function m(?c:Character, m:String, ?align:TextAlign = TextAlign.left, ?align_vertical:TextAlign = TextAlign.top, ?cps:Float = 2/60, ?fade_in:Float = 0.25, ?color:Color) {
		game.sequence.push(MSG, { 
			character:c, 
			msg: m, 
			opt: {
				cps: cps,
				fade_in: fade_in,
				align: align,
				align_vertical: align_vertical,
				color: color,
			}
		});
	}
	
	#if release inline #end
	public function f(?autoAdvance:Bool = false, f:Void->Void) {
		game.sequence.push(FUNC, { func: function() { f(); if (autoAdvance) nextEvent(); } } );
	}
	
	#if release inline #end
	public function cm(s:Sprite, t:Float, from:Array<Float>, to:Array<Float>, ?revert:Bool = false, ?wait:Bool = false) {
		f(function() {
			var t = game.color_matrix.applyTween(s, t, from, to);
			t.onComplete(function() {
				if(revert) s.shader = null;
				if(wait) nextEvent();
			});
			
			if(!wait) nextEvent();
		});
	}
	
	#if release inline #end
	public function show(c:Character, state:String, ?wait:Bool = false, ?func:Void->IGenericActuator) {
		f(function() {
			var texture = c.textures.get(state);
			if (texture == null) {
				throw "No texture for state " + state;
			} else {
				game.sprite.texture = texture;
			}
			var t = game.sprite.color.tween(1, { a:1 } );
			if (wait) {
				t.onComplete(function() nextEvent());
			} else {
				nextEvent();
			}
		});
	}
	#if release inline #end
	public function hide(c:Character, ?wait:Bool = false, ?func:Void->IGenericActuator) {
		f(function() {
			var t = game.sprite.color.tween(1, { a:0.4 } ).onComplete(function() game.sprite.color.a = 0);
			Actuate.tween(game.sprite.pos, 1, { x: Luxe.camera.size.x + game.sprite.origin.x } );
			if (wait) {
				t.onComplete(function() nextEvent());
			} else {
				nextEvent();
			}
		});
	}
	
	#if release inline #end
	public function choices(?time:Float = 1, choices:Array<{text:String, func:Void->Void } >) {
		f(function() {
			game.showChoices(time, choices);
		});
	}
	
	#if release inline #end
	public function shake(t:Float) {
		f(true, function() Luxe.camera.shake(t));
	}
	
	inline function nextEvent() {
		game.nextEvent();
	}
}