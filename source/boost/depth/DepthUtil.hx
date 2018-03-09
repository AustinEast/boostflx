package boost.depth;

import flixel.FlxObject;
import flixel.FlxBasic.FlxType;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSort;

class DepthUtil {

    public static function overlap(_obj1:FlxObject, _obj2:FlxObject):Bool
    {
        return _obj1.z + _obj1.depth - 3 > _obj2.z && _obj2.z + _obj2.depth - 3 > _obj1.z;
    }

    public static function collisionSolver(_obj1:FlxObject, _obj2:FlxObject)
	{
		if (_obj1.flixelType == FlxType.OBJECT && _obj2.flixelType == FlxType.OBJECT) collideObjectWithObject(_obj1, _obj2);
		else if (_obj1.flixelType == FlxType.OBJECT && _obj2.flixelType == FlxType.TILEMAP) collideSpriteWithTilemap(cast _obj1, cast _obj2);
		else if (_obj1.flixelType == FlxType.TILEMAP && _obj2.flixelType == FlxType.OBJECT) collideSpriteWithTilemap(cast _obj2, cast _obj1);
	}

	public static function collideSpriteWithTilemap (_sprite:FlxObject, _tileMap:FlxTilemap):Bool
	{
		if(_tileMap.overlaps(_sprite)) {
			if (_sprite.z + _sprite.depth - 3 < _tileMap.z) 
			{
				return FlxObject.separateZ(_tileMap, _sprite);
			}
			else if (_sprite.z + _sprite.depth >= _tileMap.z) 
			{
				return FlxObject.separate(_tileMap, _sprite);
			} 
		}

		return false;
	}

	public static function collideObjectWithObject (_obj1:FlxObject, _obj2:FlxObject):Bool
	{
		if (_obj1.z + _obj1.depth - 3 < _obj2.z || _obj2.z + _obj2.depth - 3 < _obj1.z) 
		{
			return FlxObject.separateZ(cast _obj2, cast _obj1);
		}
		else if (_obj1.z + _obj1.depth >= _obj2.z) 
		{
			return FlxObject.separate(cast _obj2, cast _obj1);
		} 

		return false;
	}

	public static function stopJitterZ (_obj:FlxObject, _tm:FlxTilemap, _facing:Int = FlxObject.DOWNZ):Void
	{
		FlxObject.updateTouchingFlagsZ(_obj, _tm);
		if (_obj.isTouching(_facing) && Math.abs(_obj.velocityZ) < 3) {
			_obj.velocityZ = 0;
		}
	}

    public static function sortByZ(Order:Int, Obj1:Dynamic, Obj2:Dynamic):Int
	{
		// TODO: MAKE THIS ACTUALLY SORT BY Z LMAO
		return FlxSort.byY(Order, Obj1, Obj2);
	}
	/**
	 *  An attempt at a topographical sort function, only on object that are colliding to save on resources.
	 */
	public static function sortCollidedZObjects() {

	}
}