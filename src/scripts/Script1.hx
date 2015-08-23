package scripts;
import luxe.Color;

/**
 * ...
 * @author MrCdK
 */
class Script1 extends BaseScript
{

	public function new(game:GameState) {
		super(game);
	}
	
	override public function start() {
		// TODO Move to GameState
		var c1 = new Character("Tom", new Color(1, 0, 0, 1));
		var c2 = new Character("Elise", new Color(1, 0, 1, 1));
		c2.textures.set("normal", Luxe.resources.texture("assets/t01a/normal.png"));
		c2.textures.set("laugh", Luxe.resources.texture("assets/t01a/laugh.png"));
		c2.textures.set("yelling", Luxe.resources.texture("assets/t01a/yelling.png"));
		c2.textures.set("angry", Luxe.resources.texture("assets/t01a/angry.png"));
		c2.textures.set("worried_1", Luxe.resources.texture("assets/t01a/worried_1.png"));
		c2.textures.set("worried_2", Luxe.resources.texture("assets/t01a/worried_2.png"));
		
		f(function() {
			game.dialog_box.hide(0);
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			c1.show_name = "The monster";
			Luxe.timer.schedule(1, function() game.dialog_box.show(1, nextEvent));
		});
		m("I'm a monster.");
		m("That kind of monster with green and slimmy skin, deformed body and... tentacles...");
		f(function() {
			game.background.color.tween(2, { a:1 } ).onComplete(nextEvent);
		});
		show(c2, "yelling", false);
		m(c2, "Are you here?! Hello?!", 0, 0.01);
		show(c2, "worried_1", false);
		f(function() { 
			Luxe.camera.shake(20);
			nextEvent();
		});
		m(c1, "Holy cra... oh... hello, you scared the shit out of me...");
		show(c2, "worried_2", false);
		m(c2, "But... you are the monster here... you scare me more!");
		m(c1, "Ouch... ;-;");
		show(c2, "laugh", false);
		m(c2, "Hahaha I'm kidding you silly!");
		cm(game.background, 2, ColorMatrix.normal, ColorMatrix.desaturate);
		m('This is ${c2.name}. She is a good friend of mine, she doesn\'t cares that I am a monster... or about anything really. She is kind of cute, even for a monster like me. Because she is an human, I have no chances with her...');
		m("... but I... would like to...");
		cm(game.background, 0.5, ColorMatrix.desaturate, ColorMatrix.normal, true);
		show(c2, "angry", false);
		m(c2, "Gosh! again?!");
		show(c2, "normal", false);
		m(c1, "^^; Sorry sorry.");
		m(c2, "So, are you coming or not?");
		m(c1, "Yeah... I guess I will.");
		m(c2, "Ok! I'll be waiting for you in the usual place!");
		m(c1, "Ok.");
		hide(c2, false);
		m(c1, "Mmm that booty...");
		m(c1, "Wait, what? ... I mean... well... uhh...");
		f(function() {
			game.background.color.tween(2, { a:0 } );
			nextEvent();
		});
		m("Aaaanyway... As I was telling you, I'm a monster, the worst kind of monster that you can imagine.");
		m("I would show you a picture of me but that would mean to go and stea... \"find\" an image somewhere.");
		m("(Oh! Oh! Oh!!! Yeah! That will do...)");
		m("Actually... it's not because the developer is lazy... but... uh... it... is... because I don't appear in photos... you know, like vampires and all that silly stuff... ma-maybe...");
		m("(It sounded better in my head...)");
		m("Anyway, I haven't told you my name yet, have I?");
		m("1.Yes.\n2.No.\nWORK IN PROGRESS D:");
		
		m("THE END", 0.2, 1, new Color(1, 0, 0));
		
	}
	
}