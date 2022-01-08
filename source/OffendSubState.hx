import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

using StringTools;

class OffendSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];
	var icon:HealthIcon;
	var onYes:Bool = true;
	var yesText:Alphabet;
	var noText:Alphabet;

	var song:String;
	var difficulty:Int;
	var week:Int;

	var text:Alphabet = new Alphabet(0, 180, "This mod is not for kids", true, false, 0.05, 0.5);
	var text2:Alphabet = new Alphabet(0, 220, "or those who are easily disturbed.", true, false, 0.05, 0.5);
	// Week -1 = Freeplay
	public function new()
	{
		super();


		FlxG.sound.play(Paths.sound('cancelMenu'), 1);
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);
		text2.screenCenter(X);
		alphabetArray.push(text2);
		text2.alpha = 0;
		add(text2);
		yesText = new Alphabet(0, text2.y + 150, 'Okay', true);
		yesText.screenCenter(X);
		add(yesText);
		updateOptions();
	}

	override function update(elapsed:Float)
	{
		remove(yesText);
		add(yesText);
		remove(text);
		add(text);
		remove(text2);
		add(text2);
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = true;
			updateOptions();
		}
		if(controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		} else if(controls.ACCEPT) {
			if(onYes) {
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
				close();
			}
		}
		super.update(elapsed);
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
	}
}