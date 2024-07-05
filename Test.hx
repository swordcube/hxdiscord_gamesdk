import haxe.Int64Helper;
import discord.GameSDK;

function main() {
	var result = GameSDK.create('1257932902268928020');
	trace(result);
	if (result != Ok) return;

	GameSDK.updateActivity({
		assets: {
			largeImage: 'icon'
		},
		timestamps: {
			start: Int64Helper.fromFloat(Date.now().getTime())
		}
	});

	while (true) {
		var result = GameSDK.runCallbacks();
		if (result != Ok) trace(result);

		Sys.sleep(0.4);
	}
}