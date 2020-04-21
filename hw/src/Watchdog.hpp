#pragma once
#include "config.hpp"
#include <avr/wdt.h>

struct Watchdog
{
  Watchdog() { wdt_enable(WDTO_120MS); }
  ~Watchdog() { wdt_disable(); }
  void reset() { wdt_reset(); }
};
