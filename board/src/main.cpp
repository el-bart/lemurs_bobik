#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>

// LEFT  SEQ: PD0 PD2 PD1 PD3
// RIGHT SEQ: PB0 PB2 PB1 PB3
// min  - 15[ms] per step!
// good - 30[ms] per step!

// BUT_UP:    PD6
// BUT_DOWN:  PB4
// BUT_LEFT:  PD4
// BUT_RIGHT: PD5

// BUT_START: PA0


template<typename F>
void turn_if(F&& f)
{
  while(true)
  {
    if( f() )
    {
      PORTD &= ~( _BV(PD0) | _BV(PD1) | _BV(PD2) | _BV(PD3) );
      PORTB &= ~( _BV(PB0) | _BV(PB1) | _BV(PB2) | _BV(PB3) );
      continue;
    }

    constexpr int seq[] = {0,2,1,3};
    for(auto bit: seq)
    {
      PORTD = _BV(bit);
      PORTB = _BV(bit);
      _delay_ms(30);
    }
  }
}

int main(void)
{
  //Watchdog wdt;
  DDRD |= _BV(PD0) | _BV(PD1) | _BV(PD2) | _BV(PD3);
  DDRB |= _BV(PB0) | _BV(PB1) | _BV(PB2) | _BV(PB3);

  // UP button
#if 1
  DDRD  &= ~_BV(6);
  PORTD |=  _BV(6);
  turn_if( [] { return PIND & _BV(6); } );
#endif

  // DOWN button
#if 0
  DDRB  &= ~_BV(4);
  PORTB |=  _BV(4);
  turn_if( [] { return PINB & _BV(4); } );
#endif

  // LEFT button
#if 0
  DDRD  &= ~_BV(4);
  PORTD |=  _BV(4);
  turn_if( [] { return PIND & _BV(4); } );
#endif

  // RIGHT button
#if 0
  DDRD  &= ~_BV(5);
  PORTD |=  _BV(5);
  turn_if( [] { return PIND & _BV(5); } );
#endif

  // START button
#if 0
  DDRA  &= ~_BV(0);
  PORTA |=  _BV(0);
  turn_if( [] { return PINA & _BV(0); } );
#endif

  while(true) { }

  //while(true)
  for(auto i=0; i<(1*30)/4; ++i)
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

  PORTD = 0x00;
  PORTB = 0x00;
}

