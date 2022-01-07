package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class GalleryState extends MusicBeatState
{
	var bg:FlxSprite;
	var nothingtoshow:FlxText;
	var no = new FlxSprite();
	var trolled = new FlxSprite();
	var blackimp:FlxText;
	var curSelected:Int;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		nothingtoshow = new FlxText(100,FlxG.camera.height / 2, 3500, "Press left or right to go through gallery options!");
		add(nothingtoshow);
		nothingtoshow.visible = false;
		blackimp = new FlxText(100,FlxG.camera.height / 2, 3500, "eminem vs black impostor [Press Space to Play]");
		add(blackimp);
		blackimp.visible = false;
		trolled.loadGraphic(Paths.image('trolled'));
		add(trolled);
		trolled.y = FlxG.camera.height / 2 - trolled.height;
		trolled.x = FlxG.camera.width / 2 - trolled.width;
		trolled.visible = false;
		no.loadGraphic(Paths.image('no'));
		add(no);
		no.y = FlxG.camera.height / 2 - no.height;
		no.x = FlxG.camera.width / 2 - no.width;
		no.visible = false;
		blackimp.size = 30;
		nothingtoshow.size = 30;

		super.create();
	}



	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var altupP = controls.UI_LEFT_P;
		var altdownP = controls.UI_RIGHT_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (upP || altupP)
		{
			changeSelection(-shiftMult);
		}
		if (downP || altdownP)
		{
			changeSelection(shiftMult);
		}


		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			//no
		}
		else if(space)
		{
			switch (curSelected) {
				case 0:
					FlxG.sound.play(Paths.sound('cancelMenu'));
				case 1:
					MusicBeatState.switchState(new VideoState("blackimp"));
			}
		}

		else if (accepted)
		{
			switch (curSelected) {
				case 0:
					FlxG.sound.play(Paths.sound('cancelMenu'));
				case 1:
					MusicBeatState.switchState(new VideoState("blackimp"));
			}
		}
		else if(controls.RESET)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		nothingtoshow.visible = false;
		blackimp.visible = false;
		trolled.visible = false;
		no.visible = false;
		switch (curSelected) {
			case 0:
				nothingtoshow.visible = true;
				bg.color = 0xFFBA44F4;
			case 1:
				blackimp.visible = true;
				bg.color = 0xFFBA44F4;
			case 2:
				trolled.visible = true;
				bg.color = 0xFF33384C;
			case 3:
				no.visible = true;
				bg.color = 0xFF22498F;
			}
		super.update(elapsed);
	}



	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = 1;
		if (curSelected >= 4)
			curSelected = 0;
	}

}
