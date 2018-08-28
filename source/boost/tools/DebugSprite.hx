package boost.tools;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class DebugSprite extends FlxSprite
{
	public var lineStyle:LineStyle = { color: FlxColor.RED, thickness: 1 };
	public var drawStyle:DrawStyle = { smoothing: true };

    override public function new():Void 
	{		
        super();
		makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
		scrollFactor.set(0,0);
        
	}
	
	override public function update(elapsed:Float):Void 
	{
        fill(FlxColor.TRANSPARENT);
		super.update(elapsed);
	}
}