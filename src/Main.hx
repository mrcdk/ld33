package;

import luxe.AppConfig;
import luxe.Camera.SizeMode;
import luxe.Entity;
import luxe.Input;
import luxe.options.StateOptions;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.States;
import luxe.Text;
import luxe.Vector;

class Main extends luxe.Game {
	
	var machine:States;
	
	override public function config(config:luxe.AppConfig):AppConfig {
		/*
		// to preload once finished
		config.preload.jsons = [
			{ id: "assets/parcel.json" },
		];
		*/
		
		config.window.width = 1280;
		config.window.height = 720;
		config.window.title = "MrCdK - LD33";
		
		#if web
		config.window.parent_element = "game";
		#end
		
		return config;
	}
	
	override function ready() {
		
		Luxe.camera.size_mode = SizeMode.contain;
		Luxe.camera.size = new Vector(1280, 720);
		
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
				
				{ id:"assets/backgrounds/street_day_crop.jpg" },
				
				{ id:"assets/t01a/angry.png" },
				{ id:"assets/t01a/normal.png" },
				{ id:"assets/t01a/laugh.png" },
				{ id:"assets/t01a/worried_1.png" },
				{ id:"assets/t01a/worried_2.png" },
				{ id:"assets/t01a/yelling.png" },
				
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
	
	override function onkeyup(e:KeyEvent) {
		if(e.keycode == Key.escape)
			Luxe.shutdown();
	}

	override function update(dt:Float) {
	}
}