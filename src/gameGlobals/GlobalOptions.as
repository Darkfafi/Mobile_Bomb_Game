package gameGlobals 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GlobalOptions 
	{
		// depending on the difficulty, the score will be more and difficulties will be active; (like defuse time = time - (difficulty * 1000))
		public static const DIFFICULTY_EASY : int = 0;
		public static const DIFFICULTY_NORMAL : int = 1;
		public static const DIFFICULTY_HARD : int = 2;
		public static const DIFFICULTY_VERY_HARD : int = 3;
		public static const DIFFICULTY_IMPOSIBLE : int = 4;  
		
		
		public static var Difficulty : int = DIFFICULTY_EASY;
		
	}

}