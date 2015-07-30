package screens.gameScreens 
{
	import bomb.Bomb;
	import events.DualIntEvent;
	import events.IntEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameCalculators.ScoreCalculator;
	import screens.Screen;
	import ui.InGameScoreInterface;
	import ui.NumberPadInterface;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameScreen extends Screen 
	{	
		private var _numberPadInterface : NumberPadInterface = new NumberPadInterface();
		
		private var _defuseStreak : int = 0;
		private var _score : int = 0;
		
		private var _oldBomb : Bomb;
		private var _currentBomb : Bomb;
		
		private var _moveNewBomb : Boolean = false;
		private var _removeMoveOldBomb : Boolean = false;
		
		public function GameScreen() 
		{
			super();
		}
		
		override public function update():void 
		{
			super.update();
			if (_moveNewBomb) {
				_currentBomb.x -= 15 * (_defuseStreak * 0.2 + 1);
				if (_currentBomb.x <= (stage.stageWidth / 2) - (_currentBomb.width / 2)) {
					_moveNewBomb = false;
					_currentBomb.x = (stage.stageWidth / 2) - (_currentBomb.width / 2);
					_currentBomb.activateBomb();
				}
			}
			
			if (_removeMoveOldBomb) {
				_oldBomb.x -= 15 * (_defuseStreak * 0.2 + 1);
				if (_currentBomb.x <= 0 - (_currentBomb.width / 2)) {
					_removeMoveOldBomb = false;
					_oldBomb.destroy();
				}
			}
		}
		
		private function addNewBomb() : void {
			var newBomb : Bomb = new Bomb(2 + Math.round(_defuseStreak * 0.1));
			addChild(newBomb);
			newBomb.x = stage.stageWidth + newBomb.width;
			newBomb.y = (stage.stageHeight / 2) - newBomb.height / 2;
			_currentBomb = newBomb;
			_moveNewBomb = true;
		}
		
		private function removeCurrentBomb() : void {
			_oldBomb = _currentBomb;
			_removeMoveOldBomb = true;
		}
		
		override protected function onScreenAdded():void 
		{
			super.onScreenAdded();
			
			stage.addEventListener(NumberPadInterface.NUMPAD_BUTTON_PRESSED, onPadButtonPressed);
			stage.addEventListener(Bomb.BOMB_DEFUSED, bombDefused);
			
			graphics.beginFill(0xff00ff);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			addNewBomb(); // kind of a test. first show tutorial screen. When player taps on it. It will be removed and the game will begin. with a flashy countdown maybe.
			
			addUI();
		}
		
		private function bombDefused(e:DualIntEvent):void 
		{	
			_score += ScoreCalculator.bombScoreCalculator(e.intOne, e.intTwo);
			
			var scoreEvent : IntEvent = new IntEvent(ScoreCalculator.SCORE_UPDATED, _score, true);
			dispatchEvent(scoreEvent);
			
			_defuseStreak ++; //die word via de ui geregelt door manualy de event te pakken met bombDefused en een counter zelf bij te houden.
			
			if (_defuseStreak % 1 == 0) {
				var newMultiplier : int = ScoreCalculator.scoreMultiplier + 1;
				ScoreCalculator.setScoreMultiplier(newMultiplier);
				
				var event : IntEvent = new IntEvent(ScoreCalculator.MULTIPLIER_UPDATED, newMultiplier, true);
				dispatchEvent(event);
				
			}
			
			removeCurrentBomb();
			addNewBomb();
			
			trace(_score + " , " + ScoreCalculator.scoreMultiplier);
		}
		
		private function onPadButtonPressed(e:IntEvent):void 
		{
			_currentBomb.enterSlot(e.intGiven);
		}
		
		private function addUI():void 
		{
			var scoreUI : InGameScoreInterface = new InGameScoreInterface();
			
			_numberPadInterface.x = (stage.stageWidth / 2) - _numberPadInterface.width / 2;
			_numberPadInterface.y = stage.stageHeight - _numberPadInterface.height / 2;
			//stage.addChild(_numberPadInterface);
			addChild(_numberPadInterface);
			addChild(scoreUI);
		}
		
		override public function destroy():void 
		{
			
			stage.removeEventListener(NumberPadInterface.NUMPAD_BUTTON_PRESSED, onPadButtonPressed);
			stage.removeEventListener(Bomb.BOMB_DEFUSED, bombDefused);
			
			super.destroy();
		}
	}
}