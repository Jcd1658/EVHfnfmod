package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class GitarooPause extends MusicBeatState
{
    var fileName:String;
	public function new(video:String):Void
	{
        fileName = video;
		super();
	}

	override function create()
	{
        (new FlxVideo(fileName)).finishCallback = function() {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
		super.update(elapsed);
	}
}
