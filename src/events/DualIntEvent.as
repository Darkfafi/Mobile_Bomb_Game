package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DualIntEvent extends Event 
	{
		private var _intOne : int;
		private var _intTwo : int;
		
		public function DualIntEvent(type:String,intOne : int, intTwo : int ,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_intOne = intOne;
			_intTwo = intTwo;
			
		}
		
		public function get intOne():int 
		{
			return _intOne;
		}
		
		public function get intTwo():int 
		{
			return _intTwo;
		}
		
	}

}