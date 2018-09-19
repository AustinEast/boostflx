package boost.loaders;

import boost.system.Macros;

class EntityLoader {
	/**
	 * Loads a new Dynamic Class by name, as defined in EntityData's `entityClass` value
	 * Class cannot have any constructor arguments
	 * @param da
	 * @param n
	 * @return <Dynamic>
	 */
	public static function load_new_from_name(da:Array<EntityData>, n:String):Dynamic {
		for (d in da)
			if (n == d.name)
				return load_new(d);
		return null;
	}

	/**
	 * Loads a new Dynamic Class by name, as defined in EntityData's `entityClass` value
	 * Class cannot have any constructor arguments
	 * @param da
	 * @param n
	 * @return <Dynamic>
	 */
	public static function load_new(e:EntityData):Dynamic {
		return Type.createInstance(Type.resolveClass(e.entityClass), []).load_from_data(e);
	}

	public static function load_from_name(e:Entity, da:Array<EntityData>, n:String):Null<Entity> {
		for (d in da)
			if (n == d.name)
				return load_from_data(e, d);
		return null;
	}

	public static function load_from_data(e:Entity, d:EntityData):Entity {
		reset_ext(e);
		load_stats(e, d.stats);
		load_graphic(e, d.graphic);
		load_size(e, d.size);
		if (d.animations != null)
			load_animations(e, d.animations);

		// Apply custom data, if any.
		if (e.load_custom != null)
			e.load_custom(d.custom);

		return e;
	}

	public static function reset_ext(e:Entity):Entity {
		if (e.children.length > 0) {
			for (i in 0...e.children.length) {
				e.children[i].kill();
			}
		}
		e.angle = 0;
		return e;
	}

	public static function load_stats(e:Entity, d:StatsData):Entity {
		e.speed.set(d.speed.x, d.speed.y, d.speed.z);
		e.acceleration.set(d.gravity.x, d.gravity.y);
		e.accelerationZ = d.gravity.z;
		e.maxVelocity.set(d.maxVelocity.x, d.maxVelocity.x);
		e.maxVelocityZ = d.maxVelocity.z;
		e.drag.set(d.drag.x, d.drag.y);
		e.dragZ = d.drag.z;
		e.health = d.health;
		e.attack = d.attack;
		e.defense = d.defense;
		return e;
	}

	public static function load_graphic(e:Entity, d:GraphicData):Entity {
		if (d.sliced)
			e.loadSlices(d.asset, d.slices, d.width, d.height, d.sliceOffset);
		else
			e.loadGraphic(d.asset, d.animated, d.width, d.height);
		e.billboard = d.billboard;
		return e;
	}

	public static function load_size(e:Entity, d:SizeData):Entity {
		e.setSize(d.width, d.height);
		e.depth = d.depth;
		e.offset.set(d.offset.x, d.offset.y);
		e.zOffset = d.offset.z;
		if (d.origin.anchor)
			e.anchor_origin();
		else if (d.origin.center)
			e.centerOrigin();
		else
			e.origin.set(d.origin.x, d.origin.y);
		return e;
	}

	public static function load_animations(e:Entity, d:Array<AnimationData>) {
		for (a in d)
			e.animation.add(a.name, a.frames, a.speed, a.loop);
	}
}
