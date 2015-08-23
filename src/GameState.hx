package;

import luxe.Color;
import luxe.Input.Key;
import luxe.Input.KeyEvent;
import luxe.Input.MouseButton;
import luxe.Input.TouchEvent;
import luxe.Matrix;
import luxe.NineSlice;
import luxe.options.StateOptions;
import luxe.Particles.ParticleSystem;
import luxe.Rectangle;
import luxe.Sprite;
import luxe.States.State;
import luxe.Text;
import luxe.tween.Actuate;
import luxe.tween.actuators.GenericActuator.IGenericActuator;
import luxe.utils.Maths;
import luxe.Vector;
import phoenix.Shader;
import scripts.Script1;
import text.TextExt.TextState;
import Sequence.SeqType;

class GameState extends State {
	
	public var sequence:Sequence;
	
	public var dialog_box:DialogBox;
	public var background:Sprite;
	public var sprite:Sprite;
	
	public var color_matrix:ColorMatrix;
	
	var seqIterator:Iterator<{type:SeqType, data:Dynamic}>;

	public function new(_options:StateOptions) {
		super(_options);
	}
	
	override public function init() {
		
		Luxe.input.bind_key("continue", Key.space);
		Luxe.input.bind_mouse("continue", MouseButton.left);
		
		
		background = new Sprite( {
			name: "BG",
			centered: false,
			size: new Vector(1280, 720),
			texture: Luxe.resources.texture("assets/backgrounds/street_day_crop.jpg"),
			depth: 10,
		} );
		
		sprite = new Sprite( {
			name: "Char",
			texture:Luxe.resources.texture("assets/char.png"),
			pos: new Vector(Luxe.camera.size.x / 2, Luxe.camera.size.y / 2 + 60),
			size: new Vector(416, 600),
			depth: 20,
		} );
		
		dialog_box = new DialogBox( {
			name: "Dialog box",
			pos: new Vector(0, Luxe.camera.size.y - 180),
			size: new Vector(Luxe.camera.size.x, 180),
			msg_bounds: new Rectangle(16, 32, 16, 32),
			name_offset: new Vector(8, -16),
			name_bounds: new Rectangle(8, 2, 8, 4),
			next_offset: new Vector(42, 32),
			depth: 30,
		} );
		
		color_matrix = new ColorMatrix();
		
		sequence = new Sequence();
		seqIterator = sequence.iterator();
		
		var script = new Script1(this);
		
		nextEvent();
	}
	
	override public function update(dt:Float) {
		
		var advance = false;
		
		if (Luxe.input.inputpressed("continue") && !dialog_box.hidden) {
			if (dialog_box.has_more_text) {
				dialog_box.advanceText();
				advance = false;
			} else {
				advance = true;
			}
		}
		
		if (!advance) return;
		
		nextEvent();
		
	}
	
	public function nextEvent() {
		if (!seqIterator.hasNext()) return;
		
		var seq:{type:SeqType, data:Dynamic} = seqIterator.next();
		switch(seq.type) {
			case SeqType.MSG:
				dialog_box.msg(seq.data.character, seq.data.msg, seq.data.opt);
			case SeqType.FUNC:
				if(seq.data.func != null) seq.data.func();
			case _:
		}
	}
	
}