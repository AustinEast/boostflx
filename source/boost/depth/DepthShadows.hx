package boost.depth;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

import boost.BSprite;

using flixel.util.FlxSpriteUtil;

/**
 *  Creates a plane that draws a "Shadow" for each target. 
 *  Not very useful and the ShadowManger class is recommended instead.
 */
class DepthShadows extends FlxTypedGroup<FlxSprite> {

    public var plane:BSprite;
    public var color:Int;

    public function new(_x:Float, _y:Float, _width:Float, _height:Float, _color:Int = 0xFF000000)
	{
		super();

        visible = false;

        plane = new BSprite();
        plane.setPosition(_x, _y);
        plane.moves = false;
        plane.immovable = true;
        plane.ignoreSprites = true;
        plane.allowCollisions = FlxObject.NONE;
        plane.makeGraphic(Std.int(_width), Std.int(_height), FlxColor.TRANSPARENT, true);

        color = _color;
    }

    override public function update(elapsed:Float) {
        plane.angle = 0;
        plane.fill(FlxColor.TRANSPARENT);

        for (i in 0...members.length) {
            if (members[i].exists){
                plane.drawCircle(members[i].x + members[i].width/2, members[i].y + members[i].height/2 + 1, members[i].width/2, color);
            }
        }
    }
}