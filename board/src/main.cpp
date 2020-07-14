#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>
#include "Direction.hpp"
#include "read_program.hpp"
#include "execute_program.hpp"


namespace
{

inline void start_delay()
{
  for(auto i=0; i<5; ++i)
  {
    _delay_ms(100);
    Watchdog::reset();
  }
}

}


int main(void)
{
  Direction dirs[32];
  Buttons::init();
  Watchdog::init();

  while(true)
  {
    Watchdog::reset();
    read_program(dirs);
    start_delay();
    execute_program(dirs);
  }
}
