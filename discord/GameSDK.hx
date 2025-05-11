package discord;

import haxe.Int64Helper;
#if cpp
import cpp.UInt32;
import cpp.ConstCharStar;
#elseif hl
import hl.Bytes;
#end
import haxe.Int32;
import haxe.Int64;

#if cpp
private typedef NativeGameSDK = CppGameSDK;
#elseif hl
private typedef NativeGameSDK = HlGameSDK;
#end

private abstract NativeString(#if cpp ConstCharStar #elseif hl Bytes #else Dynamic #end) to #if cpp ConstCharStar #elseif hl Bytes #else Dynamic #end {
	public function new(s:String) {
		#if cpp
		this = new ConstCharStar(s);
		#elseif hl
		@:privateAccess
		this = (s ?? '').toUtf8();
		#else
		this = null;
		#end
	}
}

class GameSDK {
	public static function create(clientId:String, flags:CreateFlags = NoRequireDiscord):Result {
		return NativeGameSDK.create(Int64Helper.parseString(clientId), flags);
	}

	public static function shutdown():Void {
		NativeGameSDK.shutdown();
	}

	public static function runCallbacks():Result {
		return NativeGameSDK.runCallbacks();
	}

	public static function registerCommand(command:String):Result {
		return NativeGameSDK.registerCommand(new NativeString(command ?? ''));
	}

	public static function registerSteam(steamId:Int32):Result {
		return NativeGameSDK.registerSteam(steamId);
	}

	public static function updateActivity(activity:Activity) {
		return NativeGameSDK.updateActivity(activity.type ?? 0, activity.applicationId ?? 0i64,
		new NativeString(activity.name ?? ''), new NativeString(activity.state ?? ''), new NativeString(activity.details ?? ''),
		activity.timestamps?.start ?? 0i64, activity.timestamps?.end ?? 0i64,
		new NativeString(activity.assets?.largeImage ?? ''), new NativeString(activity.assets?.largeText ?? ''), new NativeString(activity.assets?.smallImage ?? ''), new NativeString(activity.assets?.smallText ?? ''),
		new NativeString(activity.party?.id ?? ''), activity.party?.size?.currentSize ?? 0i32, activity.party?.size?.maxSize ?? 0i32, activity.party?.privacy ?? 0,
		new NativeString(activity.secrets?.match ?? ''), new NativeString(activity.secrets?.join ?? ''), new NativeString(activity.secrets?.spectate ?? ''),
		activity.instance ?? false, (cast activity.supportedPlatforms : Int32) ?? 0i32);
	}
}

enum abstract Result(Int) from Int to Int {
	var Ok                              = 0;
	var ServiceUnavailable              = 1;
	var InvalidVersion                  = 2;
	var LockFailed                      = 3;
	var InternalError                   = 4;
	var InvalidPayload                  = 5;
	var InvalidCommand                  = 6;
	var InvalidPermissions              = 7;
	var NotFetched                      = 8;
	var NotFound                        = 9;
	var Conflict                        = 10;
	var InvalidSecret                   = 11;
	var InvalidJoinSecret               = 12;
	var NoEligibleActivity              = 13;
	var InvalidInvite                   = 14;
	var NotAuthenticated                = 15;
	var InvalidAccessToken              = 16;
	var ApplicationMismatch             = 17;
	var InvalidDataUrl                  = 18;
	var InvalidBase64                   = 19;
	var NotFiltered                     = 20;
	var LobbyFull                       = 21;
	var InvalidLobbySecret              = 22;
	var InvalidFilename                 = 23;
	var InvalidFileSize                 = 24;
	var InvalidEntitlement              = 25;
	var NotInstalled                    = 26;
	var NotRunning                      = 27;
	var InsufficientBuffer              = 28;
	var PurchaseCanceled                = 29;
	var InvalidGuild                    = 30;
	var InvalidEvent                    = 31;
	var InvalidChannel                  = 32;
	var InvalidOrigin                   = 33;
	var RateLimited                     = 34;
	var OAuth2Error                     = 35;
	var SelectChannelTimeout            = 36;
	var GetGuildTimeout                 = 37;
	var SelectVoiceForceRequired        = 38;
	var CaptureShortcutAlreadyListening = 39;
	var UnauthorizedForAchievement      = 40;
	var InvalidGiftCode                 = 41;
	var PurchaseError                   = 42;
	var TransactionAborted              = 43;
	var DrawingInitFailed               = 44;

