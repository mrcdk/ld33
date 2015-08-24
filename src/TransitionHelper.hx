package;

import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.Sprite;
import luxe.tween.Actuate;
import luxe.Vector;
import phoenix.Texture;

/**
 * ...
 * @author MrCdK
 */
class TransitionHelper extends Component {
	
	var sprite:Sprite;
	var tmp:Sprite;
	
	public function new() {
		super({name:"transition"});
	}
	
	override public function init() {
		sprite = cast entity;
		
		tmp = new Sprite( {
			name: sprite.name+".tmp",
			pos: sprite.pos,
			scale: sprite.scale,
			centered: sprite.centered,
			size: sprite.size,
			origin: sprite.origin,
			scene: sprite.scene,
			texture: sprite.texture,
			depth: sprite.depth - 0.001,
			parent: sprite,
		} );
		
		tmp.visible = false;
	}
	
	public function transition(texture:Texture, time:Float = 1, func:TransitionFunc, ?cb:Void->Void) {
		if (tmp == null) return;
		func(texture, time, sprite, tmp, cb);
	}
	
	static public function fade(texture:Texture, time:Float = 1, sprite:Sprite, tmp:Sprite, ?cb:Void->Void) {
		tmp.color.a = 0;
		tmp.visible = true;
		tmp.texture = texture;
		tmp.color.tween(time, { a:1 } );
		sprite.color.tween(time, { a:0 } ).onComplete(function() {
			sprite.texture = texture;
			sprite.color.a = 1;
			tmp.color.a = 1;
			tmp.visible = false;
			if (cb != null) cb();
		});
	}
	
	static public function deck(texture:Texture, time:Float = 1, sprite:Sprite, tmp:Sprite, ?cb:Void->Void, direction:TransitionDirection) {
		tmp.color.set(0.2, 0.2, 0.2, 1);
		tmp.visible = true;
		tmp.texture = texture;
		tmp.parent = null;
		tmp.color.tween(time, { r:1, g:1, b:1, a:1 } );
		sprite.color.tween(time / 2, { r:0.2, g:0.2, b:0.2 } );
		var v = switch(direction) {
			case TOP: 		PositionHelper.get(sprite, OUT_TOP);
			case BOTTOM: 	PositionHelper.get(sprite, OUT_BOTTOM);
			case LEFT:		PositionHelper.get(sprite, OUT_LEFT);
			case RIGHT:		PositionHelper.get(sprite, OUT_RIGHT);
		}
		var last_pos = sprite.pos.clone();
		Actuate.tween(sprite.pos, time, { x: v.x, y: v.y } ).onComplete(function() {
			sprite.texture = texture;
			sprite.pos = last_pos;
			sprite.color.set(1, 1, 1, 1);
			tmp.color.set(1, 1, 1, 1);
			tmp.visible = false;
			tmp.parent = sprite;
			if (cb != null) cb();
		});
		
	}
	
}

typedef TransitionFunc = Texture->Float->Sprite->Sprite->Null<(Void->Void)>->Void

@:enum abstract TransitionDirection(Int) {
	var TOP = 0;
	var RIGHT = 1;
	var BOTTOM = 2;
	var LEFT = 3;
}