package boost.system;

typedef EntityData = {
	name:String,
	entityClass:String,
	tag:Int,
	stats:StatsData,
	size:SizeData,
	graphic:GraphicData,
	?animations:Array<AnimationData>,
	?custom:Dynamic
}

typedef StatsData = {
	speed:VectorData,
	gravity:VectorData,
	maxVelocity:VectorData,
	drag:VectorData,
	health:Float,
	attack:Float,
	defense:Float
}

typedef SizeData = {
	width:Float,
	height:Float,
	depth:Float,
	offset:VectorData,
	origin:{
		anchor:Bool, center:Bool, x:Int, y:Int
	}
}

typedef GraphicData = {
	asset:String,
	animated:Bool,
	billboard:Bool,
	width:Int,
	height:Int,
	sliced:Bool,
	slices:Int,
	sliceOffset:Float
}

typedef AnimationData = {
	name:String,
	frames:Array<Int>,
	speed:Int,
	loop:Bool
}

typedef PointData = {
	position:VectorData,
	name:String,
	angle:Float,
	controller:Int,
	?custom:Dynamic
}

typedef LevelData = {
	name:String,
	collision:LayerData,
	layers:Array<LayerData>,
	entities:Array<PointData>,
	widthInTiles:Int,
	heightInTiles:Int,
	tileWidth:Int,
	tileHeight:Int
}

typedef LayerData = {
	name:String,
	data:Array<Int>,
	tileSet:String,
	autoTile:Bool,
	scrollFactor:{
		x:Float, y:Float
	}
}

typedef VectorData = {
	x:Float,
	y:Float,
	z:Float
}
