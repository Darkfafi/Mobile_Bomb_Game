package ui 
{
	import events.IntEvent;
	import flash.display.Sprite;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class NumberPadInterface extends GameObject
	{
		public static const NUMPAD_BUTTON_PRESSED : String = "NumPadBUTTONPressed";
		private var _allPadButtons : Vector.<NumberPadButton> = new Vector.<NumberPadButton>();
		
		public function NumberPadInterface() 
		{
			for (var i : int = 0; i < 10; i++) {
				var numButton : NumberPadButton = new NumberPadButton(i, this);
				addChild(numButton);
				numButton.x = i * (numButton.width + 5);
			}
		}
		
		public function numButtonPressed(padNumber:int):void 
		{
			var event : IntEvent = new IntEvent(NUMPAD_BUTTON_PRESSED, padNumber, true);
			dispatchEvent(event);
		}
		
	}

}