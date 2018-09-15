package boost.objects;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import boost.Entity;

class Particles extends FlxTypedGroup<Particle> {
	public var colors:Array<Int>;
	public var emitters:Array<Void>;

	public function new(?colors:Array<Int>) {
		super();

		// exists = false;

		if (colors == null)
			colors = [0xffffff];
		this.colors = colors;
	}

	public function add_amount(amt:Int) {
		// Extend this function to create your particle like so:

		// for (i in 0...amt)
		//	add(new Particle(colors[RandomUtil.range_int(0, colors.length - 1)]));
	}

	public function fire(p:FlxPoint, v:FlxPoint, ?anim:String, ?midpoint:Bool = false):Null<Particle> {
		if (getFirstAvailable() != null)
			return getFirstAvailable().fire(p, v, anim, midpoint);
		else
			return null;
	}
}

class Particle extends Entity {
	public function new(color:Int) {
		super();
		exists = false;
		this.color = color;
	}

	public function fire(p:FlxPoint, v:FlxPoint, ?anim:String, ?midpoint:Bool = false):Particle {
		if (midpoint)
			reset(p.x - width / 2, p.y - height / 2);
		else
			reset(p.x, p.y);
		velocity.set(v.x, v.y);
		if (anim != null)
			animation.play(anim);
		return this;
	}
}
