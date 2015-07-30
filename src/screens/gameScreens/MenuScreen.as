package screens.gameScreens 
{
	import flash.display.Sprite;
	import screens.Screen;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MenuScreen extends Screen 
	{
		private var _backgroundArt : Sprite = new Sprite();
		
		
		public function MenuScreen() 
		{
			super();
		}
		
		override protected function onScreenAdded():void 
		{
			super.onScreenAdded();
			
			_backgroundArt.graphics.beginFill(0xff0000);
			_backgroundArt.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_backgroundArt.graphics.endFill();
			
			addChild(_backgroundArt);
		}
		
	}

}