#pragma once

#include "core.h"

discord::Activity activity{};

HL_PRIM vresult HL_NAME(registerCommand)(vbyte* command) {
	if (core == nullptr) return -1;
	return (vresult)core->ActivityManager().RegisterCommand((const char*)command);
}

HL_PRIM vresult HL_NAME(registerSteam)(uint32_t steamId) {
	if (core == nullptr) return -1;
	return (vresult)core->ActivityManager().RegisterSteam(steamId);
}

HL_PRIM void HL_NAME(updateActivity)(int type, int64_t applicationId,
vbyte* name, vbyte* state, vbyte* details,
int64_t timestamps_start, int64_t timestamps_end,
vbyte* assets_largeImage, vbyte* assets_largeText, vbyte* assets_smallImage, vbyte* assets_smallText,
vbyte* party_id, int32_t party_size_currentSize, int32_t party_size_maxSize, int party_privacy,
vbyte* secrets_match, vbyte* secrets_join, vbyte* secrets_spectate,
bool instance, uint32_t supportedPlatforms) {
	if (core == nullptr) return;

	activity.SetType((discord::ActivityType)type);
	activity.SetApplicationId(applicationId);
	activity.SetName((const char*)name);
	activity.SetState((const char*)state);
	activity.SetDetails((const char*)details);
	activity.GetTimestamps().SetStart(timestamps_start);
	activity.GetTimestamps().SetEnd(timestamps_end);
	activity.GetAssets().SetLargeImage((const char*)assets_largeImage);
	activity.GetAssets().SetLargeText((const char*)assets_largeText);
	activity.GetAssets().SetSmallImage((const char*)assets_smallImage);
	activity.GetAssets().SetSmallText((const char*)assets_smallText);
	activity.GetParty().SetId((const char*)party_id);
	activity.GetParty().GetSize().SetCurrentSize(party_size_currentSize);
	activity.GetParty().GetSize().SetMaxSize(party_size_maxSize);
	activity.GetParty().SetPrivacy((discord::ActivityPartyPrivacy)party_privacy);
	activity.GetSecrets().SetMatch((const char*)secrets_match);
	activity.GetSecrets().SetJoin((const char*)secrets_join);
	activity.GetSecrets().SetSpectate((const char*)secrets_spectate);
	activity.SetInstance(instance);
	activity.SetSupportedPlatforms(supportedPlatforms);

	core->ActivityManager().UpdateActivity(activity, [](discord::Result result) {
		// TODO: wrap callbacks
	});
}

// TODO: wrap events

DEFINE_PRIM(_RESULT, registerCommand, _BYTES);
DEFINE_PRIM(_RESULT, registerSteam, _I32);
DEFINE_PRIM(_VOID, updateActivity, _I32 _I64
	_BYTES _BYTES _BYTES
	_I64 _I64
	_BYTES _BYTES _BYTES _BYTES
	_BYTES _I32 _I32 _I32
	_BYTES _BYTES _BYTES
	_BOOL _I32);