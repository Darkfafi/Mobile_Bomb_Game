package 
{
	import bomb.Bomb;
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import gameControlEngine.GameController;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	import screens.gameScreens.GameScreen;
	import screens.gameScreens.MenuScreen;
	import screens.ScreenConstants;
	import screens.ScreenManager;
	import screens.StringScreenEvent;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{	
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			//stage.addEventListener(TouchEvent.TOUCH_TAP, onTap);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			
			// entry point
			var gameController : GameController = new GameController(stage);
			var screenManager : ScreenManager = new ScreenManager(stage);
			
			screenManager.addScreen(MenuScreen, ScreenConstants.MENU_SCREEN);
			screenManager.addScreen(GameScreen, ScreenConstants.GAME_SCREEN);
			
			var event : Event = new StringScreenEvent(ScreenManager.SWITCH_SCREEN, ScreenConstants.GAME_SCREEN);
			
			stage.dispatchEvent(event);
			
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (e.target is DisplayObject) {
				var sprite : DisplayObject = e.target as DisplayObject;
				
				if (sprite.parent is GameObject) {
					var gameObj : GameObject = sprite.parent as GameObject;
					
					if (gameObj.checkTag(Tags.INTERACTIVE_TAG)) {
						gameObj.onInteraction();
					}
				}
			}
		}
		
		private function onTap(e:TouchEvent):void 
		{
			if (e.target is DisplayObject) {
				var sprite : DisplayObject = e.target as DisplayObject;
				
				if (sprite.parent is GameObject) {
					var gameObj : GameObject = sprite.parent as GameObject;
					if (gameObj.checkTag(Tags.INTERACTIVE_TAG)) {
						gameObj.onInteraction();
					}
				}
			}
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}