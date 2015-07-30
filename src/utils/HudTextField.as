package utils 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HudTextField extends Sprite 
	{
		private var _perfectFitWidth : Number = 0;
		private var _perfectFitHeight : Number = 0;
		
		private var format : TextFormat = new TextFormat("Palatino");
		private var textField : TextField = new TextField();
		
		public function HudTextField(text : String = "", size : int = 20,color : uint = 0x000000,customFormat : TextFormat = null) 
		{
			if (customFormat != null) {
				format = customFormat;
			}
			format.size = size;
			format.color = color;
			textField.defaultTextFormat = format;
			textField.multiline = true;
			textField.selectable = false;
			textField.text = text;
			setWidthAndHeight();
			addChild(textField);
		}
		
		public function changeText(text : String) :void {
			textField.htmlText = text;
			setWidthAndHeight();
		}
		public function changeColor(color : uint) :void{
			format.color = color;
			textField.setTextFormat(format);
		}
		public function changeSize(size : int) :void{
			format.size = size;
			textField.setTextFormat(format);
			setWidthAndHeight();
		}
		
		public function getSize() : int {
			return int(format.size);
		}
		
		public function setTextAlign(textAlign : String) : void {
			format.align = textAlign;
			textField.setTextFormat(format);
		}
		
		public function setPerfectFitWidth(value : Number) : void {
			_perfectFitWidth = value;
			setWidthAndHeight();
		}
		
		public function setPerfectFitHeight(value : Number) : void {
			_perfectFitHeight = value;
			setWidthAndHeight();
		}
		
		private function measureString(str:String, format:TextFormat):Rectangle {
			var textField:TextField = new TextField();
			//textField.autoSize = TextFieldAutoSize.LEFT;
			textField.defaultTextFormat = format;
			textField.text = str;
			return new Rectangle(0, 0, textField.textWidth + 3, textField.textHeight + 3);
		}
		
		private function setWidthAndHeight() : void {
			//(val % 2 == 1) ? "Number is odd" : "Number is even";
			textField.width = (_perfectFitWidth == 0) ? measureString(textField.text, format).width : _perfectFitWidth;
			textField.height = (_perfectFitHeight == 0) ? measureString(textField.text, format).height : _perfectFitHeight;
		}
	}
}