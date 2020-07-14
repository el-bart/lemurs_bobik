#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>
#include "Buttons.hpp"
#include "Engines.hpp"
#include "Direction.hpp"
#include "read_program.hpp"
#include "execute_program.hpp"


namespace
{

inline void start_delay(Watchdog& wdg)
{
  for(auto i=0; i<5; ++i)
  {
    _delay_ms(100);
    wdg.reset();
  }
}

}


int main(void)
{
  Buttons::init();
  Direction dirs[32];
  Watchdog wdg;

  while(true)
  {
    wdg.reset();
    read_program(dirs, wdg);
    start_delay(wdg);
    execute_program(dirs, wdg);
  }
}
