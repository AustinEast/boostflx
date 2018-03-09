package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;

import boost.managers.ControlsManager;

/**
 * Example class to assign keyboard and gamepad controls for a simple singleplayer game.
 * @author austineast
 */
class EBindings extends FlxObject
{
	public function new (_controllerManager:ControlsManager) 
    {
        super();
        init(_controllerManager);
    }

    function init(_controllerManager:ControlsManager):Void
    {
        _controllerManager.clearControlsArrays();

        // Set Player One Controls
        _controllerManager.setKeyControl(Button.A,Controller.ONE,FlxKey.X);
        _controllerManager.setKeyControl(Button.B,Controller.ONE,FlxKey.C);
        _controllerManager.setKeyControl(Button.UP,Controller.ONE,FlxKey.UP);
        _controllerManager.setKeyControl(Button.DOWN,Controller.ONE,FlxKey.DOWN);
        _controllerManager.setKeyControl(Button.LEFT,Controller.ONE,FlxKey.LEFT);
        _controllerManager.setKeyControl(Button.RIGHT,Controller.ONE,FlxKey.RIGHT);
        _controllerManager.setKeyControl(Button.START,Controller.ONE,FlxKey.ENTER);
        _controllerManager.setKeyControl(Button.QUIT,Controller.ONE,FlxKey.ESCAPE);
        
        _controllerManager.setPadControl(Button.A,Controller.ONE,FlxGamepadInputID.A);
        _controllerManager.setPadControl(Button.B,Controller.ONE,FlxGamepadInputID.B);
        _controllerManager.setPadControl(Button.UP,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_UP);
        _controllerManager.setPadControl(Button.DOWN,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_DOWN);
        _controllerManager.setPadControl(Button.LEFT,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_LEFT);
        _controllerManager.setPadControl(Button.RIGHT,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_RIGHT);
        _controllerManager.setPadControl(Button.START,Controller.ONE,FlxGamepadInputID.START);

    }
}