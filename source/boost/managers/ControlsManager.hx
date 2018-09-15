package boost.managers;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

enum Button {
	A;
	B;
	X;
	Y;
	RB;
	LB;
	RT;
	LT;
	UP;
	DOWN;
	LEFT;
	RIGHT;
	START;
	SELECT;
	QUIT;
}

@:enum
abstract Controller(Int) {
	var NONE = 0;
	var ONE = 1;
	var TWO = 2;
	var THREE = 3;
	var FOUR = 4;
}

/**
 * Utility class to help handle multiple control types and players.
 * TODO: Remove hardcoded Button and PlayerController amount, instead calculate it in real time.
 * TODO: Re-Add Touch/Click/Swipe controls.
 * @author austineast
 */
class ControlsManager extends FlxBasic {
	static var MAX_CONTROLLERS:Int = 4;
	static var MAX_BUTTONS:Int = 15;
	static var keyControlsArray:Array<Array<FlxKey>> = [for (x in 0...MAX_BUTTONS)[for (y in 0...MAX_CONTROLLERS) FlxKey.NONE]];
	static var padControlsArray:Array<Array<FlxGamepadInputID>> = [for (x in 0...MAX_BUTTONS)[for (y in 0...MAX_CONTROLLERS) FlxGamepadInputID.NONE]];
	// static var touchControlsArray:Array<Array<FlxKey>> = [for (x in 0...MAX_BUTTONS) [for (y in 0...MAX_CONTROLLERS) null ]];
	static var activeControllers:Array<Bool>;

	public var acceptDeactiveControllerInput:Bool;

	public function new(acceptDeactiveControllerInput:Bool = true, allControllersActive:Bool = false) {
		super();

		setAllActiveControllers(allControllersActive);
		this.acceptDeactiveControllerInput = acceptDeactiveControllerInput;
	}

	public function justPressed(BUTTON:Button, CONTROLLER:Controller):Bool {
		if (!acceptDeactiveControllerInput && !isActiveController(CONTROLLER))
			return false;

		var b = FlxG.keys.anyJustPressed([keyControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);

		if (getPad(CONTROLLER) != null && !b) {
			b = FlxG.gamepads.getByID(controllerToInt(CONTROLLER)).anyJustPressed([padControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);
		}
		return b;
	}

	public function justReleased(BUTTON:Button, CONTROLLER:Controller):Bool {
		if (!acceptDeactiveControllerInput && !isActiveController(CONTROLLER))
			return false;

		var b = FlxG.keys.anyJustReleased([keyControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);

		if (getPad(CONTROLLER) != null && !b) {
			b = FlxG.gamepads.getByID(controllerToInt(CONTROLLER)).anyJustReleased([padControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);
		}
		return b;
	}

	public function pressed(BUTTON:Button, CONTROLLER:Controller):Bool {
		if (!acceptDeactiveControllerInput && !isActiveController(CONTROLLER))
			return false;

		var b = FlxG.keys.anyPressed([keyControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);

		if (getPad(CONTROLLER) != null && !b) {
			b = FlxG.gamepads.getByID(controllerToInt(CONTROLLER)).anyPressed([padControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)]]);
		}
		return b;
	}

	public function anyJustPressed(BUTTON:Button):Bool {
		for (i in 0...MAX_CONTROLLERS) {
			if (justPressed(BUTTON, intToController(i)))
				return true;
		}
		return false;
	}

	public function anyJustReleased(BUTTON:Button):Bool {
		for (i in 0...MAX_CONTROLLERS) {
			if (justReleased(BUTTON, intToController(i)))
				return true;
		}
		return false;
	}

	public function anyPressed(BUTTON:Button):Bool {
		for (i in 0...MAX_CONTROLLERS) {
			if (pressed(BUTTON, intToController(i)))
				return true;
		}
		return false;
	}

	public function clearControlsArrays():Void {
		keyControlsArray = [for (x in 0...MAX_BUTTONS)[for (y in 0...MAX_CONTROLLERS) FlxKey.NONE]];
		padControlsArray = [for (x in 0...MAX_BUTTONS)[for (y in 0...MAX_CONTROLLERS) FlxGamepadInputID.NONE]];
		// touchControlsArray = [for (x in 0...MAX_BUTTONS) [for (y in 0...MAX_CONTROLLERS) null ]];
	}

	public function setKeyControl(BUTTON:Button, CONTROLLER:Controller, INPUT:FlxKey):Void {
		keyControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)] = INPUT;
	}

	public function setPadControl(BUTTON:Button, CONTROLLER:Controller, INPUT:FlxGamepadInputID):Void {
		padControlsArray[buttonToInt(BUTTON)][controllerToInt(CONTROLLER)] = INPUT;
	}

	public function setSwipeControl(BUTTON:Button, CONTROLLER:Controller, INPUT:FlxKey):Void {}

	public function buttonToInt(BUTTON:Button):Int {
		switch (BUTTON) {
			case A:
				return 0;
			case B:
				return 1;
			case X:
				return 2;
			case Y:
				return 3;
			case RB:
				return 4;
			case LB:
				return 5;
			case RT:
				return 6;
			case LT:
				return 7;
			case UP:
				return 8;
			case DOWN:
				return 9;
			case LEFT:
				return 10;
			case RIGHT:
				return 11;
			case SELECT:
				return 12;
			case START:
				return 13;
			case QUIT:
				return 14;
		}
		return 0;
	}

	public function controllerToInt(CONTROLLER:Controller):Int {
		switch (CONTROLLER) {
			case ONE:
				return 0;
			case TWO:
				return 1;
			case THREE:
				return 2;
			case FOUR:
				return 3;
			case NONE:
				return 4;
		}
		return 0;
	}

	public function intToController(INT:Int):Controller {
		switch (INT) {
			case 0:
				return ONE;
			case 1:
				return TWO;
			case 2:
				return THREE;
			case 3:
				return FOUR;
			case 4:
				return NONE;
		}
		return NONE;
	}

	public function getPad(CONTROLLER:Controller):FlxGamepad {
		return FlxG.gamepads.getByID(controllerToInt(CONTROLLER));
	}

	public function setAllActiveControllers(allControllersActive:Bool):Void {
		activeControllers = [for (i in 0...MAX_CONTROLLERS) allControllersActive];
	}

	public function addActiveController(CONTROLLER:Controller):Void {
		activeControllers[controllerToInt(CONTROLLER)] = true;
	}

	public function removeActiveController(CONTROLLER:Controller):Void {
		activeControllers[controllerToInt(CONTROLLER)] = false;
	}

	public function isActiveController(CONTROLLER:Controller):Bool {
		return activeControllers[controllerToInt(CONTROLLER)];
	}

	public function numActiveControllers():Int {
		var n = 0;
		for (i in 0...activeControllers.length) {
			if (activeControllers[i])
				n++;
		}
		return n;
	}
}
