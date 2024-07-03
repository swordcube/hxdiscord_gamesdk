import haxe.Int64Helper;
import discord.GameSDK;

function main() {
	trace(GameSDK.create('1257306499672182844'));

	GameSDK.updateActivity({
		details: 'testing',
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