package;

import flixel.group.FlxGroup;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;

import boost.tile.TiledLevel;
import boost.managers.ControlsManager;
import boost.BSprite;
import boost.BState;

class ETiledLevel extends TiledLevel
{
    override private function loadObject(state:BState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
        super.loadOject(state, o, g, group);

		var x:Int = o.x;
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;

        var _flipX:String = o.properties.get("flipX");
        if (_flipX == null) throw "'flipX' property not defined for the '" + o.name + "' layer. Please add the property to the layer.";
        
        var controller:String = o.properties.get("controller");
        if (controller == null) throw "'controller' property not defined for the '" + o.name + "' layer. Please add the property to the layer.";

        var parsedFlipX:Bool = false;
        var parsedController:Controller = Controller.NONE;

        switch(_flipX.toLowerCase())
        {
            case "true":
                parsedFlipX = true;
        }

        switch(controller.toLowerCase())
        {
            case "one":
                parsedController = ONE;
            case "two":
                parsedController = TWO;
            case "three":
                parsedController = THREE;
            case "four":
                parsedController = FOUR;
        }

        var sprite:BSprite = new BSprite(parsedController);
        sprite.makeGraphic(g.map.getGidOwner(o.gid).tileWidth, g.map.getGidOwner(o.gid).tileHeight);
        sprite.setPosition(x,y);

        state.objects.add(sprite);		
	}
}