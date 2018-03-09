package boost.util;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

class FlxPointUtil
{

    /**
    * Takes two FlxPoints and finds the Midpoint between them.
    * To get Midpoint for multiple FlxObjects, pass an Array of FlxObjects through `getFlxPointsFromObjects()` then `getOuterMostFlxPoints()` before this.
    * @param    _p1 First Flxpoint.
    * @param    _p2 Second Flxpoint.
    * @param    _offsetX Added offset to the final x of the returned FlxPoint.
    * @param    _offsetY Added offset to the final y of the returned FlxPoint.
    * @return   Midpoint of two Flxpoints.
    **/
    public static function getMidFlxPoint(_p1:FlxPoint, _p2:FlxPoint, _offsetX:Float = 0, _offsetY:Float = 0):FlxPoint
	{
        return FlxPoint.get((_p1.x + _p2.x)/2 + _offsetX, (_p1.y + _p2.y)/2 + _offsetY);
	}

    /**
    * Returns an Array of Flxpoints made up of a group of FlxObjects' positions.
    * @param    _objects FlxTypedGroup<T> of preferably the type `FlxObject` or a child of that type.
    * @return   Array of Flxpoints.
    **/
    public static function getFlxPointsFromObjects(_objects:FlxTypedGroup<Dynamic>):Array<FlxPoint>
    {
        var pointArray:Array<FlxPoint> = new Array<FlxPoint>();

        for (i in 0..._objects.members.length)
        {
            pointArray.push (_objects.members[i].getPosition());
        }
        
        return pointArray;
    }

    /**
    * Finds the outer most bounds from an array of FlxPoints.
    * @param    _points Array of FlxPoints
    * @return   Array of two FlxPoints: The first holding the upper-left bounds, the second holding the lower-right bounds.
    **/
    public static function getOuterMostFlxPoints(_points:Array<FlxPoint>):Array<FlxPoint>
    {
        var upperX:Float = _points[0].x;
		var lowerX:Float = _points[0].x;
		var upperY:Float = _points[0].y;
		var lowerY:Float = _points[0].y;

		for (i in 0..._points.length) {
            if (_points[i].x > upperX) upperX = _points[i].x;
            if (_points[i].x < lowerX) lowerX = _points[i].x;
			if (_points[i].y > upperY) upperY = _points[i].y;
            if (_points[i].y < lowerY) lowerY = _points[i].y;
		}

        var outerPoints:Array<FlxPoint> = new Array<FlxPoint>();
        outerPoints[0] = FlxPoint.get(upperX, upperY);
        outerPoints[1] = FlxPoint.get(lowerX, lowerY);
        return outerPoints;
    }
}