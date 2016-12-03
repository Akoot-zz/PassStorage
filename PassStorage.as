package
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.net.SharedObject;
	import com.Akoot.ui.TopBar;
	import com.Akoot.util.Account;
	import com.Akoot.util.Password;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.events.NativeProcessExitEvent;

	public class PassStorage extends MovieClip
	{
		public static var ACCOUNTS: Vector.<Account>;
		public static var ACCOUNT: Account;
		public static var STAGE: Stage;
		private static var SO: SharedObject;
		private static var xmlFile: File;
		
		public function PassStorage()
		{
			SO = SharedObject.getLocal("psdb");
			xmlFile = File.applicationStorageDirectory;
			xmlFile = xmlFile.resolvePath("psdb.xml");
			gotoAndStop(1, "load");
		}
		
		public static function encryptFile(file: File, key: String, encrypt: Boolean): void
		{
			var command: Vector.<String> = new Vector.<String>();
			if(encrypt) command.push("--encrypt-file");
			else command.push("--decrypt-file");
			command.push(file.nativePath);
			command.push("-key");
			command.push(key);
			
			trace("using command: " + command);
			
			var nativeProcessStartupInfo: NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var file: File = File.applicationDirectory.resolvePath("lib/akoot-lib.exe");
			nativeProcessStartupInfo.executable = file;
			nativeProcessStartupInfo.arguments = command;
			var process: NativeProcess = new NativeProcess();
			process.start(nativeProcessStartupInfo);
			process.addEventListener(NativeProcessExitEvent.EXIT, finished);
			function finished(): void 
			{
				if(encrypt) 
				{
					trace("Finished encryption");
					STAGE.dispatchEvent(new Event("finishEncryption"));
				}
				else
				{
					trace("Finished decryption");
					STAGE.dispatchEvent(new Event("finishDecryption"));
				}
				
			}
		}
		
		public static function encryptAccounts(): void
		{
			encryptFile(xmlFile, SO.data.key, true);
		}
		
		public static function decryptAccounts(): void
		{
			encryptFile(xmlFile, SO.data.key, false);
		}

		public static function loadAccounts(): void
		{
			trace("Loading accounts..");
			ACCOUNTS = new Vector.<Account>();
			var stream: FileStream = new FileStream();
			stream.open(xmlFile, FileMode.READ);

			var accs: XML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();

			for each(var acc in accs.account)
			{
				var newAccount: Account = new Account();
				newAccount.passwords = new Vector.<Password>();
				newAccount.username = acc.username;
				newAccount.PIN = acc.pin;
				for each(var item in acc.item)
				{
					newAccount.addPassword(new Password(item.displayname, item.username, item.password));
				}
				ACCOUNTS.push(newAccount);
			}
			STAGE.dispatchEvent(new Event("finishLoading"));
		}
		
		public static function saveAccounts(): void
		{
			trace("Saving accounts..");
			var accounts:XML = XML(<accounts></accounts>);
			var xmlString: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
			
			for each(var acc in ACCOUNTS)
			{
				if(acc.username == ACCOUNT.username) acc = ACCOUNT;
				var user: String = acc.username;
				var pin: String = acc.PIN;
				var color: String = acc.color;
				var bgcolor: String = acc.bgcolor;
				var items:XML = XML(<account><username>{user}</username><pin>{pin}</pin><color>{color}</color><bgcolor>{bgcolor}</bgcolor></account>);
				for each(var pass in acc.passwords)
				{
					var d: String = pass.displayname;
					var u: String = pass.username;
					var p: String = pass.password;
					items.appendChild(<item><displayname>{d}</displayname><username>{u}</username><password>{p}</password></item>)
				}
				accounts.appendChild(items);
			}
			trace("[begin XML]");
			trace(accounts);
			trace("[end XML]");
			xmlString += accounts.toXMLString();
			xmlString = xmlString.replace(/\n/g, File.lineEnding);
			
			var stream: FileStream = new FileStream();
			stream.open(xmlFile, FileMode.WRITE);
			stream.writeUTFBytes(xmlString);
			stream.close();
			STAGE.dispatchEvent(new Event("finishSaving"));
		}
		
		public static function signedInAccount(): Account
		{
			var account: Account;
			for each(var acc in ACCOUNTS)
			{
				if(acc.username == SO.data.account)
				{
					return acc;
				}
			}
			return null;
		}
		
		public static function setColorScheme(color: uint, bgcolor: uint): void
		{
			ACCOUNT.color = color;
			ACCOUNT.bgcolor = bgcolor;
			saveAccounts();
		}
		
		public static function setAccount(account: Account): void
		{
			ACCOUNT = account;
			if(account == null) SO.data.account = "";
			else SO.data.account = account.username;
			SO.flush();
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
		
		public static function closeWindow(): void
		{
			trace("Closing the window...");
			STAGE.addEventListener("finishSaving", function encrypt(): void
			{
				trace("Encrypting...");
				encryptAccounts();		
			});
			STAGE.addEventListener("finishEncryption", function close(): void
			{
				trace("Really closing the window...");
				NativeApplication.nativeApplication.exit(0);
			});
			saveAccounts();
		}
	}
}