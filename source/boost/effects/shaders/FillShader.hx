package boost.effects.shaders;

import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class FillShader extends BaseShader {
	@:glFragmentSource('
        #pragma header

        uniform vec4 color;
        uniform bool shaderIsActive;

        void main()
        {
            vec4 pixel = flixel_texture2D(bitmap, openfl_TextureCoordv);

            if (!shaderIsActive) {
                gl_FragColor = pixel;
				return;
            }
            
            gl_FragColor = color * pixel.a;

        }')
	public var colors:Array<FlxColor>;

	var flashTimer:FlxTimer;

	public function new(?colors:Array<FlxColor>) {
		super();
		this.shaderIsActive.value = [false];
		if (colors == null)
			this.colors = [FlxColor.WHITE];
		else
			this.colors = colors;
	}

	public function set_color(color:FlxColor) {
		this.color.value = color_to_vec4(color);
	}

	public function flash(time:Float, color_index:Int = 0) {
		this.shaderIsActive.value = [true];
		set_color(colors[color_index]);

		if (flashTimer != null && flashTimer.active)
			flashTimer.reset(time);
		else
			flashTimer = new FlxTimer().start(time, (_) -> this.shaderIsActive.value = [false]);
	}

	public function flicker(time:Float, delay:Float = 0.5, color_index:Int = 0) {}

	public function flash_sequence(color_sequence:Array<Int>, delay:Float) {}
}
