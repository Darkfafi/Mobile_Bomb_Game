package gameControlEngine 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import screens.Screen;
	import screens.ScreenEvent;
	import screens.ScreenManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameController 
	{
		public var gameRunning : Boolean = true;
		
		private var _collisionSystem : CollisionSystem = new CollisionSystem();
		
		private var _world : DisplayObjectContainer;
		private var _gameObjects : Array = [];
		private var _currentScreen : Screen;
		
		public function GameController(world : DisplayObjectContainer) 
		{
			_world = world;
			_world.addEventListener(GameObject.ADDED, objectAdded);
			_world.addEventListener(GameObject.REMOVED, objectRemoved);
			_world.addEventListener(ScreenManager.SCREEN_SWITCHED, newScreen);
			_world.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function newScreen(e:ScreenEvent):void 
		{
			_currentScreen = e.screen;
		}
		
		private function objectRemoved(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				/*
				if(object.checkTag(Tags.COLLIDER_TAG)){
					_collisionSystem.checkDeletedObjInCollision(object);
				}*/
				var index : int = _gameObjects.indexOf(object);
				_gameObjects.splice(index, 1);
			}
		}
		
		private function objectAdded(e:Event):void 
		{
			if (e.target is GameObject) {
				var object : GameObject = e.target as GameObject;
				//object.parent.setChildIndex(object);
				_gameObjects.push(object);
			}
		}
		
		private function update(e:Event):void 
		{
			if(gameRunning){
				_collisionSystem.checkCollision(_gameObjects);
				var l : int = _gameObjects.length;
				for (var i : int = l - 1; i >= 0; i--) {
					var object : GameObject = _gameObjects[i] as GameObject;
					if(object != null){
						if (object.checkTag(Tags.UPDATE_TAG)) {
							object.update();
						}
					}
				}
				if (_currentScreen != null) {
					_currentScreen.update();
				}
			}
		}
		
		public function lisOfObjectType(object : Class) :Array {
			var list : Array = [];
			for (var i : int =  _gameObjects.length - 1; i >= 0; i--) {
				if (_gameObjects[i] is object) {
					list.push(_gameObjects[i]);
				}
			}
			return list;
		}
		
		public function destroy() :void {
			var l : int = _gameObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				_gameObjects[i].removeObject();
			}
			_world.removeEventListener(GameObject.ADDED, objectAdded);
			_world.removeEventListener(GameObject.REMOVED, objectRemoved);
		}
	}
}