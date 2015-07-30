package screens 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import gameControlEngine.GameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Screen extends Sprite
	{
		
		public function Screen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			onScreenAdded();
		}
		
		protected function onScreenAdded():void { }
		
		public function update() : void{}

		public function destroy() : void {
			
			//remove all eventlisteners first (before the super)!
			
			var l : int = this.numChildren;
			var cur : DisplayObject;
			
			for (var i : int = l - 1; i >= 0; i--) {
				cur = getChildAt(i);
				if(cur is GameObject) {
					var gObj : GameObject = cur as GameObject;
					gObj.removeObject();
				}
				else if (cur is Sprite) {
					removeChild(cur);
				}
			}
			cur = null;
			i = l = NaN;
		}
		
	}

}