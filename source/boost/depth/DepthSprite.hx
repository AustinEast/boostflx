package boost.depth;

import flixel.addons.display.FlxNestedSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class DepthSprite extends FlxNestedSprite {

    var img_width:Int;
    var img_height:Int;
    var img_offset:Int;

    public function loadSlices(img:String, slices:Int, img_width:Int, img_height:Int, img_offset:Int = 0) {
        this.img_width = img_width;
        this.img_height = img_height;
        this.img_offset = img_offset;
        
        if(graphic == null) loadGraphic(img, true, img_width, img_height);
        for (i in 1...slices) loadSlice(img, i, i);
    }

    public function makeSlices(color:FlxColor = FlxColor.WHITE, slices:Int, img_width:Int, img_height:Int, img_offset:Int = 0) {
        this.img_width = img_width;
        this.img_height = img_height;
        this.img_offset = img_offset;
        
        if(graphic == null) makeGraphic(img_width, img_height, color);
        for (i in 1...slices) makeSlice(color, i);
    }

    public function loadSlice(img:String, z:Int, frame:Int = 0) {
		var s = new FlxNestedSprite();
        s.relativeZ = -z - img_offset + 1;
		s.loadGraphic(img, true, img_width, img_height);
		s.animation.frameIndex = frame;
		add(s);
	}

    public function makeSlice(color:FlxColor = FlxColor.WHITE, z:Int) {
		var s = new FlxNestedSprite();
        s.relativeZ = -z - img_offset + 1;
		s.makeGraphic(img_width, img_height, color);
		add(s);
	}
}