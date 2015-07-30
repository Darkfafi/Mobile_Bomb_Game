package screens 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class StringScreenEvent extends Event 
	{
		private var _screenName : String = "";
		
		public function StringScreenEvent(type:String,screenName : String ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_screenName = screenName;
		}
		
		public function get screenName():String 
		{
			return _screenName;
		}
		
	}

}