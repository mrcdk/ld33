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
		c2.textures.set("a_normal", Luxe.resources.texture("assets/t01a/normal.png"));
		c2.textures.set("a_laugh", Luxe.resources.texture("assets/t01a/laugh.png"));
		c2.textures.set("a_yelling", Luxe.resources.texture("assets/t01a/yelling.png"));
		c2.textures.set("a_angry", Luxe.resources.texture("assets/t01a/angry.png"));
		c2.textures.set("a_worried_1", Luxe.resources.texture("assets/t01a/worried_1.png"));
		c2.textures.set("a_worried_2", Luxe.resources.texture("assets/t01a/worried_2.png"));
		
		c2.textures.set("b_normal_1", Luxe.resources.texture("assets/t01b/normal_1.png"));
		c2.textures.set("b_normal_2", Luxe.resources.texture("assets/t01b/normal_2.png"));
		c2.textures.set("b_laugh", Luxe.resources.texture("assets/t01b/laugh.png"));
		c2.textures.set("b_happy", Luxe.resources.texture("assets/t01b/happy.png"));
		c2.textures.set("b_worried", Luxe.resources.texture("assets/t01b/worried.png"));
		c2.textures.set("b_hurt_1", Luxe.resources.texture("assets/t01b/hurt_1.png"));
		c2.textures.set("b_hurt_2", Luxe.resources.texture("assets/t01b/hurt_2.png"));
		
		c1.show_name = "The monster";
		c2.show_name = "A random girl";
		
		//Vars.choose_munchie = false;
		//after_choice_name();
		//return;
		
		f(function() {
			game.dialog_box.hide(0);
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			game.sprite.pos = PositionHelper.get(game.sprite, CENTER, BOTTOM);
			Luxe.timer.schedule(1, function() game.dialog_box.show(1, nextEvent));
		});
		m("I'm a monster.");
		m("Surprised, eh?");
		m("I'm the kind of monster with green and slimmy skin, deformed body and... tentacles...");
		tween(true, tween_fade.bind(game.background, 1, 1));
		show(c2, "a_yelling");
		tween(true, tween_fade.bind(game.sprite, 0.8, 1));
		m(c2, "Are you here?! Hello?!", 0, 0.01);
		show(c2, "a_worried_1");
		shake(20);
		m(c1, "Holy cra... oh... hello, you scared the shit out of me...");
		show(c2, "a_worried_2");
		m(c2, "But... you are the monster here... you scare me more!");
		m(c1, "Ouch... ;-;");
		show(c2, "a_laugh");
		m(c2, "Hahaha I'm kidding you, silly!");
		cm(game.background, 2, ColorMatrix.normal, ColorMatrix.desaturate);
		f(true, function() c2.show_name = c2.name);
		m('This is ${c2.name}. She is a good friend of mine, she doesn\'t care that I am a monster... or about anything else, really. She is kind of cute, even for a monster like me. Because she is an human, I have no chances with her...');
		m("... but I... would like to...");
		cm(game.background, 0.5, ColorMatrix.desaturate, ColorMatrix.normal, true);
		show(c2, "a_angry");
		m(c2, "Gosh! again?!");
		show(c2, "a_normal");
		m(c1, "Sorry, sorry ^^;");
		m(c2, "So, are you coming or not?");
		m(c1, "Yeah... I guess I will.");
		m(c2, "Ok! I'll be waiting for you at the usual place!");
		m(c1, "Ok.");
		tween(function() {
			return tween_move(game.sprite, 2, PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM));
		});
		m(c1, "Mmm that booty...");
		show(c2, "a_laugh");
		tween(function() {
			tween_fade(game.sprite, 0.2, 1);
			return tween_move(game.sprite, 0.2, PositionHelper.get(game.sprite, RIGHT, BOTTOM));
		});
		shake(20);
		m(c2, "Yeah? did you call me?");
		m(c1, "Haha...ha...haaa...");
		show(c2, "a_normal");
		m(c2, "I'm leaving for real this time!");
		tween(true, function() {
			return tween_move(game.sprite, 1, PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM, new Vector(-game.sprite.origin.x-40, 10)));
		});
		show(c2, "a_worried_1");
		m(c2, "Mmmmm...");
		tween(true,function() {
			tween_fade(game.sprite, 0.5, 0);
			return tween_move(game.sprite, 0.5, PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM));
		});
		tween(tween_fade.bind(game.background, 2.5, 0));
		m(". . .", 10 / 60, 0.45);
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
		f(true, function() { 
			Vars.choose_munchie = true;
			c1.show_name = "Munchie";	
		});
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
		f(function() {
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			game.background.texture = Luxe.resources.texture("assets/backgrounds/toilets.jpg");
			game.sprite.pos = PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM);
			game.dialog_box.hide(nextEvent);
		});
		tween(true, tween_fade.bind(game.background, 1.5, 1));
		f(true,function() {
			game.dialog_box.show();
		});
		m("I'm here, finally...");
		// TODO more text wondering why he is here
		m("Ugh, it smells really bad here... I wonder why.");
		tween(function() {
			tween_fade(game.sprite, 0.8, 1);
			return tween_move(game.sprite, 2, PositionHelper.get(game.sprite, LEFT, BOTTOM));
		});
		show(c2, "a_worried_1");
		m(c2, "Ugh, it smells like you after doing dirty things with me...");
		cm(game.background, 0.2, ColorMatrix.normal, ColorMatrix.negative);
		shake(100);
		m("WH- WHA- WH-- WHAAAAT?!?!\nI'VE NEVER DONE THAT!!!");
		cm(game.background, 0.2, ColorMatrix.negative, ColorMatrix.normal, true);
		show(c2, "a_worried_2");
		m(c2, "... like play in the mud... eat dirt... or... umm... what does a monster do?");
		m("Oh...");
		m(c1, "Ummm... I usually play with my tentacle.");
		show(c2, "a_worried_1");
		m(c2, "You mean... tentacleS... right?");
		m(c1, "Oh... yeah, yeah... tentacleS... of course... multiple ones...");
		m("That was close...");
		if (Vars.choose_munchie) {
			transition(game.sprite, c2.textures.get("b_normal_1"), 1.2, TransitionHelper.fade);
			tween(tween_move.bind(game.sprite, 1, PositionHelper.get(game.sprite, CENTER, BOTTOM)));
			m(c2, "Wait a second...");
			m(c2, "Your name...");
			m(c1, "...");
			shake(40);
			show(c2, "b_laugh");
			m(c2, "HAHAHAHA");
			m(c1, "Don't ;-;");
			shake(20);
			show(c2, "b_happy");
			m(c2, "Hahaha");
			m(c2, "Mu... Mun... Munchie...");
			m(c1, ";-;", 10 / 60, 0.45);
		} else {
			transition(game.sprite, c2.textures.get("b_normal_1"), TransitionHelper.fade);
			tween(true, tween_move.bind(game.sprite, 1, PositionHelper.get(game.sprite, CENTER, BOTTOM)));
		}
		show(c2, "b_normal_1");
		m(c1, "So, remind me why is this the usual place, please?");
	}
	
}