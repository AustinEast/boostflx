package boost.system;

typedef EntityData = {
    name: String,
    entityClass: String,
    tag: Int,
    stats: {
		acceleration: {
			x: Float,
			y: Float,
			z: Float
		},
        gravity: {
			x: Float,
			y: Float,
			z: Float
		},
        maxVelocity: {
			x: Float,
			y: Float,
			z: Float
		},
        drag: {
			x: Float,
			y: Float,
			z: Float
		},
        health:Float,
		attack:Float,
		defense:Float
    },
    size: {
        width: Float,
        height: Float,
        depth: Float,
        offset: {
            x: Int,
            y: Int,
			z: Float
        }
    },
    graphic: {
        asset: String,
        animated: Bool,
		billboard: Bool,
        width: Int,
        height: Int,
        sliced:Bool,
        slices: Int,
		sliceOffset: Float
    },
    ?animations: Array<AnimationData>,
	?custom: Dynamic
}

typedef AnimationData = {
    name: String, 
    frames: Array<Int>,
    speed: Int, 
    loop: Bool
}

typedef PointData = {
    position: {
        x: Float,
        y: Float,
        z: Float
    },
    name: String,
    angle: Float,
    controller: Int,
    ?custom: Dynamic
}

typedef LevelData = {
    name: String,
    collision: LayerData,
    layers: Array<LayerData>,
    entities: Array<PointData>,
    widthInTiles: Int,
    heightInTiles: Int,
    tileWidth: Int,
    tileHeight: Int
}

typedef LayerData = {
    name: String,
    data: Array<Int>,
    tileSet: String,
    autoTile: Bool,
    scrollFactor: {
        x: Float,
        y: Float
    }
}