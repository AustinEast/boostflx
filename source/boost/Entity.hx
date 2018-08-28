package boost;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxAssets;
import flash.display.BitmapData;

import boost.managers.ControlsManager;
import boost.system.BaseSprite;
import boost.util.RandomUtil;

/**
 *  TODO: Move these into an inline-able class
 */
class Entity extends BaseSprite
{
	public var controller:Controller;

	public var billboard:Bool;

	public var freeze_timer:Float;
	public var jiggle_timer:Float;

	private var base_bitmap:BitmapData;
	private var flash_bitmaps:Array<BitmapData>;
	private var flash_colors:Array<FlxColor>;
	
	var offset_ref:FlxPoint;
	
    public function new(X:Float = 0, Y:Float = 0, ?flash_colors:Array<FlxColor>)
    {
    	super(X, Y);

		// Init Vars
		if (flash_colors == null) flash_colors = [FlxColor.WHITE];
		this.flash_colors = flash_colors;
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

	public function freeze(duration:Float = 0.1, force_restart:Bool = true) 
	{
		force_restart ? freeze_timer = duration : freeze_timer += duration;
	}

	public function jiggle(duration:Float = 0.1, force_restart:Bool = true) 
	{
		force_restart ? jiggle_timer = duration : jiggle_timer += duration;
	}
	
	public function get_anchor():FlxPoint
	{
		return FlxPoint.get(x + width * 0.5, y + height);
	}

	public function anchor_origin():Void 
	{
		origin.set(frameWidth * 0.5, frameHeight);
	}

	/*function stop_jitter(side:Int = FlxObject.Floor, velocityThreshold:Float = 10) {
        if (this.isTouching(side)) {
			if (side == FlxObject.FLOOR || side == FlxObject.CEILING)
				if(Math.abs(this.velocity.y) < velocityThreshold) this.velocity.y = 0;
			else if (side == FlxObject.WALL)
				if(Math.abs(this.velocity.x) < velocityThreshold) this.velocity.x = 0;
        }
    } */  

	public function move_x_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
        if (x >= target + threshold) velocity.x -= speed;
		else if (x < target - threshold) velocity.x += speed;
    }

	public function move_y_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
        if (y >= target + threshold) velocity.y -= speed;
        else if (y < target - threshold) velocity.y += speed;
    }

	public function accel_x_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
        if (x >= target + threshold) acceleration.x -= speed;
		else if (  x < target - threshold) acceleration.x += speed;
    }

	public function accel_y_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
        if (y >= target + threshold) acceleration.y -= speed;
        else if (  y < target - threshold) acceleration.y += speed;
    }

	override public function update(elapsed:Float):Void {
		if (freeze_timer > 0) freeze_timer -= elapsed;

		else {
			super.update(elapsed);
			if (jiggle_timer > 0) {
				jiggle_timer -= elapsed;
				offset.set(offset_ref.x + RandomUtil.range(-1, 1), offset_ref.y);
			} else {
				offset.set(offset_ref.x, offset_ref.y);
			}
		}
	}

	//--------------------//
	// 3D Slice Functions //
	//--------------------//
	
	public function loadSlices(img:FlxGraphicAsset, slices:Int, img_width:Int, img_height:Int, img_offset:Int = 1, overwrite:Bool = true) {
        this.img_width = img_width;
        this.img_height = img_height;
        this.img_offset = img_offset;
        
        if(graphic == null || overwrite) loadGraphic(img, true, img_width, img_height);
        for (i in 1...slices) loadSlice(img, i, i, overwrite);
    }

    public function makeSlices(color:FlxColor = FlxColor.WHITE, slices:Int, img_width:Int, img_height:Int, img_offset:Int = 1, overwrite:Bool = true) {
        this.img_width = img_width;
        this.img_height = img_height;
        this.img_offset = img_offset;
        
        if(graphic == null) makeGraphic(img_width, img_height, color);
        for (i in 1...slices + 1) makeSlice(color, i);
    }

    public function loadSlice(img:FlxGraphicAsset, z:Int, frame:Int = 0, overwrite:Bool = true) {
        var s = getSlice(z, overwrite);
		s.loadGraphic(img, true, img_width, img_height);
		s.animation.frameIndex = frame;
		add(s);
	}

    public function makeSlice(color:FlxColor = FlxColor.WHITE, z:Int, overwrite:Bool = true) {
		var s = getSlice(z, overwrite);
		s.makeGraphic(img_width, img_height, color);
		add(s);
	}

    function getSlice(z:Int, overwrite:Bool = true):FlxNestedSprite {
        var s:BaseSprite;
        if(overwrite && children[z-1] != null) {
            s = children[z-1];
            s.reset(x,y);
        }
		else s = new BaseSprite(x, y);
        s.relativeZ = -z * img_offset;
        s.z = this.z + s.relativeZ;
        s.solid = false;
        s.camera = camera;
        s.ignoreDrawDebug = true;
        return s;
    }

}
