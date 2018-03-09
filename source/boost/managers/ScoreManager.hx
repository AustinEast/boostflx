package boost.managers;

import flixel.FlxObject;

/**
 * Stores numeric totals and provides helper functions to manipulate the totals.
 * Use `setScore` and `getScore` to add some safety checks to your scoring systems.
 */

class ScoreManager extends FlxObject {

    public function new() 
	{
		super();
	}

	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level. Or store scores between players.
	 */
	public static var scores:Array<Null<Int>> = [];
	/**
	 * Generic high score variables that can be used for cross-state stuff.
     * TODO: Write functions that will auto compare then add high scores and spit out the full list forwards + backwards. Also generic functions that regular scores have.
	 * Example usage: Storing the high score.
	 */
	public static var highScores:Array<Null<Int>> = [];

    // Use in case you need to pause the adding of points (For example, at the end of the round).
	public static var canUpdateScores:Bool = true;

	public static function getScore(n:Int):Int
	{
		if (scores[n] != null)
		{
			return scores[n];
		}
		else 
		{
			throw "score slot " + n + " does not exist.";
			return 0;
		}
	}

	public static function getScoreString(n:Int, appendedZeroes:Int = 0):String
	{
		if (scores[n] != null)
		{
			return StringTools.lpad(Std.string(scores[n]), "0", appendedZeroes);
		}
		else 
		{
			throw "score slot " + n + " does not exist.";
			return "0";
		}
	}

	public static function setScore(_slot:Int, _score:Int, _concat:Bool = false, _overwriteCanUpdate:Bool = false):Void
	{
		if (canUpdateScores || _overwriteCanUpdate)
		{
			if (_concat) {
				scores[_slot] += _score;
			}
			else 
			{
				scores[_slot] = _score;
			}
		} 
	}

	public static function generateScores(n:Int, _clearScores:Bool = false):Void
	{
		if (_clearScores) {
			clearScores();
		}

		for (i in 0...n) 
		{
			scores.push(0);
		}
	}

	public static function clearScores():Void
	{
		scores = [];
	}

	/**
	* Returns an array of the players with the highest score. 
	* @return Returns Array<Int> instead of Int in the case of ties for first.
	**/
	public static function getHighestScorer():Array<Int>
	{
		var highestScore:Int = 0;
		var highestScorer:Array<Int> = [];

		for (i in 0...scores.length)
		{
			if (scores[i] > highestScore)
			{
				highestScorer = [i];
				highestScore = scores[i];
			} 
			else if (scores[i] == highestScore)
			{
				highestScorer.push(i);
			}
		}

		return highestScorer;
	}
	
}