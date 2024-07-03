#include "discord.h"

#include <stdint.h>

using namespace discord;

namespace linc {
	namespace discord {
		using result = int;

		extern result create(int64_t clientId, uint64_t flags);

		extern result runCallbacks();

		extern result registerCommand(const char* command);

		extern result registerSteam(uint32_t steamId);

		extern void updateActivity(int type, int64_t applicationId,
		const char* name, const char* state, const char* details,
		int64_t timestamps_start, int64_t timestamps_end,
		const char* assets_largeImage, const char* assets_largeText, const char* assets_smallImage, const char* assets_smallText,
		const char* party_id, int32_t party_size_currentSize, int32_t party_size_maxSize, int party_privacy,
		const char* secrets_match, const char* secrets_join, const char* secrets_spectate,
		bool instance, uint32_t supportedPlatforms);
	}
}