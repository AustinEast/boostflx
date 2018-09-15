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
 *
 */
class CloudsSprite extends FlxTypedGroup<Cloud> {
	var plane:BSprite;

	public var color:FlxColor;
	public var outer_color:FlxColor;

	public function new(x:Float, y:Float, width:Float, height:Float, color:FlxColor = 0xFF000000, outer_color:FlxColor = 0xFFd9d9d9) {
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

	override public function draw() {
		plane.angle = 0;
		plane.fill(FlxColor.TRANSPARENT);

		forEachAlive((cloud) -> {
			plane.drawCircle(cloud.x + cloud.width / 2, cloud.y + cloud.height / 2 + 1, members[i].width / 2, color);
		});
		plane.draw();
	}
}

class Cloud extends FlxObject {
	var puff_options:PuffOptions;
}

typedef PuffOptions {
	radius:{
		min:Int;
		max:Int;
		speed:Float;
	};
	padding:{
		x:Float;
		y:Float;
	};
	?color:{
		inner:FlxColor;
		outer:FlxColor;
	};
}
