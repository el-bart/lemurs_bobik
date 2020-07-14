#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>
#include "Buttons.hpp"

// LEFT  SEQ: PD0 PD2 PD1 PD3
// RIGHT SEQ: PB0 PB2 PB1 PB3
// min  - 15[ms] per step!
// good - 30[ms] per step!


void turn_both(const int (&left)[4], const int (&right)[4])
{
  for(auto i=0; i<4; ++i)
  {
      PORTD = _BV(left[i]);
      PORTB = _BV(right[i]);
      _delay_ms(30);
  }
}


void full_stop()
{
  PORTD &= ~( _BV(PD0) | _BV(PD1) | _BV(PD2) | _BV(PD3) );
  PORTB &= ~( _BV(PB0) | _BV(PB1) | _BV(PB2) | _BV(PB3) );
}


void turn_steps(const int (&left)[4], const int (&right)[4])
{
  turn_both(left, right);
  full_stop();
}


int main(void)
{
  Buttons::init();

  //Watchdog wdt;
  DDRD |= _BV(PD0) | _BV(PD1) | _BV(PD2) | _BV(PD3);
  DDRB |= _BV(PB0) | _BV(PB1) | _BV(PB2) | _BV(PB3);

  constexpr int fwd[] = {0,2,1,3};
  constexpr int rev[] = {fwd[3], fwd[2], fwd[1], fwd[0]};

  while(true)
  {
    if( Buttons::up_pressed() )
    {
      turn_steps(fwd, fwd);
      continue;
    }
    if( Buttons::down_pressed() )
    {
      turn_steps(rev, rev);
      continue;
    }
    if( Buttons::left_pressed() )
    {
      turn_steps(fwd, rev);
      continue;
    }
    if( Buttons::right_pressed() )
    {
      turn_steps(rev, fwd);
      continue;
    }

    if( Buttons::start_pressed() )
    {
      turn_steps(fwd, fwd);
      turn_steps(rev, rev);
      continue;
    }
  }

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

