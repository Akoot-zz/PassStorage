package
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;

	public class PassStorage extends MovieClip
	{
		public function PassStorage()
		{
		}
		
		public static function setColor(mc: MovieClip, color: uint): void
		{
			mc.transform.colorTransform = getColorTransform(color);
		}
		
		public static function getColorTransform(color: uint): ColorTransform
		{
			var c: ColorTransform = new ColorTransform();
			c.color = color;
			return c;
		}
	}
}