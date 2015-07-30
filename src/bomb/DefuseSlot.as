package bomb 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import gameControlEngine.GameObject;
	import utils.HudTextField;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DefuseSlot extends Sprite
	{
		private var _slotDefused : Boolean = false;
		
		//private var _defuseFeedbackDisplay : Sprite = new Sprite(); 
		
		private var _slotArt : Sprite = new Sprite();
		
		private var _textField : HudTextField = new HudTextField("-",18,0xffffff);
		
		private var _defuseInt : int = 0; // the int that is needed to complete the slot. if higher than 10 then it will generate 2 input slots in 1 slot. 
		
		public function DefuseSlot() 
		{
			_slotArt.graphics.beginFill(0x444444);
			_slotArt.graphics.drawRect(0, 0, 40, 40);
			_slotArt.graphics.endFill();
			
			addChild(_slotArt);
			addChild(_textField);
			
			_textField.setPerfectFitWidth(_slotArt.width);
			_textField.setPerfectFitHeight(_slotArt.height);
			
			_defuseInt = Math.round(Math.random() * 9);
			_textField.setTextAlign(TextFormatAlign.CENTER);
		}
		
		public function resetSlot() : void {
			_textField.changeText("-");
			_textField.changeColor(0xffffff);
		}
		
		public function defuseCheck(givenInt : int) : void {
			
			_textField.changeText(givenInt.toString());
			if (givenInt > _defuseInt) {
				trace("The number is lower than " + givenInt);
				_textField.changeColor(0xff0000);
			}else if (givenInt < _defuseInt) {
				trace("The number is higher than " + givenInt);
				_textField.changeColor(0x0000ff);
			}else {
				trace("Slot defused!");
				_textField.changeColor(0x00ff00);
				_slotDefused = true;
			}
		}
		
		public function get slotDefused():Boolean 
		{
			return _slotDefused;
		}
	}
}