package com.Akoot.util
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;

	public class Color
	{
		public function Color()
		{
			// constructor code
		}

		public static function getColorTransform(color: uint): ColorTransform
		{
			var c: ColorTransform = new ColorTransform();
			c.color = color;
			return c;
		}

		public static function setColor(mc: MovieClip, color: uint): void
		{
			mc.transform.colorTransform = getColorTransform(color);
		}

		public static function randomColor(): uint
		{
			return randomColorB(0);
		}

		public static function randomColorB(brightness: Number): uint
		{
			var r: Number = ((Random.random(0, 255)) + ((brightness / 10) * 255)) / 10;
			var g: Number = ((Random.random(0, 255)) + ((brightness / 10) * 255)) / 10;
			var b: Number = ((Random.random(0, 255)) + ((brightness / 10) * 255)) / 10;
			
			trace("r:" + r + ",g:" + g + ",b:" + b);

			var color: uint = r << 16 | g << 8 | b;
			return color;
		}
	}
}