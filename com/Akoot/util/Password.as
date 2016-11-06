package com.Akoot.util
{
	import flash.display.MovieClip;

    public class Password extends MovieClip
    {
        public var username:String;
        public var password:String;
        public var displayname:String;
        public var isEnabled:Boolean;

        public function Password(d:String = null, u:String = null, p:String = null)
        {
			username = u;
			displayname = d;
			password = p;
            isEnabled = true;
        }

        public function encrypt():void
        {
            //fooled ya
        }

        public function decrypt():void
        {
            //fooled ya
        }

        public function enable(en:Boolean):void
        {
            isEnabled = en;
        }
    }
}
