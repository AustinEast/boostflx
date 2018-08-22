package boost.managers;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

/**
 * Utility class to help create and manage shadows.
 * @author austineast
 */
class ShadowManager extends FlxTypedGroup<Shadow>
{
	
	public function new(amount:Int = 0) 
	{
		super();

        for (i in 0...amount) {
            add(new Shadow());
        }
	}

    public function activate(target:FlxSprite, img:String, img_width:Int, img_height:Int, frame:Int = 0):Shadow
    {
        if (getFirstOpen() != null) return getFirstOpen().activate(target, img, img_width, img_height, frame);
        else return add(new Shadow(target.x, target.y).activate(target, img, img_width, img_height, frame));
    }

    /**
     *  Gets any open Shadow. Useful for when you dont want to activate it right away.
     *  @return Shadow
     */
    public function get():Shadow
    {
        if (getFirstOpen() != null) return getFirstOpen();
        else return add(new Shadow());
    }

    public function getFirstOpen():Shadow
    {
        var i:Int = 0;
		var shadow:Shadow = null;

		while (i < length)
		{
			shadow = members[i++]; // we use basic as FlxBasic for performance reasons
			
			if (shadow != null && !shadow.exists && !shadow.unique)
				return shadow;
		}
		
		return null;
    }
}

class Shadow extends FlxSprite
{
    public var target:Null<FlxSprite>;
	public var targetOffset:FlxPoint;
    public var matchTargetAngle:Bool = true;
    public var matchTargetFrame:Bool = false;
    public var unique:Bool = false;

    public function new(?X:Float, ?Y:Float):Void
    {
        super(X, Y);
        allowCollisions = FlxObject.NONE;
        ignoreSprites = true;
        targetOffset = FlxPoint.get();
        kill();
    }

    public function activate(target:FlxSprite, img:String, img_width:Int, img_height:Int, frame:Int = 0, unique = false):Shadow {
        this.target = target;
        this.unique = unique;
		loadGraphic(img, true, img_width, img_height);
		animation.frameIndex = frame;
		offset.set(img_width/2, img_height/2);
        targetOffset.set();
        var pos = target.getMidpoint();
        reset(pos.x, pos.y);
        
        return this;
    }

    override public function update(elapsed:Float):Void {
        if (target != null && target.exists) {
			var pos = target.getMidpoint();
			setPosition(pos.x + (targetOffset.x * (target.flipX ? -1 : 1)), pos.y + (targetOffset.y * (target.flipY ? -1 : 1)));
			
            if (matchTargetAngle) angle = target.angle;
            if (matchTargetFrame) animation.frameIndex = target.animation.frameIndex;
            visible = target.visible;
		} else kill();
		super.update(elapsed);
    }
}