package;
import luxe.Color;
import phoenix.Texture;

/**
 * ...
 * @author MrCdK
 */
class Character {

	public var name(default, null):String;
	public var show_name:String;
	public var color:Color;
	public var textures:Map<String, Texture>;
	
	public function new(name:String, color:Color) {
		this.name = name;
		this.color = color;
		
		show_name = name;
		
		textures = new Map();
	}
	
}