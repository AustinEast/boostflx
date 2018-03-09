package boost.util;

import flixel.FlxBasic;
import flixel.group.FlxGroup;

class Util
{
    /**
     *  Adds objects from Group 2 into Group 1.
     *  @param group1 - 
     *  @param group2 - 
     */
    public static function addObjects(group1:FlxTypedGroup<FlxBasic>, group2:FlxTypedGroup<FlxBasic>):Void {
		group2.forEach( function(basic){ group1.add(basic); }, true);
	}

    /**
	 * Takes a minimum and maximum Float and returns a random value bewteen them, 
	 * leave blank to return a value between -1 and 1
	 * @param	MIN	Minimum desired result
	 * @param	MAX	Maximum desired result
	 */
	public static function randomRange(?MIN:Float = -1, ?MAX:Float = 1):Float {
		return MIN + Math.random() * (MAX - MIN);
	}

    public static function randomRangeInt(?MIN:Float = -1, ?MAX:Float = 1):Int {
        return Std.int(randomRange(MIN, MAX));
    }

	public static function randomStringInt(_a:Int, _b:Int):String {
        return "" + Math.floor(randomRangeInt(_a,_b));
    }
}