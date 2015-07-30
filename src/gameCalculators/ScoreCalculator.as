package gameCalculators 
{
	import gameGlobals.GlobalOptions;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ScoreCalculator 
	{
		public static const SCORE_UPDATED : String = "ScoreUpdatedEvent";
		public static const MULTIPLIER_UPDATED : String = "MultiplierUpdatedEvent";
		
		private static var _scoreMultiplier : int = 1;
		
		public static function bombScoreCalculator(timeToDefuseLeft : int, totalTriesToDefuse : int) : int {
			var score : int = ((Math.round(timeToDefuseLeft / totalTriesToDefuse)) + 1000 + ((timeToDefuseLeft * 0.5) * GlobalOptions.Difficulty)) * _scoreMultiplier; 
			return score;
		}
		
		
		public static function setScoreMultiplier(scoreMulti : int) : void {
			_scoreMultiplier = scoreMulti;
		}
		
		public static function resetScoreMultiplier() : void {
			_scoreMultiplier = 1;
		}
		
		static public function get scoreMultiplier() : int 
		{
			return _scoreMultiplier;
		}
		
	}

}