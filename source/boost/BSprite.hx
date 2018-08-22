package boost;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flash.display.BitmapData;

import boost.managers.ControlsManager;
import boost.util.Util;

/**
 *  TODO: Move these into an inline-able class
 */
class BSprite extends FlxSprite
{
	public var controller:Controller;
	public var freeze_timer:Float;
	public var jiggle_timer:Float;
	public var accel_amt:Float;

	private var base_bitmap:BitmapData;
	private var flash_bitmaps:Array<BitmapData>;
	
	var flash_colors:Array<FlxColor>;
	var offset_ref:FlxPoint;
	
    public function new(X:Float = 0, Y:Float = 0, ?_flash_colors:Array<FlxColor>)
    {
    	super(X, Y);

		// Init Vars
		if (_flash_colors == null) _flash_colors = [FlxColor.WHITE];
		flash_colors = _flash_colors;
		flash_bitmaps = [];
		freeze_timer = 0;
		accel_amt = 0;
		controller = Controller.NONE;
		offset_ref = FlxPoint.get();
	}

	override public function graphicLoaded()
	{
		for (i in 0...flash_colors.length) {
			flash_bitmaps[i] = graphic.bitmap.clone();
			fillWithColour(flash_bitmaps[i], flash_colors[i]);
		}
		base_bitmap = graphic.bitmap;
	}

	private function fillWithColour(bitmap_data:BitmapData, colour:UInt)
	{
		for (row in 0 ... bitmap_data.height) {
			for (col in 0 ... bitmap_data.width) {
				bitmap_data.setPixel(col, row, colour);
			}
		}
	}

	public function flash(duration:Float = 0.1, color_index:Int = 0)
	{	

		graphic.bitmap = flash_bitmaps[color_index];
		var old_alpha:Float = alpha;
		alpha = 1;
		dirty = true;
		
		new FlxTimer().start(duration, function(timer:FlxTimer) {			
			graphic.bitmap = base_bitmap;
			alpha = old_alpha;
			dirty = true;
		});		
	}

	public function freeze(_duration:Float = 0.1, _force_restart:Bool = true) 
	{
		_force_restart ? freeze_timer = _duration : freeze_timer += _duration;
	}

	public function jiggle(_duration:Float = 0.1, _force_restart:Bool = true) 
	{
		_force_restart ? jiggle_timer = _duration : jiggle_timer += _duration;
	}

	public function make_and_center_hitbox(_width:Float, _height:Float):Void
	{
		offset.set(width * 0.5 - _width * 0.5, height * 0.5 - _height * 0.5);
		setSize(_width, _height);
		offset.copyTo(offset_ref);
	}

	public function make_anchored_hitbox(_width:Float, _height:Float):Void
	{
		offset.set(width * 0.5 - _width * 0.5, height - _height);
		setSize(_width, _height);
		offset.copyTo(offset_ref);
	}
	
	public function set_facing_flip_horizontal(_sprite_facing_right:Bool = true):Void
	{
		setFacingFlip(FlxObject.LEFT, _sprite_facing_right, false);
		setFacingFlip(FlxObject.RIGHT, !_sprite_facing_right, false);
	}
	
	public function get_anchor():FlxPoint
	{
		return FlxPoint.get(x + width * 0.5, y + height);
	}

	public function anchor_origin():Void 
	{
		origin.set(frameWidth * 0.5, frameHeight);
	}

	/*function stop_jitter(_side:Int = FlxObject.Floor, _velocityThreshold:Float = 10) {
        if (this.isTouching(_side)) {
			if (_side == FlxObject.FLOOR || _side == FlxObject.CEILING)
				if(Math.abs(this.velocity.y) < _velocityThreshold) this.velocity.y = 0;
			else if (_side == FlxObject.WALL)
				if(Math.abs(this.velocity.x) < _velocityThreshold) this.velocity.x = 0;
        }
    } */  

	public function move_x_toward(_target:Float, _speed:Float = 5, _threshold:Float = 0):Void {
        if (x >= _target + _threshold) velocity.x -= _speed;
		else if (x < _target - _threshold) velocity.x += _speed;
    }

	public function move_y_toward(_target:Float, _speed:Float = 5, _threshold:Float = 0):Void {
        if (y >= _target + _threshold) velocity.y -= _speed;
        else if (y < _target - _threshold) velocity.y += _speed;
    }

	public function accel_x_toward(_target:Float, _speed:Float = 5, _threshold:Float = 0):Void {
        if (x >= _target + _threshold) acceleration.x -= _speed;
		else if (  x < _target - _threshold) acceleration.x += _speed;
    }

	public function accel_y_toward(_target:Float, _speed:Float = 5, _threshold:Float = 0):Void {
        if (y >= _target + _threshold) acceleration.y -= _speed;
        else if (  y < _target - _threshold) acceleration.y += _speed;
    }

	override public function update(elapsed:Float):Void {
		if (freeze_timer > 0) freeze_timer -= elapsed;

		else {
			super.update(elapsed);
			if (jiggle_timer > 0) {
				jiggle_timer -= elapsed;
				offset.set(offset_ref.x + Util.randomRange(-1, 1), offset_ref.y);
			} else {
				offset.set(offset_ref.x, offset_ref.y);
			}
		}
	}	

}