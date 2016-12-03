package com.Akoot.util
{
    public class Account
    {
        public var username:String;
        public var PIN:int;
        public var passwords:Vector.<Password>;
        public var color:uint;
        public var bgcolor:uint;

        public function Account()
        {
            this.color = 0xE02141;
            this.bgcolor = 0x333333;
        }

        public function setPIN(pin:int):void
        {
            this.PIN = pin;
        }

        public function addPassword(p:Password):void
        {
            passwords.push(p);
        }

        public function removePassword(p:Password):void
        {
            passwords.removeAt(passwords.indexOf(p));
        }
    }
}
