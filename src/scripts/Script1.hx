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
	var c3:Character;

	public function new(game:GameState) {
		super(game);
	}
	
	override public function start() {
		// TODO Move to GameState
		c1 = new Character("Bakemono", new Color(1, 0, 0, 1));
		c2 = new Character("Harumi", new Color(1, 0, 1, 1));
		c3 = new Character("Developer", new Color().rgb(0xadd8e6));
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
		
		f(function() {
			game.dialog_box.hide(0);
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			game.sprite.pos = PositionHelper.get(game.sprite, CENTER, BOTTOM);
			Luxe.timer.schedule(1, function() game.dialog_box.show(1, nextEvent));
		});
		m("I'm a monster.");
		m("Surprised, eh?");
		m("It's not like it is the Ludum Dare theme or anything like that...");
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
		m("I haven't told you my name yet, have I?");
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
		m("Anyway, Nice to meet you... Pla- player?");
		f(true, after_choice_name);
	}
	
	function choice_name_1() {
		m('Yeah, I thought so, my name is ${c1.name}.\nNice to meet you... Pla- player?');
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
		m(c1, 'Bu- but my real name is ${c1.name}... ;-;');
		m(". . .", 10 / 60, 0.45);
		m('And from that day on, I was reborn as Munchie...\nThanks... who is the monster now? ;-;');
		f(true, after_choice_name);
	}
	
	function after_choice_name() {
		f(function() {
			game.background.color.a = 0;
			game.sprite.color.a = 0;
			game.background.texture = Luxe.resources.texture("assets/backgrounds/toilets.jpg");
			game.sprite.pos = PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM);
			game.dialog_box.hide(1, nextEvent);
		});
		tween(true, tween_fade.bind(game.background, 1.5, 1));
		f(true,function() {
			game.dialog_box.show(1);
		});
		m("I'm here, finally...");
		m("This is our usual place...");
		m("Yep, public toilets.");
		m("I know what you are thinking...");
		m("...why public toilets of all places... right?");
		cm(game.background, 2, ColorMatrix.normal, ColorMatrix.sepia);
		choices([
			{text:'Yeah...', func: choice_why_toilet_0 },
			{text:'What? Isn\'t the perfect place to meet?', func: choice_why_toilet_1 },
			{text:'Nah, I don\'t care. I just want this to end so I can rate more games.', func: choice_why_toilet_2 },
		]);
	}
	
	function choice_why_toilet_0() {
		m("And you think I know the answer?");
		m("She likes this place...");
		f(true, after_choice_why_toilet);
	}
	
	function choice_why_toilet_1() {
		m("Ehm... I would say no but... Maybe you are right, maybe this is the perfect place to dat... meet her...");
		m("Anyway, let's move on.");
		f(true, after_choice_why_toilet);
	}
	
	function choice_why_toilet_2() {
		Vars.choose_to_end = true;
		m('Oh... OK...');
		tween(true, tween_fade.bind(game.background, 1, 0));
		f(true, the_end);
	}
	
	function after_choice_why_toilet() {
		m("...");
		cm(game.background, 2, ColorMatrix.sepia, ColorMatrix.normal, true);
		m("Where is she? I don't see her around...");
		m("And, ugh, it smells really bad here... I wonder why...");
		tween(function() {
			game.sprite.color.a = 0.6;
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
		m(c2, "You mean... tentacles... right?");
		m(c1, "Oh... yeah, yeah... tentacles... of course... multiple ones...");
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
			m(c2, "I like it!");
			m("Oh... Thanks player! ^-^\nI owe you one!");
		} else {
			transition(game.sprite, c2.textures.get("b_normal_1"), TransitionHelper.fade);
			tween(true, tween_move.bind(game.sprite, 1, PositionHelper.get(game.sprite, CENTER, BOTTOM)));
		}
		show(c2, "b_normal_1");
		m(c1, "So, remind me why is this the usual place, please?");
		show(c2, "b_normal_2");
		m(c2, "Nothing special... I like it here.");
		m(c1, "But... I mean... it stinks...");
		show(c2, "b_hurt_1");
		m(c2, "So- Sorry...");
		shake(40);
		m(c1, "Wait! Was it you?!");
		show(c2, "b_hurt_2");
		m(c2, "...");
		m(c1, "It... it's ok...");
		m(c2, "I... I have to... go back...");
		tween(true,function() {
			tween_fade(game.sprite, 0.5, 0.6);
			return tween_move(game.sprite, 0.5, PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM));
		});
		m(c1, "Well...");
		m(c1, "I don't have anywhere else to be... I guess I will wait here.");
		m("She is cute, isn't she?\n\nAh~~~");
		m("But I... can't tell her my feelings yet...");
		m("I remember the day I met her...");
		f(true, remember);
	}
	
	function remember() {
		f(true, function() {
			game.sprite.color.a = 1;
			game.sprite.shader = game.color_matrix.shader;
			game.sprite.pos = PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM);
			c2.show_name = "That girl";
			c1.show_name = c1.name;
		});
		transition(game.background, Luxe.resources.texture("assets/backgrounds/street.jpg"), 2, TransitionHelper.fade, true);
		cm(game.background, 2, ColorMatrix.normal, ColorMatrix.sepia);
		m("I saw her in this street.");
		m("I clearly remember it...\nAs if it were yesterday...");
		m(". . .");
		m("Yes, it was yesterday, ok?");
		m("\"haha, hehe, I knew it!\" Bah v-v");
		m("Anyway, she was walking down the street when she saw me.");
		shake(100);
		show(c2, "a_yelling");
		tween(function() {
			return tween_move(game.sprite, 0.93, PositionHelper.get(game.sprite, OUT_LEFT, BOTTOM)).repeat().reflect();
		});
		m(c2, "AAAAAAAAAAAAAAAAAAAHHHHHHHHHHHH!!!!!!!!!!!!!!");
		m(c1, "Hello.");
		shake(100);
		m(c2, "A monster!!!");
		m(c1, "Good observation...");
		show(c2, "a_worried_1");
		tween(function() {
			return tween_move(game.sprite, 1, PositionHelper.get(game.sprite, CENTER, BOTTOM));
		});
		m(c2, "I... sorry.");
		m(c1, "It's ok. I'm used to it...");
		m(c2, "... What's your name?");
		m(c1, "...people don't usually talk with me...");
		show(c2, "a_worried_2");
		m(c2, "Your name...?");
		m(c1, "...they run away from me... I'm a monster...");
		show(c2, "a_angry");
		m(c2, "NAME!");
		shake(40);
		m(c1, '${c1.name}!!!');
		show(c2, "a_laugh");
		m(c2, 'My name is ${c2.name}.');
		f(true, function() {
			game.sprite.shader = null;
			c2.show_name = c2.name;
		});
		m(c2, 'Nice to meet you ${c1.name}.');
		m(c1, 'Nice... to meet you ${c2.name}...');
		m(c2, "Well, I have to go. I will see you tomorrow!");
		tween(function() {
			return tween_move(game.sprite, 1, PositionHelper.get(game.sprite, CENTER, OUT_BOTTOM));
		});
		m(c1, "Wait... What just happened?");
		m(". . .");
		m("To- tomorrow... How?!");
		
		transition(game.background, Luxe.resources.texture("assets/backgrounds/toilets.jpg"), 2, TransitionHelper.fade);
		cm(game.background, 2, ColorMatrix.sepia, ColorMatrix.normal, true);
		f(true, function() {
			c2.show_name = c2.name;
			game.sprite.pos = PositionHelper.get(game.sprite, OUT_RIGHT, BOTTOM);
			if (Vars.choose_munchie) c1.show_name = "Munchie";
		});
		
		f(true, continue_after_toilet);
	}
	
	function continue_after_toilet() {
		m("*floooosshh*\n(see? sound effects!)");
		show(c2, "b_normal_2");
		tween(function() {
			game.sprite.color.a = 0.6;
			tween_fade(game.sprite, 0.8, 1);
			return tween_move(game.sprite, 4, PositionHelper.get(game.sprite, CENTER, BOTTOM));
		});
		m(c2, "Ah~~~ Much better!");
		m("Ugh... the smell...");
		m(c2, "Let's go!");
		f(true, function() game.dialog_box.hide());
		transition(game.background, Luxe.resources.texture("assets/backgrounds/park.jpg"), 2, TransitionHelper.fade, true);
		f(true, function() game.dialog_box.show());
		m(c2, "We are here!");
		m("That was quick...");
		m(c2, "It was, wasn't it?");
		m(c1, "Just because my thoughts can be seen by everyone you shouldn't take advantage of it ;-;");
		show(c2, "b_worried");
		m(c2, "Sorry...");
		m(c1, "Hahaha, it's ok.");
		show(c2, "b_happy");
		m(c2, "I like you!");
		m(c1, "Yeah... right...");
		show(c2, "b_worried");
		m(c2, "It's true... I was waiting for this day to come...");
		shake(30);
		show(c2, "b_hurt_2");
		m(c1, "I know you are joking!!!");
		m(c2, "...");
		transition(game.sprite, c2.textures.get("a_laugh"), TransitionHelper.fade);
		m(c2, 'I really like you, ${c1.show_name}!');
		m("*cue romantic music*");
		m(c1, "Re- really?");
		m(c2, "Yes!!!");
		m(c1, "But I... I am horrible... I'm a monster afterall...");
		show(c2, "a_worried_1");
		m(c2, "So?");
		m(c1, "So... you are an human... and we can't...");
		show(c2, "a_laugh");
		m(c2, "But this is Japan... and you have tentacles...");
		m(c1, "Oh... In that case...");
		tween(function() {
			tween_fade(game.background, 1, 0);
			return tween_fade(game.sprite, 2, 0);
		});
		m("*baw chika bow wow*");
		f(true, the_end);
		
	}
	
	
	function the_end() {
		var dev_color = c3.color;
		f(true, function() {
			game.background.color.a = 0;
			game.sprite.color.a = 0;
		});
		m("~~~ THE END ~~~", 20 / 60, 0.6, new Color(0.3, 0.2, 0.8));
		m(c1, "Wait... is that all?");
		if (Vars.choose_to_end) {
			m(c3, "Well... the player chose to skip all the game...", dev_color);
			m(c1, "Oh, yeah... He did :(");
			m(c1, "So... can we go back?");
			m(c3, "Nah. " + #if web "Refresh the page." #else "Close and open the game again." #end, dev_color);
			m(c1, "... OK...");
			f(function() {
				game.dialog_box.hide(1, nextEvent);
			});
			f(true, function() {
				game.dialog_box.show(4);
				Main.disable_advance = true;
			});
			m("~~~ BAD END ~~~\nTh- Thanks for... playing... I guess ;-;", 8 / 60, 0.8, new Color(1, 0, 0));
			
		} else {
			m(c3, "Yeah, not enough time left.", dev_color);
			m(c1, "Oh, wait... you can talk...");
			m(c3, "Yep.", dev_color);
			m(c1, "So all this time...");
			m(c3, "Yep.", dev_color);
			m(c1, "... The end is kind of... meh.");
			m(c3, "Nah, it's fine, I'm already working on DLCs.", dev_color);
			m(c1, "Oh, then it's cool :D");
			f(function() {
				game.dialog_box.hide(1, nextEvent);
			});
			f(true, function() {
				game.dialog_box.show(4);
				Main.disable_advance = true;
			});
			m("~~~ GOOD END ~~~\nThanks for playing!", 8 / 60, 0.8, new Color(0, 1, 0));
		}
	}
}