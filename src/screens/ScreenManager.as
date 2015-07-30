package screens 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import screens.gameScreens.MenuScreen;
	import utils.NapoleonArray;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class ScreenManager 
	{	
		public static const SCREEN_SWITCHED : String = "CurrentScreenSwitched";
		public static const SWITCH_SCREEN : String = "SwitchScreenEvent";
		
		private var _world : DisplayObjectContainer;
		
		private var _currentScreen : Screen;
		private var _allScreens : NapoleonArray = new NapoleonArray();
		
		public function ScreenManager(world : DisplayObjectContainer) 
		{
			_world = world;
			
			_world.addEventListener(SWITCH_SCREEN, switchScreenThroughEvent);
		}
		
		private function switchScreenThroughEvent(e:Event):void 
		{
			if (e is StringScreenEvent) {
				var event : StringScreenEvent = e as StringScreenEvent;
				switchScreen(event.screenName);
			}else {
				throw new Error("Event Has to be of the 'SwitchScreenEvent' class");
			}
		}
		
		
		public function addScreen(screenClass : Class, name : String) : void {
			
			var checkingClass : * = new screenClass();
			
			if (checkingClass is Screen) {
				_allScreens.add(screenClass, name);
			}else {
				throw new Error("addScreen function needs a 'Screen' class to be passed or a Class extending the 'Screen' class")
			}
		}
		
		
		public function switchScreen(nameScreen : String) : void {
			if(_currentScreen != null){
				_currentScreen.destroy();
				if(_world.contains(_currentScreen)){
					_world.removeChild(_currentScreen);
				}
				_currentScreen = null;
			}
			
			var screenClass : Class = _allScreens.getDataWithName(nameScreen);
			
			_currentScreen = new screenClass() as Screen;
			_world.addChild(_currentScreen);
			
			var event : ScreenEvent = new ScreenEvent(SCREEN_SWITCHED, _currentScreen, true);
			_world.dispatchEvent(event);
		}
		
		public function get currentScreen():Screen 
		{
			return _currentScreen;
		}
	}
}