package boost.managers;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxStringUtil;

/**
 * Utility class to help create and manage hitboxes.
 * @author austineast
 */
class HitBoxManager extends FlxTypedGroup<HitBox>
{
	
	public function new(amount:Int = 0) 
	{
		super();

        for (i in 0...amount) {
            add(new HitBox());
        }
	}

    public function activate(_x:Float, _y:Float, _width:Int, height:Int, _parent:Dynamic, _variable:String="", _removeIfTrue:Bool = true)
    {
        if (getFirstOpen() != null) getFirstOpen().activate(_x, _y, _width, height, _parent, _variable, _removeIfTrue);
        else
        {
            var hitbox = new HitBox();
            add(hitbox);
            hitbox.activate(_x, _y, _width, height, _parent, _variable);
        }
    }

    public function get():HitBox
    {
        if (getFirstOpen() != null) return getFirstOpen();
        else
        {
            var hitbox = new HitBox();
            add(hitbox);
            return hitbox;
        }
    }

    public function getFirstOpen():HitBox
    {
        var i:Int = 0;
		var hitbox:HitBox = null;

		while (i < length)
		{
			hitbox = members[i++]; // we use basic as FlxBasic for performance reasons
			
			if (hitbox != null && !hitbox.exists && !hitbox.unique)
				return hitbox;
		}
		
		return null;
    }
}

class HitBox extends FlxObject
{
    @:isVar public var value(get, set):Bool;

    public var positionOffset(default, null):FlxPoint;

    public var parent:Dynamic;
    public var parentVariable:String;
    public var fixedPosition:Bool;
    public var removeIfTrue:Bool;
    public var reviveIfTrue:Bool = false;
    public var unique:Bool = false;

    public function new():Void
    {
        super();
        kill();
    }

    public function activate(_x:Float, _y:Float, _width:Int, _height:Int, _parent:Dynamic, _variable:String="", _removeIfTrue=true):Void
    {
        fixedPosition = true;

        width = _width;
        height = _height;
        parent = _parent;
        parentVariable = _variable;
        reset(_x,_y);
    }

    public function reActivate(_x:Float, _y:Float):Void
    {
        if (!fixedPosition) reset(x, y);
        else reset(_x, _y);
    }

    override public function update(elapsed:Float):Void {
        if (parent != null)
		{
            FlxG.watch.addQuick("reflected value",Reflect.getProperty(parent, parentVariable));
            FlxG.watch.addQuick("value",value);
            var vasl:Bool = Reflect.getProperty(parent, parentVariable);
			if (vasl != value)
			{
				updateValueFromParent();
			}
			
			if (!fixedPosition)
			{
				x = parent.x + positionOffset.x;
				y = parent.y + positionOffset.y;
			}
		}
		
		super.update(elapsed);
    }

    override public function kill():Void
	{
		if (!alive) return;
		
		alive = false;
		solid = false;
	}

    override public function revive():Void
    {
        if(alive) return;
        
        super.revive();
        solid = true;
    }

    public function trackParent(offsetX:Int, offsetY:Int):Void
	{
		fixedPosition = false;
		positionOffset = FlxPoint.get(offsetX, offsetY);
		
		if (Reflect.hasField(parent, "scrollFactor"))
		{
			scrollFactor.x = parent.scrollFactor.x;
			scrollFactor.y = parent.scrollFactor.y;
		}
	}

    override public function toString():String
	{
		return FlxStringUtil.getDebugString([ 
			LabelValuePair.weak("value", value)]);
	}

    private function updateValueFromParent():Void
	{
		value = Reflect.getProperty(parent, parentVariable);
	}

    private function set_value(newValue:Bool):Bool
	{	
        value = newValue;
		if (value == removeIfTrue) kill();
        else if (reviveIfTrue && value != removeIfTrue) revive();
		return newValue;
	}
	
	private function get_value():Bool
	{
		#if neko
		if (value == null) 
		{
			value = !removeIfTrue;
		}
		#end
		
		return value;
	}
}