package utils 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HumanTimeConverter 
	{
		
		public static function convert1000SecType(time : int) : String {
			//var hourCounter : int = 0;
			var minuteCounter : int = 0;
			var secondsCounter : int = 0;
			
			/*
			while (time >= (3600 * 1000)) {
				time -= (3600 * 1000);
				hourCounter ++;
			}*/
			while(time >= (60 * 1000)) {
				time -= (60 * 1000);
				minuteCounter ++;
			}
			while (time >= 1000) {
				time -= 1000;
				secondsCounter ++;
			}
			return convertionToString(secondsCounter, minuteCounter);
		}
		
		private static function convertionToString(secCounter : int, minCounter : int) : String {
			
			var timeString : String = "";
			
			if (minCounter < 10) {
				timeString += "0";
			}
			timeString += minCounter.toString() + ":";
			
			if (secCounter < 10) {
				timeString += "0";
			}
			timeString += secCounter.toString();
			
			return timeString;
		}
		
	}

}