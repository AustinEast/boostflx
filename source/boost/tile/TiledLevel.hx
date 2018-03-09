package boost.tile;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.addons.editors.tiled.TiledImageTile;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.editors.tiled.TiledTilePropertySet;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.tile.FlxTilemapExt;
import flixel.addons.tile.FlxTileSpecial;
import haxe.io.Path;

import boost.BState;

/**
* ...
* @author Samuel Batista - original author
* @author austineast - edits
**/
class TiledLevel extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/tiled/";
	
	// Array of tilemaps used for collision
	public var foregroundTiles:FlxTypedGroup<FlxTilemapExt>;
	public var backgroundTiles:FlxTypedGroup<FlxTilemapExt>;
	public var collidableTiles:FlxTypedGroup<FlxTilemapExt>;
	
	// Sprites of images layers
	public var imagesLayer:FlxGroup;
	public var objectsLayer:FlxGroup;
	
	public function new(tiledLevel:Dynamic, state:BState)
	{
		super(tiledLevel);
		
		imagesLayer = new FlxGroup();
		objectsLayer = new FlxGroup();

		backgroundTiles = new FlxTypedGroup<FlxTilemapExt>();
		collidableTiles = new FlxTypedGroup<FlxTilemapExt>();
		foregroundTiles = new FlxTypedGroup<FlxTilemapExt>();

		state.add(backgroundTiles);
		state.add(collidableTiles);
		
		loadImages();
		loadObjects(state);

		state.add(foregroundTiles);
		
		// Load Tile Maps
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.TILE) continue;
			var tileLayer:TiledTileLayer = cast layer;
			
			var tileSheetName:String = tileLayer.properties.get("tileset");
            var tileLayerName:String = tileLayer.properties.get("layer");
			
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
            if (tileLayerName == null)
				throw "'layer' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";

			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you misspell the 'tilesheet' property in " + tileLayer.name + "' layer?";
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			// could be a regular FlxTilemap if there are no animated tiles
			var tilemap = new FlxTilemapExt();
			tilemap.loadMapFromArray(tileLayer.tileArray, width, height, processedPath,
				tileSet.tileWidth, tileSet.tileHeight, AUTO, tileSet.firstGID);
			
			if (tileLayer.properties.contains("animated"))
			{
				var tileset = tilesets["level"];
				var specialTiles:Map<Int, TiledTilePropertySet> = new Map();
				for (tileProp in tileset.tileProps)
				{
					if (tileProp != null && tileProp.animationFrames.length > 0)
					{
						specialTiles[tileProp.tileID + tileset.firstGID] = tileProp;
					}
				}
				var tileLayer:TiledTileLayer = cast layer;
				tilemap.setSpecialTiles([
					for (tile in tileLayer.tiles)
						if (tile != null && specialTiles.exists(tile.tileID))
							getAnimatedTile(specialTiles[tile.tileID], tileset)
						else null
				]);
			}
			
			switch (tileLayer.properties.get("layer")) {
				case "fg":
					foregroundTiles.add(tilemap);
				case "bg":
					backgroundTiles.add(tilemap);
				case "collision":
					collidableTiles.add(tilemap);
				default :
					collidableTiles.add(tilemap);
			}
		}
	}

	private function getAnimatedTile(props:TiledTilePropertySet, tileset:TiledTileSet):FlxTileSpecial
	{
		var special = new FlxTileSpecial(1, false, false, 0);
		var n:Int = props.animationFrames.length;
		var offset = Std.random(n);
		special.addAnimation(
			[for (i in 0 ... n) props.animationFrames[(i + offset) % n].tileID + tileset.firstGID],
			(1000 / props.animationFrames[0].duration)
		);
		return special;
	}
	
	public function loadObjects(state:BState)
	{
		var layer:TiledObjectLayer;

		state.add(state.objects);

		for (layer in layers)
		{
			if (layer.type != TiledLayerType.OBJECT)
				continue;
			var objectLayer:TiledObjectLayer = cast layer;

			//collection of images layer
			if (layer.name == "images")
			{
				for (o in objectLayer.objects)
				{
					loadImageObject(o);
				}
			}
			
			//objects layer
			if (layer.name == "objects")
			{
				for (o in objectLayer.objects)
				{
					loadObject(state, o, objectLayer, objectsLayer);
				}
			}
		}
	}
	
	private function loadImageObject(object:TiledObject)
	{
		var tilesImageCollection:TiledTileSet = this.getTileSet("imageCollection");
		var tileImagesSource:TiledImageTile = tilesImageCollection.getImageSourceByGid(object.gid);
		
		//decorative sprites
		var levelsDir:String = "assets/tiled/";
		
		var decoSprite:FlxSprite = new FlxSprite(0, 0, levelsDir + tileImagesSource.source);
		if (decoSprite.width != object.width ||
			decoSprite.height != object.height)
		{
			decoSprite.antialiasing = true;
			decoSprite.setGraphicSize(object.width, object.height);
		}
		decoSprite.setPosition(object.x, object.y - decoSprite.height);
		decoSprite.origin.set(0, decoSprite.height);
		if (object.angle != 0)
		{
			decoSprite.angle = object.angle;
			decoSprite.antialiasing = true;
		}
		
		//Custom Properties
		if (object.properties.contains("depth"))
		{
			var depth = Std.parseFloat( object.properties.get("depth"));
			decoSprite.scrollFactor.set(depth,depth);
		}

		imagesLayer.add(decoSprite);
	}
	
    /**
    * Override this to add in your own objects. There is an example of this in the examples directory.
    **/
	private function loadObject(state:BState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{

	}

	public function loadImages()
	{
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.IMAGE)
				continue;

			var image:TiledImageLayer = cast layer;
			var sprite = new FlxSprite(image.x, image.y, c_PATH_LEVEL_TILESHEETS + image.imagePath);
			imagesLayer.add(sprite);
		}
	}

	public function collideWithLevel(obj:FlxBasic, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTiles != null)
		{
			for (map in collidableTiles.members)
			{
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}
}