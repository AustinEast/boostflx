package boost.loaders;

class EntityLoader {

    public static function get_class() {}

    public static function load_from_name(e:Entity, n:String):Null<Entity> {
        var entities = FLS.assets.json.get("assets/data/entities.json");
        for (i in 0...entities.list.length) 
        {
            var ed:EntityData = entities.list[i];
            if (n == ed.name) return update_from_data(e, ed);
        }
        return null;
    }

    public static function load_from_data(e:Entity, d:EntityData):Entity {
        // Clear Child sprites
        if (e.children.length > 0) {
            for (i in 0...e.children.length) {
                e.children[i].kill();
            }
        }
        // Stats
        e.acceleration.set(d.stats.acceleration.x, d.stats.acceleration.y);
        e.accelerationZ = d.stats.acceleration.z;
        e.maxVelocity.set(d.stats.maxVelocity.x, d.stats.maxVelocity.x);
        e.maxVelocityZ = d.stats.maxVelocity.z;
        e.drag.set(d.stats.drag.x, d.stats.drag.y);
        e.dragZ = d.stats.drag.z;
        e.health = d.stats.health;
        e.attack = d.stats.attack;
        e.defense = d.stats.defense;
        // Graphic
        if (d.graphic.sliced) e.loadSlices(d.graphic.asset, d.graphic.slices, d.graphic.width, d.graphic.height);
        else e.loadGraphic(d.graphic.asset, d.graphic.animated, d.graphic.width, d.graphic.height);
        e.billboard = d.stats.billboard;
        e.billboard ? e.anchor_origin() : e.centerOrigin();
        // Size
        e.setSize(d.size.width, d.size.height);
        e.depth = d.size.depth;
        e.offset.set(d.size.offset.x, d.size.offset.y);
        e.offsetZ = d.size.offset.z;
        // Animations
        if (d.animations != null) {
            for (j in 0...d.animations.length) 
            {
                var a = d.animations[j];
                e.animation.add(a.name, a.frames, a.speed, a.loop);
            }
        }
        // Other
        e.angle = 0;
        e.set_facing_flip_horizontal();

        return e;
    }
}