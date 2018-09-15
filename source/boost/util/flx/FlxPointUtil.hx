package boost.util.flx;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

class FlxPointUtil {
	/**
	 * Takes two FlxPoints and finds the Midpoint between them.
	 * To get Midpoint for multiple FlxObjects, pass an Array of FlxObjects through `getFlxPointsFromObjects()` then `getOuterMostFlxPoints()` before this.
	 * @param    p1 First Flxpoint.
	 * @param    p2 Second Flxpoint.
	 * @param    offsetX Added offset to the final x of the returned FlxPoint.
	 * @param    offsetY Added offset to the final y of the returned FlxPoint.
	 * @return   Midpoint of two Flxpoints.
	**/
	public static function getMidFlxPoint(p1:FlxPoint, p2:FlxPoint, offsetX:Float = 0, offsetY:Float = 0):FlxPoint {
		return FlxPoint.get((p1.x + p2.x) / 2 + offsetX, (p1.y + p2.y) / 2 + offsetY);
	}

	/**
	 * Returns an Array of Flxpoints made up of a group of FlxObjects' positions.
	 * @param    objects FlxTypedGroup<T> of preferably the type `FlxObject` or a child of that type.
	 * @return   Array of Flxpoints.
	**/
	public static function getFlxPointsFromObjects(objects:FlxTypedGroup<Dynamic>):Array<FlxPoint> {
		var pointArray:Array<FlxPoint> = new Array<FlxPoint>();

		for (i in 0...objects.members.length) {
			pointArray.push(objects.members[i].getPosition());
		}

		return pointArray;
	}

	/**
	 * Finds the outer most bounds from an array of FlxPoints.
	 * @param    points Array of FlxPoints
	 * @return   Array of two FlxPoints: The first holding the upper-left bounds, the second holding the lower-right bounds.
	**/
	public static function getOuterMostFlxPoints(points:Array<FlxPoint>):Array<FlxPoint> {
		var upperX:Float = points[0].x;
		var lowerX:Float = points[0].x;
		var upperY:Float = points[0].y;
		var lowerY:Float = points[0].y;

		for (i in 0...points.length) {
			if (points[i].x > upperX)
				upperX = points[i].x;
			if (points[i].x < lowerX)
				lowerX = points[i].x;
			if (points[i].y > upperY)
				upperY = points[i].y;
			if (points[i].y < lowerY)
				lowerY = points[i].y;
		}

		var outerPoints:Array<FlxPoint> = new Array<FlxPoint>();
		outerPoints[0] = FlxPoint.get(upperX, upperY);
		outerPoints[1] = FlxPoint.get(lowerX, lowerY);
		return outerPoints;
	}
}
