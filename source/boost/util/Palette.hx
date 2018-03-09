package boost;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.geom.Point;
import openfl.system.System;
import openfl.display.BitmapData;
import openfl.filters.ColorMatrixFilter;

using flixel.util.FlxSpriteUtil;

/**
 *  Based on Will Blanton's implementations of Palette Swapping
 */
class Palette
{	
	private static var colorPalette:Array<Array<Int>>;
			
	function set_colors(colors:Array<Int>):Void
	{
		colorPalette = new Array();
		for (i in 0...4) colorPalette.push(new Array<Int>());
		for (i in 0...256) 
		{
			var c = colors[Math.floor(i / (256 / colors.length))];
			colorPalette[0].push(c & 0xFF0000);
			colorPalette[1].push(c & 0x00FF00);
			colorPalette[2].push(c & 0x0000FF);
		}
	}
	
	var b:Float = 0.3;
	
	public static function map():Void
	{
		#if web
		if (colorPalette != null) {
			var pnt = new Point();
			var matrix = 
			[
				b, b, b, 0, 0,
				b, b, b, 0, 0,
				b, b, b, 0, 0,
				0, 0, 0, 1, 0
			];
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			FlxG.camera.buffer.applyFilter(FlxG.camera.buffer, FlxG.camera.buffer.rect, pnt, filter);
			FlxG.camera.buffer.paletteMap(FlxG.camera.buffer, FlxG.camera.buffer.rect, pnt, colorPalette[0], colorPalette[1], colorPalette[2]);
		}
		#end
	}
	
	function paletteMapFade(FROM:Float, TO:Float, TIME:Float):Void
	{
		b = FROM;
		FlxTween.tween(this, { b:TO }, TIME);
	}
	
	public function flash(FROM:Float = 1, TIME:Float = 0.25):Void
	{
		#if flash
		paletteMapFade(FROM, 0.3, TIME);
		#end
	}
	
	public function fade(TO:Float = 0, TIME:Float = 1):Void
	{
		#if flash
		paletteMapFade(0.3, TO, TIME);
		#end
	}
}