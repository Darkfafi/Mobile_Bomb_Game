package bomb 
{
	import events.DualIntEvent;
	import events.IntEvent;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import gameCalculators.ScoreCalculator;
	import gameControlEngine.GameObject;
	import gameGlobals.GlobalOptions;
	import ui.NumberPadInterface;
	import utils.HudTextField;
	import utils.HumanTimeConverter;
	//import flash.utils.setInterval;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Bomb extends GameObject
	{
		public static const BOMB_EXPLODE : String = "Bomb_EXPLODE_Event"
		public static const ALL_SLOTS_FILLED_IN : String  = "allSlotsFilledInEvent";
		public static const BOMB_DEFUSED : String = "bombDefusedEvent";
		
		// Display
		private var _bombArt : Sprite = new Sprite();
		private var _slotHolderArt : Sprite = new Sprite();
		private var _defuseSlots : Vector.<DefuseSlot> = new Vector.<DefuseSlot>();	// alleen de slots om in te vullen.
		private var _clockTextField : HudTextField = new HudTextField("",18,0xffffff);
		
		// FUNCTIONS
		private var _timer : Timer;
		private var _waitingForNextTry : Boolean = false;
		private var _currentFilled : int = -1;
		
		//STATS
		private var _bombName : String = "Bomb";
		private var _timeToDefuse : int = 0;
		private var _active : Boolean = false;
		private var _tryCounter : int = 1;
		
		
		public function Bomb(bombSlotsAmount : int) 
		{
			draw();
			_timeToDefuse = (bombSlotsAmount * 10000);
			_timeToDefuse -= (_timeToDefuse * 0.1) * GlobalOptions.Difficulty;
			
			_timer = new Timer(1000, _timeToDefuse / 1000);
			
			_timer.addEventListener(TimerEvent.TIMER, tik);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer);
			
			_clockTextField.changeText(HumanTimeConverter.convert1000SecType(_timeToDefuse));
			_clockTextField.setTextAlign(TextFormatAlign.CENTER);
			
			createSlots(bombSlotsAmount);
		}
		
		private function endTimer(e:TimerEvent):void 
		{
			explode();
		}
		
		private function explode():void 
		{
			_active = false;
			trace("EXPLODE");
		}
		
		private function tik(e:TimerEvent):void 
		{
			_timeToDefuse -= 1000;
			_clockTextField.changeText(HumanTimeConverter.convert1000SecType(_timeToDefuse));
		}
		
		public function activateBomb() : void {
			_active = true;
			_timer.start();
		}
		
		public function enterSlot(guessedInt : int) : void {
			if (_active) {
				_currentFilled ++;
				if(_defuseSlots.length > _currentFilled){
					if(!_defuseSlots[_currentFilled].slotDefused){
						_defuseSlots[_currentFilled].defuseCheck(guessedInt);
						if (_defuseSlots.length - 1 == _currentFilled || checkAllSlotsSolved()) {
							allSlotsFilled();
						}
					}else {
						enterSlot(guessedInt);
					}
				}else {
					allSlotsFilled();
				}
			}
		}
		
		private function createSlots(amount : int):void 
		{
			var slot : DefuseSlot;
			
			for (var i : int = 0; i < amount; i++) {
				slot = new DefuseSlot();
				_defuseSlots.push(slot);
				addChild(slot);
				slot.x = ((_slotHolderArt.width - slot.width) / (amount - 1) * i) + _slotHolderArt.x;
				slot.y = _slotHolderArt.y + (_slotHolderArt.height - slot.height);
			}
		}
		
		private function draw():void 
		{
			_bombArt.graphics.beginFill(0x000000);
			_bombArt.graphics.drawRect(0, 0, 400, 200);
			_bombArt.graphics.endFill();
			
			_slotHolderArt.graphics.beginFill(0x222222);
			_slotHolderArt.graphics.drawRect(0, 0, 300, 150);
			_slotHolderArt.graphics.endFill();
			
			addChild(_bombArt);
			addChild(_slotHolderArt);
			addChild(_clockTextField);
			
			_clockTextField.x = (_bombArt.width / 2) - (_clockTextField.width / 2);
			
			_slotHolderArt.x = (_bombArt.width / 2) - (_slotHolderArt.width / 2);
			_slotHolderArt.y = (_bombArt.height / 2) - (_slotHolderArt.height / 2);
		}
		
		private function allSlotsFilled() : void {
			_active = false;
			if (!checkAllSlotsSolved()) {
				startNextTry();
			}else {
				bombDefused();
			}	
		}
		
		private function bombDefused():void 
		{
			_timer.stop();
			var event : DualIntEvent = new DualIntEvent(BOMB_DEFUSED, _timeToDefuse,_tryCounter, true);
			dispatchEvent(event);
		}
		
		private function startNextTry() : void {
			_tryCounter ++;
			_currentFilled = -1;
			_active = true;
			//for(var i : int = 0; i < _defuseSlots.length; i++){} // on hard difficulty. reset slot text so the user has more difficulty solving them.
		}
		
		private function checkAllSlotsSolved() : Boolean {
			var result : Boolean = false;
			var counter : int = 0;
			for (var i : int = 0; i < _defuseSlots.length; i++) {
				if (_defuseSlots[i].slotDefused) {
					counter ++;
				}
			}
			if (counter == _defuseSlots.length) {
				result = true;
			}
			
			return result;
		}
	}
}