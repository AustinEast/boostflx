package boost.util;

class DataUtil {
	public static inline function new_animation():AnimationData {
		return {
			name: "",
			frames: [],
			speed: 1,
			loop: false
		}
	}

	public static inline function new_entity():EntityData {
		return {
			name: "",
			entityClass: "Entity",
			tag: 0,
			stats: new_stats(),
			size: new_size(),
			graphic: new_graphic(),
			animations: []
		}
	}

	public static inline function new_graphic():GraphicData {
		return {
			asset: "assets/pathto/image.png",
			animated: false,
			billboard: false,
			width: 16,
			height: 16,
			sliced: false,
			sliceOffset: 1,
			slices: 1
		}
	}

	public static inline function new_layer():LayerData {
		return {
			name: "",
			data: [],
			tileSet: "",
			autoTile: false,
			scrollFactor: {
				x: 0,
				y: 0
			}
		}
	}

	public static inline function new_level():LevelData {
		return {
			name: "",
			collision: new_layer(),
			layers: [],
			entities: [],
			widthInTiles: 0,
			heightInTiles: 0,
			tileWidth: 0,
			tileHeight: 0
		}
	}

	public static inline function new_point():PointData {
		return {
			position: Vector3.get(),
			name: "",
			angle: 0,
			controller: 0,
		}
	}

	public static inline function new_size():SizeData {
		return {
			width: 16,
			height: 16,
			depth: 16,
			offset: Vector3.get(),
			origin: {
				x: 0,
				y: 0,
				anchor: false,
				center: false
			}
		}
	}

	public static inline function new_stats():StatsData {
		return {
			speed: Vector3.get(),
			gravity: Vector3.get(),
			maxVelocity: Vector3.get(),
			drag: Vector3.get(),
			health: 10,
			attack: 1,
			defense: 0
		}
	}
}
