package screens 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ScreenEvent extends Event 
	{
		private var _screen : Screen;
		public function ScreenEvent(type:String,screen : Screen ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_screen = screen;
		}
		
		public function get screen():Screen 
		{
			return _screen;
		}
		
	}

}