package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class VideoState extends MusicBeatState
{
    var fileName:String;
    var videostarted:Bool = false;
	public function new(video:String):Void
	{
        fileName = Paths.modFolders('videos/' + video + '.' + Paths.VIDEO_EXT);
		super();
	}

	override function create()
	{
        
		super.create();
	}
    override function update(elapsed:Float)
        {
            if (fileName != null) {
                if (!videostarted) {
                    videostarted = true;
                    (new FlxVideo(fileName)).finishCallback = function() {
                    FlxG.sound.playMusic(Paths.music('freakyMenu'));
                    MusicBeatState.switchState(new GalleryState());
                    }
                }
            }
            super.update(elapsed);
        }
}
