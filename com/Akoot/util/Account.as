package com.Akoot.util
{
    public class Account
    {
        public var username:String;
        public var PIN:int;
        public var passwords:Vector.<Password>;

        public function Account()
        {
            //default constructor
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
