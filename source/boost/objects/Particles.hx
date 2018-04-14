package boost.objects;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import boost.BSprite;
import boost.util.Util;

class Particles extends FlxTypedGroup<Particle>
{

    public var colors:Array<Int>;
	
	public function new(?_colors:Array<Int>)
	{
		super();

		exists = false;
		
        if (_colors == null) _colors = [0xffffff];
        colors = _colors;
	}

    public function add_amount(_amt:Int) {
        // Extend this function to create your particle like so:
        
        //for (i in 0..._amt)
		//	add(new Particle(colors[Util.randomRangeInt(0, colors.length - 1)]));
    }
	
	public function fire(_p:FlxPoint, _v:FlxPoint, ?_anim:String, ?_midpoint:Bool = false):Void
	{
		if (getFirstAvailable() != null)
			getFirstAvailable().fire(_p, _v, _anim, _midpoint);
	}
	
}

class Particle extends BSprite
{
	
	public function new(_color:Int)
	{
		super();
		exists = false;
		color = _color;
	}
	
	public function fire(_p:FlxPoint, _v:FlxPoint, ?_anim:String, ?_midpoint:Bool = false):Void
	{
        if (_midpoint) reset(_p.x - width/2, _p.y - height/2);
        else reset(_p.x, _p.y);
		velocity.set(_v.x, _v.y);
        if (_anim != null)
		    animation.play(_anim);
	}
}