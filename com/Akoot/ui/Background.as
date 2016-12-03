package com.Akoot.ui
{
	import flash.display.MovieClip;
	import com.Akoot.util.Color;
	import flash.display.Loader;
	import flash.net.URLRequest;

	public class Background extends MovieClip
	{
		public function Background()
		{

		}

		public function setColor(color: uint): void
		{
			Color.setColor(this, color);
		}

		public function setTexture(url: String): void
		{
			var i: Loader = new Loader();
			i.load(new URLRequest(url));
			this.addChild(i);
		}
	}
}