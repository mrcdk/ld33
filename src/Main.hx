package;

import luxe.AppConfig;
import luxe.Camera.SizeMode;
import luxe.Color;
import luxe.Entity;
import luxe.Input;
import luxe.options.StateOptions;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Screen.WindowEvent;
import luxe.States;
import luxe.Text;
import luxe.Vector;
import mint.Canvas;
import mint.layout.margins.Margins;
import mint.render.luxe.Convert;
import mint.render.luxe.LuxeMintRender;
import phoenix.Batcher;

class Main extends luxe.Game {
	
	public static var mint_canvas:Canvas;
	public static var mint_renderer:LuxeMintRender;
	public static var mint_layout:Margins;
	
	public static var machine:States;
	public static var disable_advance:Bool = false;
	
	override public function config(config:luxe.AppConfig):AppConfig {
		/*
		// to preload once finished
		config.preload.jsons = [
			{ id: "assets/parcel.json" },
		];
		*/
		
		
		#if !embed
		config.window.width = 1280;
		config.window.height = 720;
		#else
		config.window.width = 890;
		config.window.height = 501;
		config.window.fullscreen = true;
		#end
		
		config.window.title = "MrCdK - LD33";
		
		#if web
		config.window.parent_element = "game";
		#end
		
		return config;
	}
	
	override function ready() {
		
		Luxe.camera.size_mode = SizeMode.contain;
		Luxe.camera.size = new Vector(1280, 720);
		
		var mint_batcher = Luxe.renderer.create_batcher( { name: "mint_batcher", camera: Luxe.camera.view } );
		
		mint_renderer = new LuxeMintRender({batcher: mint_batcher, depth: 1000});
		mint_layout = new Margins();
		
		mint_canvas = new Canvas( {
			name: 'canvas',
			rendering: mint_renderer,
            options: { color:new Color(1,1,1,0.0) },
            x: 0, y:0, w: 1280, h: 720 - 180
		} );
		
		var parcel = new Parcel({
			fonts: [
				{ id:"assets/fonts/carlito_regular.fnt" },
			],
			textures: [
				{ id:"assets/testing.png" },
				{ id:"assets/char.png" },
				{ id:"assets/ui_box_2.png" },
				{ id:"assets/ui_box_3.png" },
				{ id:"assets/next_text.png" },
				
				{ id:"assets/backgrounds/street_day.jpg" },
				{ id:"assets/backgrounds/street.jpg" },
				{ id:"assets/backgrounds/toilets.jpg" },
				{ id:"assets/backgrounds/park.jpg" },
				
				{ id:"assets/t01a/angry.png" },
				{ id:"assets/t01a/normal.png" },
				{ id:"assets/t01a/laugh.png" },
				{ id:"assets/t01a/worried_1.png" },
				{ id:"assets/t01a/worried_2.png" },
				{ id:"assets/t01a/yelling.png" },
				
				{ id:"assets/t01b/happy.png" },
				{ id:"assets/t01b/normal_1.png" },
				{ id:"assets/t01b/normal_2.png" },
				{ id:"assets/t01b/laugh.png" },
				{ id:"assets/t01b/worried.png" },
				{ id:"assets/t01b/hurt_1.png" },
				{ id:"assets/t01b/hurt_2.png" },
				
			],
			shaders: [
				{ id: "custom_bitmapfont", frag_id: "assets/shaders/frag.bitmapfont.glsl", vert_id: "default" },
				{ id: "colormatrix", frag_id: "assets/shaders/frag.colormatrix.glsl", vert_id: "default" },
			],
		});
		
		//var parcel = new Parcel();
		//parcel.from_json(Luxe.resources.json("assets/parcel.json").asset.json);
		
		var progress = new ParcelProgress( {
			parcel: parcel,
			oncomplete: assets_loaded,
		} );
		
		parcel.load();
	}

	function assets_loaded(_) {
		
		machine = new States( { name:"machine" } );
		var game = new GameState( { name:"Game" } );
		machine.add(game);
		machine.set("Game");
		
	}
	
	override public function onrender() {
		mint_canvas.render();
	}
	override function update(dt:Float) {
		mint_canvas.update(dt);
	}
	override function onmousemove(e) {
		mint_canvas.mousemove(Convert.mouse_event(e, Luxe.camera.view));
	}
    override function onmousewheel(e) {
        mint_canvas.mousewheel( Convert.mouse_event(e, Luxe.camera.view) );
    }
    override function onmouseup(e) {
        mint_canvas.mouseup( Convert.mouse_event(e, Luxe.camera.view) );
    }
    override function onmousedown(e) {
        mint_canvas.mousedown( Convert.mouse_event(e, Luxe.camera.view) );
    }
    override function onkeydown(e:luxe.Input.KeyEvent) {
        mint_canvas.keydown( Convert.key_event(e) );
    }
    override function ontextinput(e:luxe.Input.TextEvent) {
        mint_canvas.textinput( Convert.text_event(e) );
    }
	
	override function onkeyup(e:KeyEvent) {
		mint_canvas.keyup(Convert.key_event(e));
		
		#if !web
		if(e.keycode == Key.escape)
			Luxe.shutdown();
		#end
	}

	
}