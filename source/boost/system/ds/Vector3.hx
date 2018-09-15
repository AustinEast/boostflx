package boost.system.ds;

import flixel.util.FlxPool;
import flixel.util.FlxPool.IFlxPooled;

class Vector3 implements IFlxPooled {
	public static var pool(get, never):IFlxPool<Vector3>;
	static var _pool = new FlxPool<Vector3>(Vector3);

	public var x:Float;
	public var y:Float;
	public var z:Float;

	var _inPool:Bool = false;

	/**
	 * Recycle or create a new Vector3.
	 * Be sure to put() them back into the pool after you're done with them!
	 *
	 * @param	X		The X-coordinate of the vector in space.
	 * @param	Y		The Y-coordinate of the vector in space.
	 * @param	Z		The Z-coordinate of the vector in space.
	 * @return	This vector.
	 */
	public static inline function get(X:Float = 0, Y:Float = 0, Z:Float = 0):Vector3 {
		var vector = _pool.get().set(X, Y, Z);
		vector._inPool = false;
		return vector;
	}

	@:keep
	public function new(X:Float = 0, Y:Float = 0, Z:Float = 0) {
		set(X, Y, Z);
	}

	/**
	 * Add this Vector3 to the recycling pool.
	 */
	public function put():Void {
		if (!_inPool) {
			_inPool = true;
			_pool.putUnsafe(this);
		}
	}

	/**
	 * Set the coordinates of this vector.
	 *
	 * @param	X	The X-coordinate of the vector in space.
	 * @param	Y	The Y-coordinate of the vector in space.
	 * @param	Z	The Z-coordinate of the vector in space.
	 * @return	This point.
	 */
	public function set(X:Float = 0, Y:Float = 0, Z:Float = 0):Vector3 {
		x = X;
		y = Y;
		z = Z;
		return this;
	}

	/**
	 * Necessary for IFlxDestroyable.
	 */
	public function destroy() {}

	static function get_pool():IFlxPool<Vector3> {
		return _pool;
	}
}
