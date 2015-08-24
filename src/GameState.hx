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
import luxe.Visual;
import mint.Button;
import mint.Control;
import mint.Control.MouseSignal;
import mint.Label;
import mint.layout.margins.Margins.AnchorType;
import mint.layout.margins.Margins.MarginTarget;
import mint.layout.margins.Margins.MarginType;
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
		background.add(new TransitionHelper());
		
		
		sprite = new Sprite( {
			name: "Char",
			texture:Luxe.resources.texture("assets/t01a/normal.png"),
			size: new Vector(416, 600),
			depth: 20,
		} );
		sprite.add(new TransitionHelper());
		
		dialog_box = new DialogBox( {
			name: "Dialog box",
			pos: new Vector(0, Luxe.camera.size.y - 180),
			size: new Vector(Luxe.camera.size.x, 180),
			msg_bounds: new Rectangle(16, 32, 16, 32),
			name_offset: new Vector(8, -16),
			name_bounds: new Rectangle(8, 2, 8, 4),
			next_offset: new Vector(42, 32),
			depth: 100,
		} );
		
		color_matrix = new ColorMatrix();
		
		sequence = new Sequence();
		seqIterator = sequence.iterator();
		
		var script = new Script1(this);
		
		
		
		nextEvent();
		
	}
	
	override public function update(dt:Float) {
		
		var advance = false;
		
		if (!Main.disable_advance && Luxe.input.inputpressed("continue") && !dialog_box.hidden) {
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
	
	public function showChoices(?time:Float = 0.8, choices:Array<{text:String, func:Void->Void } > ) {
		
		Main.disable_advance = true;
		
		var font = Luxe.resources.font('assets/fonts/carlito_regular.fnt');
		var dimensions = new Vector();
		var lerp = function(i) return Maths.lerp(20, 100, i / choices.length);
		var txt:Text;
		var visual:Visual;
		for (i in 0...choices.length) {
			var choice = choices[i];
			font.dimensions_of(choice.text, 24, dimensions);
			var button = new Button( {
				parent: Main.mint_canvas,
				name: "button" + i,
				x: 0, y:0, w:dimensions.x + 32, h: dimensions.y + 16,
				text: choice.text,
				text_size: 24,
				onclick: function(e, c) {
					choice.func();
					hideChoices(c);
				}
			} );
			
			visual = Luxe.scene.get('${button.name}.visual');
			txt = Luxe.scene.get('${button.name}.label.text');
			txt.font = font;
			txt.geom.texture = txt.font.pages[0];
			
			visual.color.a = 0;
			txt.color.a = 0;
			button.mouse_input = false;
			visual.color.tween(time, { a:1 } ).onComplete(function() button.mouse_input = true);
			txt.color.tween(time, { a:1 } );
			
			Main.mint_layout.margin(button, top, percent, lerp(i));
			Main.mint_layout.anchor(button, center_x, center_x);
		}

	}
	
	public function hideChoices(?time:Float = 0.8, ?selected:Control) {
		
		var txt:Text;
		var visual:Visual;
		var delay = time + 0.2;
		for (button in Main.mint_canvas.children) {
			visual = Luxe.scene.get('${button.name}.visual');
			txt = Luxe.scene.get('${button.name}.label.text');
			button.mouse_input = false;
			visual.color.tween(time, { a:0 } );
			txt.color.tween(time, { a:0 } ).delay(button == selected ? delay : 0).onComplete(button.destroy);
		}
		
		Luxe.timer.schedule(time + delay, function() { Main.disable_advance = false; nextEvent(); } );
	}
	
}