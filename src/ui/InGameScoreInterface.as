package ui 
{
	import events.IntEvent;
	import flash.events.Event;
	import gameCalculators.ScoreCalculator;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import utils.HudTextField;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class InGameScoreInterface extends GameObject 
	{
		
		private var _currentScoreData : int = 0;
		private var _goalScoreData : int = 0;
		
		private var _scoreDisplayText : HudTextField = new HudTextField("SCORE: 0");
		private var _multiplierDisplayText : HudTextField = new HudTextField();
		
		public function InGameScoreInterface() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(ScoreCalculator.SCORE_UPDATED, scoreUpdate);
			stage.addEventListener(ScoreCalculator.MULTIPLIER_UPDATED, multiplierUpdate);
			
			_multiplierDisplayText.x = 20;
			
			addChild(_multiplierDisplayText);
			addChild(_scoreDisplayText);
			
			//_scoreDisplayText.x = 100;
		}
		
		private function multiplierUpdate(e:IntEvent):void 
		{
			_multiplierDisplayText.changeText("x" + e.intGiven);
			if (_multiplierDisplayText.getSize() < 40){
				_multiplierDisplayText.changeSize(_multiplierDisplayText.getSize() + 1);
			}
			_scoreDisplayText.x = _multiplierDisplayText.x + _multiplierDisplayText.width + 20;
		}
		
		private function scoreUpdate(e:IntEvent):void 
		{
			_goalScoreData = e.intGiven;
			addTag(Tags.UPDATE_TAG);
		}
		
		override public function update():void 
		{
			super.update();
			if (_goalScoreData > _currentScoreData) {
				_currentScoreData += Math.round((100 * ScoreCalculator.scoreMultiplier) * (1 + 1 - _currentScoreData / _goalScoreData));
				if (_currentScoreData >= _goalScoreData) {
					_currentScoreData = _goalScoreData;
					removeTag(Tags.UPDATE_TAG);
				}
				_scoreDisplayText.changeText("SCORE: " + _currentScoreData);
			}
		}
		
		
		override public function destroy():void 
		{
			stage.removeEventListener(ScoreCalculator.SCORE_UPDATED, scoreUpdate);
			stage.removeEventListener(ScoreCalculator.MULTIPLIER_UPDATED, multiplierUpdate);
			
			super.destroy();
		}
		
	}

}