package;

import haxe.PosInfos;
import luxe.Color;
import luxe.Entity;
import luxe.NineSlice;
import luxe.options.EntityOptions;
import luxe.options.NineSliceOptions;
import luxe.options.TextOptions;
import luxe.options.SpriteOptions;
import luxe.Rectangle;
import luxe.Sprite;
import luxe.Text;
import luxe.Text.TextAlign;
import luxe.tween.Actuate;
import luxe.Vector;
import text.TextExt;

typedef DialogBoxOptions = {
	> EntityOptions,
	
	size:Vector,
	msg_bounds:Rectangle,
	name_offset:Vector,
	name_bounds:Rectangle,
	next_offset:Vector,
	depth:Float,
	
}

class DialogBox extends Entity
{

	public var msg_bg:NineSlice;
	public var msg_text:TextExt;
	public var name_bg:NineSlice;
	public var name_text:Text;
	public var next_sprite:Sprite;
	public var hidden(default, null):Bool = false;
	
	public var has_more_text(get, never):Bool;
		inline function get_has_more_text() return msg_text.has_more_text || msg_text.state == RUNNING;
	
	@:isVar public var text(default, set):String;
		inline function set_text(s:String) {
			if(!hidden)
				msg_text.paginateText(s);
			else {
				dirty_text = true;
			}
			return text = s;
		}
		
	
	var dirty_text = false;
	var shadow_pos:Vector;
	var msg_bounds:luxe.Rectangle;
	var name_offset:Vector;
	var name_bounds:Rectangle;
	var next_offset:luxe.Vector;
	var hide_next_sprite:Bool = false;
	
	public function new(?_options:DialogBoxOptions #if debug,  ?_pos_info:haxe.PosInfos #end) {
		
		super(_options #if debug, _pos_info#end);
		
		msg_bounds = _options.msg_bounds;
		name_bounds = _options.name_bounds;
		name_offset = _options.name_offset;
		next_offset = _options.next_offset;
		
		shadow_pos = _options.pos;
		
		msg_bg = new NineSlice( {
			name: "message background",
			texture: Luxe.resources.texture("assets/ui_box_2.png"),
			top : 8, left : 0, right : 0, bottom : 0,
            color : new Color(1, 1, 1, 1),
			parent: this,
			depth: _options.depth + 0.1,
		} );
		
		msg_bg.create( new Vector(0, 0), _options.size.x, _options.size.y );
		
		msg_text = new TextExt( {
			
			name: "message text",
			font: Luxe.resources.font('assets/fonts/carlito_regular.fnt'),
			depth: _options.depth + 0.2,
			bounds_wrap: true,
			bounds: new Rectangle(msg_bg.pos.x + msg_bounds.x, msg_bg.pos.y + msg_bounds.y, msg_bg.width - msg_bounds.w, msg_bg.height - msg_bounds.h),
			//align: TextAlign.center,
			//align_vertical: TextAlign.center,
			point_size: 32,
			sdf: true,
			smoothness: 2,
			glow_threshold: 1,
			glow_color: new Color(0, 0, 0, 1),
			glow_amount: 0.9,
			parent: this,
			
		} );
		
		name_bg = new NineSlice( {
			name: "name background",
			texture: Luxe.resources.texture("assets/ui_box_3.png"),
			top : 9, left : 9, right : 9, bottom : 9,
            color : new Color(1, 1, 1, 0.8),
			parent: this,
			depth: _options.depth + 0.3,
		} );
		
		//name_bg.create( new Vector(8, -24), 240, 48);
		
		name_text = new Text( {
			name: "name text",
			font: Luxe.resources.font('assets/fonts/carlito_regular.fnt'),
			// TODO mint overrides the text format with the default shader
			shader: Luxe.resources.shader("custom_bitmapfont"),
			depth: _options.depth + 0.4,
			//bounds_wrap: false,
			//bounds: new Rectangle(name_bg.pos.x + 8, name_bg.pos.y + 4, name_bg.width - 8, name_bg.height - 4),
			align: TextAlign.left,
			align_vertical: TextAlign.center,
			point_size: 32,
			color: new Color(1, 0, 0, 1),
			sdf: true,
			smoothness: 2,
			glow_threshold: 1,
			glow_color: new Color(0, 0, 0, 1),
			glow_amount: 0.9,
			parent: this,
		} );
		
		next_sprite = new Sprite( {
			name: "next sprite",
			texture: Luxe.resources.texture("assets/next_text.png"),
			pos: new Vector(msg_bg.width - next_offset.x, msg_bg.pos.y + msg_bg.height - next_offset.y),
			depth: _options.depth + 0.5,
			parent: this,
		} );
		next_sprite.visible = true;
		next_sprite.color.a = 0.2;
		next_sprite.color.tween(0.8, { a: 0.8 }, true).repeat().reflect();
		
	}
	
	public function advanceText() {
		if (hidden) return;
		switch(msg_text.state) {
			case RUNNING:
				msg_text.skip();
			case COMPLETED | SKIPPED:
				if (msg_text.has_more_text)	msg_text.nextPage();
			case _:
		}
	}
	
	public function show(?t:Float = 0.45, ?cb:Void->Void) {
		hidden = false;
		msg_text.resume();
		Actuate.tween(this.pos, t, { y: shadow_pos.y }, true).onComplete(function() {
			if (cb != null) cb();
			if (dirty_text) {
				msg_text.paginateText(text);
				dirty_text = false;
			}
		});
	}
	
	public function hide(?t:Float = 0.45, ?cb:Void->Void) {
		hidden = true;
		msg_text.pause();
		Actuate.tween(pos, t, { y: Luxe.camera.size.y + Math.abs(name_offset.y) }, true).onComplete(function() {
			if (cb != null) cb();
		});
	}
	
	public function msg(?character:Character, msg:String, ?opt:{?cps:Float, ?fade_in:Float, ?color:Color, ?align:TextAlign, ?align_vertical:TextAlign}) {
		if (character != null) {
			name_bg.visible = true;
			name_text.visible = true;
			if (name_text.text != character.show_name) {
				var v = new Vector();
				name_text.font.dimensions_of(character.show_name, name_text.point_size, v, name_text.letter_spacing, name_text.line_spacing);
				name_text.text = character.show_name;
				name_text.color = character.color;
				name_bg.create( name_offset, v.x + (name_bounds.x + name_bounds.w), v.y + (name_bounds.y + name_bounds.h), true);
				name_text.bounds = new Rectangle(name_bg.pos.x + name_bounds.x, name_bg.pos.y + name_bounds.y, name_bg.width - name_bounds.w, name_bg.height - name_bounds.h);
			}
		} else {
			name_bg.visible = false;
			name_text.visible = false;
			opt.align = center;
			opt.align_vertical = center;
		}
		msg_text.align = opt.align;
		msg_text.align_vertical = opt.align_vertical;
		msg_text.characters_per_second = opt.cps;
		msg_text.fade_in = opt.fade_in;
		msg_text.color = opt.color == null ? new Color() : opt.color; 
		text = msg;
	}
	
	override public function update(dt:Float) {
		next_sprite.visible = !Main.disable_advance && text != "" && msg_text.state != RUNNING;
		if (next_sprite.visible) {
			next_sprite.rotation_z = msg_text.has_more_text ? 90 : 0;
		}
	}
	
}