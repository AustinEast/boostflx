package boost.effects.shaders;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxShader;

class BaseShader extends FlxShader {
	/**
	 * Apply a Shader with custom parameters determined by the Shader.
	 * Override this to apply params to shader
	 * @param sprite Sprite to attach shader
	 * @param params (Optional) Dynamic params used by the shader
	 */
	public function apply(sprite:FlxSprite, ?params:Dynamic) {
		sprite.shader = this;
	}

	/**
	 * Creates an Array of Floats from a FlxColor that matches a Vec4 shader input.
	 * @param color	input FlxColor
	 * @return Array<Float>
	 */
	inline function color_to_vec4(color:FlxColor):Array<Float> {
		return [color.redFloat, color.greenFloat, color.blueFloat, color.alphaFloat];
	}
}
