#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>

int main(void)
{
  //Watchdog wdt;
  DDRD |= 0xff;

  while(true)
  {
    PORTD &= 0x00;
    _delay_ms(1500);

    PORTD |= 0xff;
    _delay_ms(1500);

    //wdt.reset();
    // TODO
  }
}

