package boost.depth;

import flixel.FlxObject;
import flixel.addons.display.FlxNestedSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;

class DepthSprite extends FlxNestedSprite {

    var img_width:Int;
    var img_height:Int;
    var img_offset:Int;

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
        var s:FlxNestedSprite;
        if(overwrite && children[z-1] != null) {
            s = children[z-1];
            s.reset(x,y);
        }
		else s = new FlxNestedSprite(x, y);
        s.relativeZ = -z * img_offset;
        s.z = this.z + s.relativeZ;
        s.solid = false;
        s.camera = camera;
        s.ignoreDrawDebug = true;
        return s;
    }
}