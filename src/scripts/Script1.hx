package scripts;

import luxe.Color;
import luxe.Vector;

/**
 * ...
 * @author MrCdK
 */
class Script1 extends BaseScript
{
	var c1:Character;
	var c2:Character;

	public function new(game:GameState) {
		super(game);
	}
	
	override public function start() {
		// TODO Move to GameState
		c1 = new Character("Tom", new Color(1, 0, 0, 1));
		c2 = new Character("Elise", new Color(1, 0, 1, 1));
		c2.textures.set("normal", Luxe.resources.texture("assets/t01a/normal.png"));
		c2.textures.set("laugh", Luxe.resources.texture("assets/t01a/laugh.png"));
		c2.textures.set("yelling", Luxe.resources.texture("assets/t01a/yelling.png"));
		c2.textures.set("angry", Luxe.resources.texture("assets/t01a/angry.png"));
		c2.textures.set("worried_1", Luxe.resources.texture("assets/t01a/worried_1.png"));
		c2.textures.set("worried_2", Luxe.resources.texture("assets/t01a/worried_2.png"));
		
		c1.show_name = "The monster";
		c2.show_name = "A random girl";
		
		f(function() {
			game.dialog_box.hide(0);
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			Luxe.timer.schedule(1, function() game.dialog_box.show(1, nextEvent));
		});
		m("I'm a monster.");
		m("That kind of monster with green and slimmy skin, deformed body and... tentacles...");
		tween(true, tween_fade.bind(game.background, 1, 1));
		show(c2, "yelling");
		tween(true, tween_fade.bind(game.sprite, 0.8, 1));
		m(c2, "Are you here?! Hello?!", 0, 0.01);
		show(c2, "worried_1");
		shake(20);
		m(c1, "Holy cra... oh... hello, you scared the shit out of me...");
		show(c2, "worried_2");
		m(c2, "But... you are the monster here... you scare me more!");
		m(c1, "Ouch... ;-;");
		show(c2, "laugh");
		m(c2, "Hahaha I'm kidding you silly!");
		cm(game.background, 2, ColorMatrix.normal, ColorMatrix.desaturate);
		f(true, function() c2.show_name = c2.name);
		m('This is ${c2.name}. She is a good friend of mine, she doesn\'t care that I am a monster... or about anything else, really. She is kind of cute, even for a monster like me. Because she is an human, I have no chances with her...');
		m("... but I... would like to...");
		cm(game.background, 0.5, ColorMatrix.desaturate, ColorMatrix.normal, true);
		show(c2, "angry");
		m(c2, "Gosh! again?!");
		show(c2, "normal");
		m(c1, "^^; Sorry sorry.");
		m(c2, "So, are you coming or not?");
		m(c1, "Yeah... I guess I will.");
		m(c2, "Ok! I'll be waiting for you at the usual place!");
		m(c1, "Ok.");
		tween(function() {
			return tween_move(game.sprite, 2, new Vector(Luxe.camera.size.x + game.sprite.origin.x, game.sprite.pos.y));
		});
		m(c1, "Mmm that booty...");
		show(c2, "laugh");
		tween(function() {
			tween_fade(game.sprite, 0.2, 1);
			return tween_move(game.sprite, 0.2, new Vector(Luxe.camera.size.x - game.sprite.origin.x, game.sprite.pos.y));
		});
		shake(20);
		m(c2, "Yeah? did you call me?");
		m(c1, "Haha...ha...ha . . .");
		show(c2, "normal");
		m(c2, "I'm leaving for real this time!");
		tween(true, function() {
			return tween_move(game.sprite, 1, new Vector(Luxe.camera.size.x - game.sprite.origin.x/2, game.sprite.pos.y));
		});
		m(c2, "Mmmmm");
		tween(true,function() {
			tween_fade(game.sprite, 0.5, 0);
			return tween_move(game.sprite, 0.5, new Vector(Luxe.camera.size.x + game.sprite.origin.x, game.sprite.pos.y));
		});
		m(". . .", 10 / 60, 0.45);
		f(true, function() game.background.color.tween(2, { a:0 } ));
		m("Aaaanyway... As I was telling you, I'm a monster, the worst kind of monster that you can imagine.");
		m("I would show you a picture of me but that would mean to go and stea... \"find\" an image somewhere.");
		m("(Oh! Oh! Oh!!! Yeah! That will do...)");
		m("Actually... it's not because the developer is lazy... but... uh... it... is... because I don't appear in photos... you know, like vampires and all that silly stuff... ma-maybe...");
		m("(It sounded better in my head...)");
		m("Anyway, I haven't told you my name yet, have I?");
		choices([
			{text:'Yes, it\'s "${c1.show_name}". It says so in the dialog box :D', func: choice_name_0 },
			{text:'No, I don\'t think so.', func: choice_name_1 },
			{text:'Can I call you Munchie?', func: choice_name_2 },
		]);
		
		//m("THE END", 0.2, 1, new Color(1, 0, 0));
		
	}
	
	function choice_name_0() {
		m(". . .", 10 / 60, 0.45);
		m(c1, "SERIOUSLY?!", 0.2 / 60, 0.05);
		shake(50);
		m(c1, "HAHAHAHAHAHAHA");
		m(c1, 'Of course my name isn\'t "${c1.show_name}"!!!');
		m(c1, 'My name is "${c1.name}"!!!');
		f(true, function() c1.show_name = c1.name);
		shake(20);
		m(c1, 'Hahaha! people is so naïve...');
		m("Anyway, Nice to meet you... Pla-player... I guess.");
		f(true, after_choice_name);
	}
	
	function choice_name_1() {
		m('Yeah, I thought so, my name is ${c1.name}. Nice to meet you... Pla-player... I guess.');
		f(true, function() c1.show_name = c1.name);
		f(true, after_choice_name);
	}
	
	function choice_name_2() {
		f(true, function() c1.show_name = "Munchie");
		m("Ehm... Munchie???");
		shake(20);
		m(c1, "Of course not!!!");
		shake(80);
		m(c1, "Wait... WHAT?!?!");
		m(c1, 'Bu--but my real name is ${c1.name}... ;-;');
		m(". . .", 10 / 60, 0.45);
		m('And from that day, I was called Munchie... ;-;');
		f(true, after_choice_name);
	}
	
	function after_choice_name() {
		m(c1, "After choice name");
	}
	
}