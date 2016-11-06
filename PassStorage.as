package
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.net.SharedObject;
	import com.Akoot.ui.TopBar;
	import com.Akoot.util.Account;
	import com.Akoot.util.Password;

	public class PassStorage extends MovieClip
	{
		public static var STORAGE: SharedObject = SharedObject.getLocal("psdb");
		public static var COLOR: uint;

		public function PassStorage()
		{
			gotoAndStop(1, "load");
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