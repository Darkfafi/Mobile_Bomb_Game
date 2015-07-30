package bomb 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class DefuseSlotHolder extends Sprite
	{
		private var _slotHolderArt : Sprite = new Sprite();
		private var _allSlots : Vector.<DefuseSlot> = new Vector.<DefuseSlot>();
		
		public function DefuseSlotHolder(amountOfSlots : int) 
		{
			createSlots(amountOfSlots);
			
		}
		
		private function createSlots(amount:int):void 
		{
			addChild(_slotHolderArt);
			var slot : DefuseSlot;
			for (var i : int = 0; i < amount; i++) {
				slot = new DefuseSlot();
				_allSlots.push(slot);
				addChild(slot);
				var wd : Number = (amount * (slot.width + 5));
				slot.x = wd - (wd / 2) - (((slot.width) * amount) / 2) + ((slot.width + 5) * i); //Goede formule voor positie.
				slot.y = 5;
			}
			
			_slotHolderArt.graphics.beginFill(0xff5555);
			_slotHolderArt.graphics.drawRect(0, 0, amount * (slot.width  + 8.5), slot.height + 10);
			_slotHolderArt.graphics.endFill();
		}
		
	}

}