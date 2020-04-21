#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"

int main(void)
{
  Watchdog wdt;

  while(true)
  {
    wdt.reset();
    // TODO
  }
}

