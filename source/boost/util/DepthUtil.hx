package boost.util;

import flixel.FlxObject;
import flixel.FlxBasic.FlxType;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSort;

class DepthUtil {
	public static function overlap(obj1:FlxObject, obj2:FlxObject):Bool {
		return obj1.z + obj1.depth - 3 > obj2.z && obj2.z + obj2.depth - 3 > obj1.z;
	}

	public static function collisionSolver(obj1:FlxObject, obj2:FlxObject) {
		if (obj1.flixelType == FlxType.OBJECT && obj2.flixelType == FlxType.OBJECT)
			collideObjectWithObject(obj1, obj2);
		else if (obj1.flixelType == FlxType.OBJECT && obj2.flixelType == FlxType.TILEMAP)
			collideSpriteWithTilemap(cast obj1, cast obj2);
		else if (obj1.flixelType == FlxType.TILEMAP && obj2.flixelType == FlxType.OBJECT)
			collideSpriteWithTilemap(cast obj2, cast obj1);
	}

	public static function collideSpriteWithTilemap(sprite:FlxObject, tileMap:FlxTilemap):Bool {
		if (tileMap.overlaps(sprite)) {
			if (sprite.z + sprite.depth - 3 < tileMap.z) {
				return FlxObject.separateZ(tileMap, sprite);
			} else if (sprite.z + sprite.depth >= tileMap.z) {
				return FlxObject.separate(tileMap, sprite);
			}
		}

		return false;
	}

	public static function collideObjectWithObject(obj1:FlxObject, obj2:FlxObject):Bool {
		if (obj1.z + obj1.depth - 3 < obj2.z || obj2.z + obj2.depth - 3 < obj1.z) {
			return FlxObject.separateZ(cast obj2, cast obj1);
		} else if (obj1.z + obj1.depth >= obj2.z) {
			return FlxObject.separate(cast obj2, cast obj1);
		}

		return false;
	}

	public static function stopJitterZ(obj:FlxObject, tm:FlxTilemap, facing:Int = FlxObject.DOWNZ):Void {
		FlxObject.updateTouchingFlagsZ(obj, tm);
		if (obj.isTouching(facing) && Math.abs(obj.velocityZ) < 3) {
			obj.velocityZ = 0;
		}
	}

	public static function sortByRotY(o:Int, o1:FlxObject, o2:FlxObject):Int {
		if (o1.ignoreSprites && o2.ignoreSprites)
			return 0;
		if (o1.ignoreSprites && o2.flixelType == OBJECT)
			return -1;
		if (o2.ignoreSprites && o1.flixelType == OBJECT)
			return 1;
		if (!o1.active || !o2.active)
			return 0;

		var oh = o1.get_d();
		var ah = o2.get_d();

		if (oh == ah)
			return o1.z < o2.z ? 1 : -1;
		return oh > ah ? 1 : -1;
	}

	/**
	 *  An attempt at a topographical sort function, only on object that are colliding to save on resources.
	 */
	public static function sortCollidedZObjects() {}
}
