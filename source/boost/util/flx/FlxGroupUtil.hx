package boost.util.flx;

import flixel.FlxBasic;
import flixel.group.FlxGroup;

class FlxGroupUtil
{
    /**
     *  Adds objects from Group 2 into Group 1.
     *  @param group1 - 
     *  @param group2 - 
     */
    public static function addObjects(group1:FlxTypedGroup<FlxBasic>, group2:FlxTypedGroup<FlxBasic>):Void {
		group2.forEach((basic) -> { group1.add(basic); }, true);
	}
}