package com.Akoot.util
{
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.geom.Rectangle;

	public class Misc
	{
		public static function getStringWidth(msg:String, tf:TextFormat):Number
		{
			var textField:TextField = new TextField();
			textField.defaultTextFormat = tf;
			textField.text = msg;

			return new Rectangle(0, 0, textField.textWidth, textField.textHeight).width;
		}
	}
}