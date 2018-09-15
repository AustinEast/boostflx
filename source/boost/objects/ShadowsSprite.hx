package boost.objects;

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
class ShadowsSprite extends FlxTypedGroup<FlxSprite> {
	public var plane:BSprite;
	public var color:Int;

	public function new(x:Float, y:Float, width:Float, height:Float, color:Int = 0xFF000000) {
		super();

		visible = false;

		plane = new BSprite();
		plane.setPosition(x, y);
		plane.moves = false;
		plane.immovable = true;
		plane.ignoreSprites = true;
		plane.allowCollisions = FlxObject.NONE;
		plane.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);

		this.color = color;
	}

	override public function update(elapsed:Float) {
		plane.angle = 0;
		plane.fill(FlxColor.TRANSPARENT);

		for (i in 0...members.length) {
			if (members[i].exists) {
				plane.drawCircle(members[i].x + members[i].width / 2, members[i].y + members[i].height / 2 + 1, members[i].width / 2, color);
			}
		}
	}
}
