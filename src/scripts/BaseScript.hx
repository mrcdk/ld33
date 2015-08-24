package scripts;
import luxe.Color;
import luxe.Sprite;
import luxe.Text.TextAlign;
import luxe.tween.Actuate;
import luxe.tween.actuators.GenericActuator.IGenericActuator;
import luxe.Vector;
import mint.Control.MouseSignal;
import phoenix.Texture;
import TransitionHelper.TransitionFunc;

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
			},
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
	public function transition(sprite:Sprite, texture:Texture, time:Float = 1, func:TransitionFunc, ?wait:Bool = false) {
		f(function() {
			var ts:TransitionHelper = sprite.get("transition");
			ts.transition(texture, time, func, wait ? nextEvent : null);
			if (!wait) nextEvent();
		});
	}
	
	#if release inline #end
	public function show(c:Character, state:String) {
		f(function() {
			var texture = c.textures.get(state);
			if (texture == null) {
				throw "No texture for state " + state;
			} else {
				game.sprite.texture = texture;
			}
			
			nextEvent();
		});
	}
	
	#if release inline #end
	public function tween(?wait:Bool = false, ?func:Void->IGenericActuator) {
		f(function() {			
			var tween = null;
			if (func == null) {
				wait = false;
			} else {
				tween = func();
			}
			
			if (wait) {
				tween.onComplete(nextEvent);
			} else {
				nextEvent();
			}
		});
	}
	#if release inline #end
	public function tween_fade(sprite:Sprite, time:Float, to:Float) {
		return sprite.color.tween(time, { a:to } );
	}
	#if release inline #end
	public function tween_move(sprite:Sprite, time:Float, to:Vector) {
		return Actuate.tween(sprite.pos, time, { x: to.x, y: to.y } );
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