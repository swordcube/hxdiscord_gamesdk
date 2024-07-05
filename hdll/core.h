#pragma once

#include "discordwrap.h"

discord::Core* core{};

HL_PRIM vresult HL_NAME(create)(int64_t clientId, uint64_t flags) {
	return (vresult)discord::Core::Create(clientId, flags, &core);
}

HL_PRIM vresult HL_NAME(runCallbacks)() {
	if (core == nullptr) return -1;
	return (vresult)core->RunCallbacks();
}

// TODO: setLogHook

DEFINE_PRIM(_RESULT, create, _I64 _I64);
DEFINE_PRIM(_RESULT, runCallbacks, _NO_ARG);