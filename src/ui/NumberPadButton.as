package ui 
{
	import events.IntEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import gameControlEngine.GameObject;
	import gameControlEngine.Tags;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class NumberPadButton extends GameObject 
	{	
		private var _padInterface : NumberPadInterface;
		private var _padNumber : int; 
		private var _textFormat : TextFormat = new TextFormat();
		private var _textField : TextField = new TextField();
		private var _artNumberButton : Sprite = new Sprite();
		
		public function NumberPadButton(padNumber : int,numPadButtonHolder : NumberPadInterface) 
		{
			super();
			addTag(Tags.INTERACTIVE_TAG);
			_padInterface = numPadButtonHolder;
			_artNumberButton.graphics.beginFill(0x666666);
			_artNumberButton.graphics.drawRect(0, 0, 35, 60);
			_artNumberButton.graphics.endFill();
			
			_padNumber = padNumber;
			
			_textFormat.align = TextFormatAlign.CENTER;
			_textFormat.size = 20;
			
			_textField.width = _artNumberButton.width;
			_textField.selectable = false;
			_textField.defaultTextFormat = _textFormat;
			_textField.text = _padNumber.toString();	
			
			_textField.y = Math.round((_textField.height / 2 - _textField.textHeight) / 2);
			
			addChild(_artNumberButton);
			addChild(_textField);
			
		}
		
		override public function onInteraction():void 
		{
			super.onInteraction();
			_padInterface.numButtonPressed(_padNumber);
		}
		
	}
}