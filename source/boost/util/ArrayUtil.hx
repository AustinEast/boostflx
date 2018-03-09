package boost.util;

class ArrayUtil
{

	public static function make_2D_array(_width:Int, _height:Int, _initalInt:Int = 0):Array<Array<Int>>
	{
		return [for (i in 0..._width) [for (j in 0... _height) _initalInt]]; 
	}

	public static function make_1D_array(_width:Int, _height:Int, _initalInt:Int = 0):Array<Int>
	{
		return [for (i in 0..._width*_height) _initalInt]; 
	}

	public static function make_outlined_2D_array(_width:Int, _height:Int, _outlinewidth:Int = 1, _outlineheight:Int = 1, _innerInt:Int = 1, _outlineInt = 0):Array<Array<Int>>
	{
		return [for (i in 0... _height + _outlineheight + _outlineheight) [for (j in 0..._width + _outlinewidth + _outlinewidth) (j < _outlinewidth || j >= _width + _outlinewidth || i < _outlineheight || i >= _height + _outlineheight )? _outlineInt : _innerInt]]; 
	}
}