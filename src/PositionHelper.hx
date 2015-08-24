package;
import luxe.Sprite;
import luxe.Vector;
import luxe.Visual;

@:enum abstract HorizontalPosition(Int) {
	var LEFT = 0;
	var CENTER = 1;
	var RIGHT = 2;
	var OUT_LEFT = 3;
	var OUT_RIGHT = 4;
}

@:enum abstract VerticalPosition(Int) {
	var TOP = 0;
	var MIDDLE = 1;
	var BOTTOM = 2;
	var OUT_TOP = 3;
	var OUT_BOTTOM = 4;
}

class PositionHelper {

	public static inline function get(sprite:Sprite, ?horizontal:HorizontalPosition, ?vertical:VerticalPosition, ?offset:Vector):Vector {
		var result = new Vector();
		switch(horizontal) {
			case LEFT:
				result.x = sprite.origin.x;
			case OUT_LEFT:
				result.x = -sprite.size.x;
			case RIGHT:
				result.x = Luxe.camera.size.x - (sprite.size.x - sprite.origin.x);
			case OUT_RIGHT:
				result.x = Luxe.camera.size.x + sprite.origin.x;
			case CENTER:
				result.x = (Luxe.camera.size.x / 2);
			case _:
				result.x = sprite.pos.x;
		}
		
		switch(vertical) {
			case TOP:
				result.y = sprite.origin.y;
			case OUT_TOP:
				result.y = -sprite.size.y;
			case BOTTOM:
				result.y = Luxe.camera.size.y - (sprite.size.y - sprite.origin.y);
			case OUT_BOTTOM:
				result.y = Luxe.camera.size.y + sprite.origin.y;
			case MIDDLE:
				result.y = Luxe.camera.size.y / 2;
			case _:
				result.y = sprite.pos.y;
		}
		
		if (offset != null) {
			result.add(offset);
		}
		
		return result;
	}
	
}