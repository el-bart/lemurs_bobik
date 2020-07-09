#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>

// LEFT  SEQ: PD0 PD2 PD1 PD3
// RIGHT SEQ: PB0 PB1 PB2 PB3
// min  - 15[ms] per step!
// good - 30[ms] per step!

// BUT_UP:    PD6
// BUT_DOWN:  PB5
// BUT_LEFT:  PD4
// BUT_RIGHT: PD5

// BUT_START: PA0

int main(void)
{
  //Watchdog wdt;
  DDRD |= _BV(PD0) | _BV(PD1) | _BV(PD2) | _BV(PD3);
  DDRB |= _BV(PB0) | _BV(PB1) | _BV(PB2) | _BV(PB3);


  while(true)
  {
    constexpr int seq[] = {0,2,1,3};
    for(auto bit: seq)
    {
      PORTD = _BV(bit);
      PORTB = _BV(bit);
      _delay_ms(30);
    }

    //_delay_ms(500);

    //wdt.reset();
    // TODO
  }
}

