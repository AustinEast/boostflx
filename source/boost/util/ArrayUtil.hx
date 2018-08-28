package boost.util;

class ArrayUtil
{
	public static function make_1D_array(width:Int, height:Int, initalInt:Int = 0):Array<Int>
	{
		return [for (i in 0...width*height) initalInt]; 
	}

	public static function make_2D_array(width:Int, height:Int, initalInt:Int = 0):Array<Array<Int>>
	{
		return [for (i in 0...width) [for (j in 0... height) initalInt]];
	}

	public static function make_outlined_2D_array(width:Int, height:Int, outlinewidth:Int = 1, outlineheight:Int = 1, innerInt:Int = 1, outlineInt = 0):Array<Array<Int>>
	{
		return [for (i in 0... height + outlineheight + outlineheight) [for (j in 0...width + outlinewidth + outlinewidth) (j < outlinewidth || j >= width + outlinewidth || i < outlineheight || i >= height + outlineheight )? outlineInt : innerInt]]; 
	}

	public static function traverse(len:Int, current:Int, ascend:Bool = true):Int {
		current += ascend ? 1 : -1;
		if (current > len - 1) current = 0;
		else if (current < 0) current = len - 1;
		return current;
	}
}