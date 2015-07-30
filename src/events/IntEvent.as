package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class IntEvent extends Event 
	{
		private var _intGiven : int; 
		public function IntEvent(type:String, intToGive : int ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_intGiven = intToGive;
		}
		
		public function get intGiven():int 
		{
			return _intGiven;
		}
		
	}

}