#pragma once

#define HL_NAME(n) discord_##n
#include <hl.h>

#include <discord.h>

#define _RESULT _I32
#define _USERID _I64

using vresult = int;
using vuid = int64_t;