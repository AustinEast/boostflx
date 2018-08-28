

class DataUtil {

    public static function new_animation():AnimationData {
        return {
            name: "",
            frames: [],
            speed: 1,
            loop: false
        }
    }

    public static function new_entity():EntityData {
        return {
            name: "",
            entityClass: "Entity",
            tag: 0,
            stats: {
                acceleration: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                gravity: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                maxVelocity: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                drag: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                health:10,
                attack:1,
                defense:0
            },
            size: {
                width: 16,
                height: 16,
                depth: 16,
                offset: {
                    x: 0,
                    y: 0
                }
            },
            graphic: {
                asset: "assets/pathto/image.png",
                animated: false,
                billboard: false,
                width: 16,
                height: 16,
                sliced: false,
                slices: 1
            },
            animations: []
        }
    }

    public static function new_layer():LayerData {
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
    
    public static function new_level():LevelData {
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

    public static function new_point():PointData {
        return {
            position: {
                x: 0,
                y: 0,
                z: 0
            },
            name: "",
            angle: 0,
            controller: 0,
        }
    }
}