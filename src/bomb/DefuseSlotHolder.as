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
			for (var i : int = 0; i < amount; i++) {
				var slot : DefuseSlot = new DefuseSlot();
				_allSlots.push(slot);
				addChild(slot);
				slot.x = (amount * (slot.width + 5)) / i;
				slot.y = 10;
			}
		}
		
	}

}