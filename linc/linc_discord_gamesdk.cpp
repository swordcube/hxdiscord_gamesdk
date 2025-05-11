#include "hxcpp.h"

#include "linc_discord_gamesdk.h"

discord::Core* core{};
discord::Activity activity{};

result discord_core::create(int64_t clientId, uint64_t flags) {
	return (result)discord::Core::Create(clientId, flags, &core);
}

void discord_core::shutdown() {
	discord::Core::Shutdown();
}

result discord_core::runCallbacks() {
	return (result)core->RunCallbacks();
}

result discord_activity::registerCommand(const char* command) {
	return (result)core->ActivityManager().RegisterCommand(command);
}

result discord_activity::registerSteam(uint32_t steamId) {
	return (result)core->ActivityManager().RegisterSteam(steamId);
}

void discord_activity::updateActivity(int type, int64_t applicationId,
const char* name, const char* state, const char* details,
int64_t timestamps_start, int64_t timestamps_end,
const char* assets_largeImage, const char* assets_largeText, const char* assets_smallImage, const char* assets_smallText,
const char* party_id, int32_t party_size_currentSize, int32_t party_size_maxSize, int party_privacy,
const char* secrets_match, const char* secrets_join, const char* secrets_spectate,
bool instance, uint32_t supportedPlatforms) {
	activity.SetType((discord::ActivityType)type);
	activity.SetApplicationId(applicationId);
	activity.SetName(name);
	activity.SetState(state);
	activity.SetDetails(details);
	activity.GetTimestamps().SetStart(timestamps_start);
	activity.GetTimestamps().SetEnd(timestamps_end);
	activity.GetAssets().SetLargeImage(assets_largeImage);
	activity.GetAssets().SetLargeText(assets_largeText);
	activity.GetAssets().SetSmallImage(assets_smallImage);
	activity.GetAssets().SetSmallText(assets_smallText);
	activity.GetParty().SetId(party_id);
	activity.GetParty().GetSize().SetCurrentSize(party_size_currentSize);
	activity.GetParty().GetSize().SetMaxSize(party_size_maxSize);
	activity.GetParty().SetPrivacy((discord::ActivityPartyPrivacy)party_privacy);
	activity.GetSecrets().SetMatch(secrets_match);
	activity.GetSecrets().SetJoin(secrets_join);
	activity.GetSecrets().SetSpectate(secrets_spectate);
	activity.SetInstance(instance);
	activity.SetSupportedPlatforms(supportedPlatforms);

	core->ActivityManager().UpdateActivity(activity, [](discord::Result result) {
		// TODO: wrap callbacks
	});
}