	@:to
	public function toString():String {
		switch(this) {
			case Ok: return 'Ok';
			case ServiceUnavailable: return 'ServiceUnavailable';
			case InvalidVersion: return 'InvalidVersion';
			case LockFailed: return 'LockFailed';
			case InternalError: return 'InternalError';
			case InvalidPayload: return 'InvalidPayload';
			case InvalidCommand: return 'InvalidCommand';
			case InvalidPermissions: return 'InvalidPermissions';
			case NotFetched: return 'NotFetched';
			case NotFound: return 'NotFound';
			case Conflict: return 'Conflict';
			case InvalidSecret: return 'InvalidSecret';
			case InvalidJoinSecret: return 'InvalidJoinSecret';
			case NoEligibleActivity: return 'NoEligibleActivity';
			case InvalidInvite: return 'InvalidInvite';
			case NotAuthenticated: return 'NotAuthenticated';
			case InvalidAccessToken: return 'InvalidAccessToken';
			case ApplicationMismatch: return 'ApplicationMismatch';
			case InvalidDataUrl: return 'InvalidDataUrl';
			case InvalidBase64: return 'InvalidBase64';
			case NotFiltered: return 'NotFiltered';
			case LobbyFull: return 'LobbyFull';
			case InvalidLobbySecret: return 'InvalidLobbySecret';
			case InvalidFilename: return 'InvalidFilename';
			case InvalidFileSize: return 'InvalidFileSize';
			case InvalidEntitlement: return 'InvalidEntitlement';
			case NotInstalled: return 'NotInstalled';
			case NotRunning: return 'NotRunning';
			case InsufficientBuffer: return 'InsufficientBuffer';
			case PurchaseCanceled: return 'PurchaseCanceled';
			case InvalidGuild: return 'InvalidGuild';
			case InvalidEvent: return 'InvalidEvent';
			case InvalidChannel: return 'InvalidChannel';
			case InvalidOrigin: return 'InvalidOrigin';
			case RateLimited: return 'RateLimited';
			case OAuth2Error: return 'OAuth2Error';
			case SelectChannelTimeout: return 'SelectChannelTimeout';
			case GetGuildTimeout: return 'GetGuildTimeout';
			case SelectVoiceForceRequired: return 'SelectVoiceForceRequired';
			case CaptureShortcutAlreadyListening: return 'CaptureShortcutAlreadyListening';
			case UnauthorizedForAchievement: return 'UnauthorizedForAchievement';
			case InvalidGiftCode: return 'InvalidGiftCode';
			case PurchaseError: return 'PurchaseError';
			case TransactionAborted: return 'TransactionAborted';
			case DrawingInitFailed: return 'DrawingInitFailed';
			default: return 'Unknown';
		}
	}
}

enum abstract CreateFlags(Int) from Int to Int {
	var Default;
	var NoRequireDiscord;
}

enum abstract ActivityPartyPrivacy(Int) from Int to Int {
	var Private;
	var Public;
}

enum abstract ActivityType(Int) from Int to Int {
	var Playing;
	var Streaming;
	var Listening;
	var Watching;
}

enum abstract ActivitySupportedPlatformFlags(Int) from Int to Int {
	var Desktop = 1;
	var Android = 2;
	var iOS = 4;
}

typedef ActivityTimestamps = {
	?start:Int64,
	?end:Int64
}

typedef ActivityAssets = {
	?largeImage:String,
	?largeText:String,
	?smallImage:String,
	?smallText:String,
}

typedef PartySize = {
	?currentSize:Int32,
	?maxSize:Int32
}

typedef ActivityParty = {
	?id:String,
	?size:PartySize,
	?privacy:ActivityPartyPrivacy
}

typedef ActivitySecrets = {
	?match:String,
	?join:String,
	?spectate:String
}

typedef Activity = {
	?type:ActivityType,
	?applicationId:Int64,
	?name:String,
	?state:String,
	?details:String,
	?timestamps:ActivityTimestamps,
	?assets:ActivityAssets,
	?party:ActivityParty,
	?secrets:ActivitySecrets,
	?instance:Bool,
	?supportedPlatforms:Int32
}

#if cpp
@:keep
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('discord_gamesdk'))
@:include('linc_discord_gamesdk.h')
@:native('discord_gamesdk')
private extern class CppGameSDK {
	@:native('discord_core::create')
	public static function create(clientId:Int64, flags:Int64):Result;

	@:native('discord_core::shutdown')
	public static function shutdown():Void;

	@:native('discord_core::runCallbacks')
	public static function runCallbacks():Result;

	@:native('discord_activity::registerCommand')
	public static function registerCommand(command:ConstCharStar):Result;

	@:native('discord_activity::registerSteam')
	public static function registerSteam(steamId:UInt32):Result;

	@:native('discord_activity::updateActivity')
	public static function updateActivity(type:Int, applicationId:Int64,
	name:ConstCharStar, state:ConstCharStar, details:ConstCharStar,
	timestamps_start:Int64, timestamps_end:Int64,
	assets_largeImage:ConstCharStar, assets_largeText:ConstCharStar, assets_smallImage:ConstCharStar, assets_smallText:ConstCharStar,
	party_id:ConstCharStar, party_size_currentSize:Int32, party_size_maxSize:Int32, party_privacy:Int,
	secrets_match:ConstCharStar, secrets_join:ConstCharStar, secrets_spectate:ConstCharStar,
	instance:Bool, supportedPlatforms:UInt32):Void;
}
#elseif hl
private class HlGameSDK {
	@:hlNative('discord', 'create')
	public static function create(clientId:Int64, flags:Int64):Result {
		return 0;
	}

	@:hlNative('discord', 'shutdown')
	public static function shutdown():Void {}

	@:hlNative('discord', 'runCallbacks')
	public static function runCallbacks():Result {
		return 0;
	}

	@:hlNative('discord', 'registerCommand')
	public static function registerCommand(command:Bytes):Result {
		return 0;
	}

	@:hlNative('discord', 'registerSteam')
	public static function registerSteam(steamId:Int32):Result {
		return 0;
	}

	@:hlNative('discord', 'updateActivity')
	public static function updateActivity(type:Int, applicationid:Int64,
	name:Bytes, state:Bytes, details:Bytes,
	timestamps_start:Int64, timestamps_end:Int64,
	assets_largeImage:Bytes, assets_largeText:Bytes, assets_smallImage:Bytes, assets_smallText:Bytes,
	party_id:Bytes, party_size_currentSize:Int32, party_size_maxSize:Int32, party_privacy:Int,
	secrets_match:Bytes, secrets_join:Bytes, secrets_spectate:Bytes,
	instance:Bool, supportedPlatforms:Int32) {}
}
#end