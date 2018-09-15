package boost.tools;

import flixel.util.FlxDestroyUtil;
import boost.system.ds.Ring;

class History implements IFlxDestroyable {
	var re:Ring<Array<Action>>;
	var un:Ring<Array<Action>>;

	public function new(len) {
		re = new Ring<Action>(len);
		un = new Ring<Action>(len);
	}

	public function redo():Null<Action> {
		var r = re.pop();
		if (r != null)
			un.push(r);
		return r;
	}

	public function undo():Null<Action> {
		var u = un.pop();
		if (u != null)
			re.push(u);
		return u;
	}

	public function add_multiple(v:Array<Action>) {
		un.concat(v);
		re.reset();
	}

	public function add(v:Action) {
		un.push(v);
		re.reset();
	}

	public function destroy() {
		re.destroy();
		un.destroy();
	}

	public function reset() {
		re.reset();
		un.reset();
	}
}

typedef Action = {
	?data:Dynamic,
	type:String
}
