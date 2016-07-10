package com.Akoot.util
{
	public class Random
	{
		public static function random(min:Number, max:Number):Number
		{
			return min + (max - min) * Math.random();
		}
	}
}